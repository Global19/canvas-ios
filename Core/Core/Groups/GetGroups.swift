//
// This file is part of Canvas.
// Copyright (C) 2018-present  Instructure, Inc.
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

import Foundation
import CoreData

class GetGroups: CollectionUseCase {
    typealias Model = Group
    let context: Context
    let cacheKey: String?
    let request: GetGroupsRequest
    let scope: Scope

    init(context: Context = Context.currentUser) {
        self.context = context
        cacheKey = "\(context.pathComponent)/groups"
        request = GetGroupsRequest(context: context)
        scope = .where(#keyPath(Group.contextRaw), equals: context.canvasContextID)
    }

    func write(response: [APIGroup]?, urlResponse: URLResponse?, to client: NSManagedObjectContext) {
        response?.forEach { item in
            let group = Group.save(item, in: client)
            group.context = context
        }
    }
}

public class GetGroup: APIUseCase {
    public let groupID: String
    public typealias Model = Group

    public var request: GetGroupRequest {
        return GetGroupRequest(id: groupID)
    }

    public var scope: Scope {
        return Scope(predicate: NSPredicate(format: "%K == %@", #keyPath(Group.id), groupID), order: [])
    }

    public var cacheKey: String? {
        return "get-group-\(groupID)"
    }

    public init(groupID: String) {
        self.groupID = groupID
    }
}

public class GetDashboardGroups: CollectionUseCase {
    public typealias Model = Group

    public var cacheKey: String? { "users/self/groups" }
    public var request: GetGroupsRequest { GetGroupsRequest(context: .currentUser) }
    public var scope: Scope { .where(
        #keyPath(Group.showOnDashboard), equals: true,
        sortDescriptors: [
            NSSortDescriptor(key: #keyPath(Group.name), ascending: true, naturally: true),
            NSSortDescriptor(key: #keyPath(Group.id), ascending: true, naturally: true),
        ]
    ) }
}

class GetGroupsInCategory: CollectionUseCase {
    typealias Model = Group
    let cacheKey: String?
    let request: GetGroupsInCategoryRequest
    let scope: Scope

    init(_ groupCategoryID: String?) {
        let groupCategoryID = groupCategoryID ?? ""
        cacheKey = "group_categories/\(groupCategoryID)/groups"
        request = GetGroupsInCategoryRequest(groupCategoryID: groupCategoryID)
        scope = .where(
            #keyPath(Group.groupCategoryID), equals: groupCategoryID,
            orderBy: #keyPath(Group.name), naturally: true
        )
    }

    func makeRequest(environment: AppEnvironment, completionHandler: @escaping ([APIGroup]?, URLResponse?, Error?) -> Void) {
        // Skip making a request for empty groupCategoryID so this can be an empty list
        guard !request.groupCategoryID.isEmpty else { return completionHandler(nil, nil, nil) }
        environment.api.makeRequest(request, callback: completionHandler)
    }

    func write(response: [APIGroup]?, urlResponse: URLResponse?, to client: NSManagedObjectContext) {
        response?.forEach { item in
            Group.save(item, in: client)
        }
    }
}
