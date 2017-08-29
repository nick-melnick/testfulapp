//
//  ChatsViewModel.swift
//  TestfulApp
//
//  Created by Nick Melnick on 8/28/17.
//  Copyright © 2017 Nick Melnick. All rights reserved.
//

import UIKit
import CoreData

class ChatsViewModel: NSObject {
    
    weak var coordinator: ChatsCoordinator?
    
    let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext, delegate: NSFetchedResultsControllerDelegate, coordinator: Coordinator) {
        self.context = context
        super.init()
        self.fetchController.delegate = delegate
        self.coordinator = coordinator as? ChatsCoordinator
    }
    
    private lazy var fetchController: NSFetchedResultsController<ChatContact> = {
        let request = ChatContact.fetchRequest() as NSFetchRequest<ChatContact>
        request.sortDescriptors = [
            NSSortDescriptor(key: "lastMessageTime", ascending: false)
        ]
        let controller = NSFetchedResultsController(fetchRequest: request, managedObjectContext: self.context, sectionNameKeyPath: nil, cacheName: nil)
        do {
            try controller.performFetch()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return controller
    }()
    
    // MARK: - TableView Delegates
    
    func numbersOfSection() -> Int {
        return fetchController.sections?.count ?? 0
    }
    
    func rowsInSection(_ section: Int) -> Int {
        guard let sectionInfo = fetchController.sections?[section] else { return 0 }
        return sectionInfo.numberOfObjects
    }
    
    func viewModelForRow(atIndexPath indexPath: IndexPath) -> ContactViewModel {
        let contact = fetchController.object(at: indexPath)
        return ContactViewModel(withContact: contact)
    }
    
}
