//
//  CoreDataStack.swift
//  TestfulApp
//
//  Created by Nick Melnick on 8/28/17.
//  Copyright © 2017 Nick Melnick. All rights reserved.
//

import Foundation
import CoreData
import SwiftyJSON

public class CoreDataStack {
    
    private let modelName: String
    
    init(modelName: String) {
        self.modelName = modelName
    }
    
    // MARK: - Core Data Stack
    public private(set) lazy var managedObjectContext: NSManagedObjectContext = {
        // Initialize Managed Object Context
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        
        // Configure Managed Object Context
        managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator
        
        return managedObjectContext
    }()
    
    private lazy var managedObjectModel: NSManagedObjectModel? = {
        // Fetch Model URL
        guard let modelURL = Bundle.main.url(forResource: self.modelName, withExtension: "momd") else {
            return nil
        }
        
        // Initialize Managed Object Model
        let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL)
        
        return managedObjectModel
    }()
    
    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        guard let managedObjectModel = self.managedObjectModel else {
            return nil
        }
        
        // Helper
        let persistentStoreURL = self.persistentStoreURL
        
        // Initialize Persistent Store Coordinator
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        
        do {
            let options = [ NSMigratePersistentStoresAutomaticallyOption : true, NSInferMappingModelAutomaticallyOption : true ]
            try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: persistentStoreURL, options: options)
            
        } catch {
            let addPersistentStoreError = error as NSError
            
            print("Unable to Add Persistent Store")
            print("\(addPersistentStoreError.localizedDescription)")
        }
        
        return persistentStoreCoordinator
    }()
    
    // MARK: - Computed Properties
    private var persistentStoreURL: URL {
        // Helpers
        let storeName = "\(modelName).sqlite"
        let fileManager = FileManager.default
        
        let documentsDirectoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        return documentsDirectoryURL.appendingPathComponent(storeName)
    }
    
    func seedStartData() {
        if let fileDataURL = Bundle.main.url(forResource: "data", withExtension: "plist") {
            guard let dataArray = NSArray(contentsOf: fileDataURL)else { return }

            managedObjectContext.performAndWait {
                for record in dataArray {
                    if let data = record as? [String: Any] {
                        let contact = NSEntityDescription.insertNewObject(forEntityName: "ChatContact", into: self.managedObjectContext) as? ChatContact
                        contact?.updateFromXML(data)
                    }
                }
                if self.managedObjectContext.hasChanges == true {
                    do {
                        try self.managedObjectContext.save()
                        UserDefaults.standard.set(true, forKey: "presentationData")
                        UserDefaults.standard.synchronize()
                    } catch let error as NSError {
                        print(error.localizedDescription)
                    }
                }
            }
        }
    
    }
    
}

