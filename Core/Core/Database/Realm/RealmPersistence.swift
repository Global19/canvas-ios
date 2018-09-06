//
// Copyright (C) 2018-present Instructure, Inc.
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, version 3 of the License.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.
//

import Foundation
import RealmSwift

public class RealmPersistence {
    var store: Realm
    static var config: Realm.Configuration = Realm.Configuration.defaultConfiguration

    public convenience init() {
        let config = Realm.Configuration(
            schemaVersion: 1,
            migrationBlock: { _, oldSchemaVersion in
                if (oldSchemaVersion < 1) {
                    // Nothing to do!
                    // Realm will automatically detect new properties and removed properties
                    // And will update the schema on disk automatically
                }
        })
        self.init(configuration: config)
    }

    public required init(configuration: Realm.Configuration) {
        do {
            try store = Realm(configuration: configuration)
        } catch {
            fatalError("\(PersistenceError.failureToInit.description) error: \(error.localizedDescription)")
        }
    }
}

extension RealmPersistence: Persistence {
    public func insert<T>() -> T {
        guard let entity = T.self as? Object.Type,
            let obj = entity.init() as? T else {
                fatalError("\(#function), \(PersistenceError.wrongEntityType) type: \(T.self)")
        }
        return obj
    }

    public func fetchedResultsController<T>(predicate: NSPredicate, sortDescriptors: [NSSortDescriptor]?, sectionNameKeyPath: String?) -> FetchedResultsController<T> {
        fatalError("\(#function) not implemented")
    }

    public func fetch<T>(_ predicate: NSPredicate?) -> [T] {
        return fetch(predicate: predicate, sortDescriptors: nil)
    }

    public func fetch<T>(predicate: NSPredicate?, sortDescriptors: [SortDescriptor]?) -> [T] {
        guard let entityToFetch = T.self as? Object.Type else {
            fatalError("\(#function), \(PersistenceError.wrongEntityType) type: \(T.self)")
        }

        var objects = store.objects(entityToFetch)

        if let predicate = predicate {
            objects = objects.filter(predicate)
        }

        if let sortDescriptors = sortDescriptors {
            let realmDescriptors = sortDescriptors.compactMap {
                return RealmSwift.SortDescriptor(keyPath: $0.key, ascending: $0.ascending)
            }
            objects = objects.sorted(by: realmDescriptors)
        }

        return Array(objects).compactMap { $0 as? T }
    }

    public func addOrUpdate<T>(_ entity: T) throws {
        guard entity is Object else {
            throw PersistenceError.wrongEntityType
        }

        try addOrUpdate([entity])
    }

    public func addOrUpdate<T>(_ entities: [T]) throws {
        guard entities is [Object] else {
            throw PersistenceError.wrongEntityType
        }

        try self.safeWriteAction {
            entities.lazy
                .compactMap { return $0 as? Object }
                .forEach {
                    let canUpdateIfExists = $0.objectSchema.primaryKeyProperty != nil
                    store.add($0, update: canUpdateIfExists)
            }
        }
    }

    public func delete<T>(_ entity: T) throws {
        try delete([entity])
    }

    func delete<T>(_ entities: [T]) throws {
        guard entities is [Object] else {
            throw PersistenceError.wrongEntityType
        }

        try self.safeWriteAction {
            entities.lazy
                .compactMap { return $0 as? Object }
                .forEach { store.delete($0) }
        }
    }

    func deleteAll<T>(_ entityType: T.Type) throws {
        guard let entityToDelete = entityType as? Object.Type else {
            throw PersistenceError.wrongEntityType
        }

        try self.safeWriteAction {
            let objects = store.objects(entityToDelete)

            objects.forEach {
                store.delete($0)
            }
        }
    }

    func safeWriteAction(_ block: (() throws -> Void)) throws {
        if store.isInWriteTransaction {
            try block()
        } else {
            try store.write(block)
        }
    }

    public func perform(block: @escaping PersistenceBlockHandler) throws {
        try safeWriteAction {
            try block(self)
        }
    }

    static public func performBackgroundTask(block: @escaping PersistenceBlockHandler) {
        autoreleasepool {
            let instance = RealmPersistence(configuration: RealmPersistence.config)
            do {
                try instance.safeWriteAction {
                    try block(instance)
                }
            } catch {
                fatalError(error.localizedDescription)
            }
        }
    }

    public func clearAllRecords() throws {
        try safeWriteAction { [weak store] in
            store?.deleteAll()
        }

    }

    public func refresh() {
        store.refresh()
    }
}

public struct SortDescriptor {
    let key: String
    let ascending: Bool

    public init(key: String, ascending: Bool = true) {
        self.key = key
        self.ascending = ascending
    }
}
