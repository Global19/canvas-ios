//
// This file is part of Canvas.
// Copyright (C) 2020-present  Instructure, Inc.
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as
// published by the Free Software Foundation, either version 3 of the
// License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Affero General Public License for more details.
//
// You should have received a copy of the GNU Affero General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.
//

import UIKit

public class AnnouncementListViewController: UIViewController, ColoredNavViewProtocol, ErrorViewController {
    lazy var addButton = UIBarButtonItem(image: .addSolid, style: .plain, target: self, action: #selector(add))
    @IBOutlet weak var emptyMessageLabel: UILabel!
    @IBOutlet weak var emptyTitleLabel: UILabel!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var errorView: ListErrorView!
    @IBOutlet weak var loadingView: CircleProgressView!
    @IBOutlet weak var tableView: UITableView!
    let refreshControl = CircleRefreshControl()
    public var titleSubtitleView = TitleSubtitleView.create()

    public var color: UIColor?
    var context = Context.currentUser
    let env = AppEnvironment.shared
    var selectedFirstTopic: Bool = false

    lazy var colors = env.subscribe(GetCustomColors()) { [weak self] in
        self?.updateNavBar()
    }
    lazy var course = context.contextType == .course ? env.subscribe(GetCourse(courseID: context.id)) { [weak self] in
        self?.updateNavBar()
    } : nil
    lazy var group = context.contextType == .group ? env.subscribe(GetGroup(groupID: context.id)) { [weak self] in
        self?.updateNavBar()
    } : nil
    lazy var topics = env.subscribe(GetAnnouncements(context: context)) { [weak self] in
        self?.update()
    }

    public static func create(context: Context) -> AnnouncementListViewController {
        let controller = loadFromStoryboard()
        controller.context = context
        return controller
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupTitleViewInNavbar(title: NSLocalizedString("Announcements"))

        addButton.accessibilityLabel = NSLocalizedString("Create Announcement")

        emptyMessageLabel.text = NSLocalizedString("It looks like announcements haven’t been created in this space yet.")
        emptyTitleLabel.text = NSLocalizedString("No Announcements")
        errorView.messageLabel.text = NSLocalizedString("There was an error loading announcements. Pull to refresh to try again.")
        errorView.retryButton.addTarget(self, action: #selector(refresh), for: .primaryActionTriggered)

        loadingView.color = nil
        refreshControl.color = nil

        refreshControl.addTarget(self, action: #selector(refresh), for: .primaryActionTriggered)
        tableView.refreshControl = refreshControl
        tableView.separatorColor = .borderMedium

        colors.refresh()
        course?.refresh()
        group?.refresh()
        topics.exhaust()
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.selectRow(at: nil, animated: false, scrollPosition: .none)
        env.pageViewLogger.startTrackingTimeOnViewController()
        navigationController?.navigationBar.useContextColor(color)
    }

    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        env.pageViewLogger.stopTrackingTimeOnViewController(eventName: "\(context.pathComponent)/announcements", attributes: [:])
    }

    @objc func refresh() {
        colors.refresh(force: true)
        course?.refresh(force: true)
        group?.refresh(force: true)
        topics.exhaust(force: true) { [weak self] _ in
            if self?.topics.hasNextPage == false {
                self?.refreshControl.endRefreshing()
            }
            return true
        }
    }

    func updateNavBar() {
        if colors.pending == false,
            let name = course?.first?.name ?? group?.first?.name,
            let color = course?.first?.color ?? group?.first?.color {
            updateNavBar(subtitle: name, color: color)
            view.tintColor = color
        }
        let canAdd = (course?.first?.canCreateAnnouncement ?? group?.first?.canCreateAnnouncement) == true
        navigationItem.rightBarButtonItem = canAdd ? addButton : nil
    }

    func update() {
        loadingView.isHidden = topics.state != .loading || refreshControl.isRefreshing
        emptyView.isHidden = topics.state != .empty
        errorView.isHidden = topics.state != .error
        tableView.reloadData()

        if !selectedFirstTopic, topics.state != .loading, let url = topics.first?.htmlURL {
            selectedFirstTopic = true
            if splitViewController?.isCollapsed == false, !isInSplitViewDetail {
                env.router.route(to: url, from: self, options: .detail)
            }
        }
    }

    @objc func add() {
        env.router.route(
            to: "\(context.pathComponent)/announcements/new",
            from: self,
            options: .modal(.formSheet, isDismissable: false, embedInNav: true)
        )
    }

    func deleteTopic(at indexPath: IndexPath, completionHandler: @escaping (Bool) -> Void) {
        guard let topicID = topics[indexPath]?.id else { return completionHandler(false) }
        let alert = UIAlertController(
            title: NSLocalizedString("Delete Announcement"),
            message: NSLocalizedString("Are you sure you would like to delete this announcement?"),
            preferredStyle: .alert
        )
        alert.addAction(AlertAction(NSLocalizedString("Delete"), style: .destructive) { _ in
            let useCase = DeleteDiscussionTopic(context: self.context, topicID: topicID)
            useCase.fetch { [weak self] _, _, error in performUIUpdate {
                if let error = error { self?.showError(error) }
            } }
        })
        alert.addAction(AlertAction(NSLocalizedString("Cancel"), style: .cancel))
        env.router.show(alert, from: self, options: .modal())
        completionHandler(true)
    }
}

extension AnnouncementListViewController: UITableViewDataSource, UITableViewDelegate {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topics.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: AnnouncementListCell = tableView.dequeue(for: indexPath)
        cell.update(topic: topics[indexPath], isTeacher: course?.first?.hasTeacherEnrollment == true)
        return cell
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let id = topics[indexPath]?.id else { return }
        env.router.route(to: "\(context.pathComponent)/announcements/\(id)", from: self, options: .detail)
    }

    public func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        var actions: [UIContextualAction] = []
        if topics[indexPath]?.canDelete == true {
            let action = UIContextualAction(style: .destructive, title: NSLocalizedString("Delete")) { [weak self] (_, _, handler) in
                self?.deleteTopic(at: indexPath, completionHandler: handler)
            }
            action.backgroundColor = .backgroundDanger
            actions.append(action)
        }
        guard !actions.isEmpty else { return nil }
        let config = UISwipeActionsConfiguration(actions: actions)
        config.performsFirstActionWithFullSwipe = false
        return config
    }
}

class AnnouncementListCell: UITableViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var iconImageView: AccessIconView!
    @IBOutlet weak var titleLabel: UILabel!

    func update(topic: DiscussionTopic?, isTeacher: Bool) {
        iconImageView.icon = .announcementLine
        if isTeacher {
            iconImageView.published = topic?.published == true
        } else {
            iconImageView.state = nil
        }

        titleLabel.text = topic?.title

        if let delayed = topic?.delayedPostAt, delayed > Clock.now {
            iconImageView.icon = .calendarClockLine
            iconImageView.state = nil
            dateLabel.text = String.localizedStringWithFormat(NSLocalizedString("Delayed until %@"), delayed.dateTimeString)
        } else if let replyAt = topic?.lastReplyAt {
            dateLabel.text = String.localizedStringWithFormat(NSLocalizedString("Last post %@"), replyAt.dateTimeString)
        } else {
            dateLabel.text = topic?.postedAt?.dateTimeString
        }
    }
}
