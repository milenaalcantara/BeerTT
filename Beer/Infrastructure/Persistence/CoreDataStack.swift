//
//  CoreDataStack.swift
//  Beer
//
//  Created by Milena Alcântara on 20/11/25.
//

import CoreData

final class CoreDataStack {

    // MARK: - Singleton (opcional)
    static let shared = CoreDataStack(modelName: "Beer")

    // MARK: - Properties
    private let persistentContainer: NSPersistentContainer

    var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }

    // MARK: - Init
    init(modelName: String,
         inMemory: Bool = false) {

        persistentContainer = NSPersistentContainer(name: modelName)

        if inMemory {
            persistentContainer.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }

        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("❌ Failed to load CoreData store: \(error)")
            }

            self.persistentContainer.viewContext.mergePolicy =
                NSMergeByPropertyObjectTrumpMergePolicy
        }
    }

    // MARK: - Saving
    func saveContext() {
        let context = persistentContainer.viewContext

        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("❌ Failed saving context: \(error)")
            }
        }
    }

    // MARK: - Background Tasks

    func performBackgroundTask(_ block: @escaping (NSManagedObjectContext) -> Void) {
        persistentContainer.performBackgroundTask(block)
    }

    // MARK: - Generic Helpers

    /// Fetch ANY NSManagedObject with optional predicate
    func fetch<T: NSManagedObject>(
        _ request: NSFetchRequest<T>
    ) -> [T] {
        do {
            return try viewContext.fetch(request)
        } catch {
            print("❌ Fetch error: \(error)")
            return []
        }
    }

    /// Create ANY NSManagedObject
    func create<T: NSManagedObject>(_: T.Type) -> T {
        return T(context: viewContext)
    }

    /// Delete ANY NSManagedObject
    func delete(_ object: NSManagedObject) {
        viewContext.delete(object)
    }

    /// Delete objects from fetch
    func deleteAll<T: NSManagedObject>(_ request: NSFetchRequest<T>) {
        let all = fetch(request)
        all.forEach { viewContext.delete($0) }
    }
}
