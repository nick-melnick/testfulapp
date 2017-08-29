//
//  ChatsCoordinator.swift
//  TestfulApp
//
//  Created by Nick Melnick on 8/28/17.
//  Copyright © 2017 Nick Melnick. All rights reserved.
//

import UIKit
import CoreData

/// Coordinator for List of chats
class ChatsCoordinator: Coordinator {
    
    func start() {
        let stack = CoreDataStack(modelName: "TestfulApp")
        let presentationData = UserDefaults.standard.bool(forKey: "presentationData")
        if !presentationData {
            stack.seedStartData()
        }
        if let vc = navigationController?.topViewController as? ChatsViewController {
            let viewModel = ChatsViewModel(context: stack.managedObjectContext, delegate: vc as NSFetchedResultsControllerDelegate, coordinator: self)
            vc.viewModel = viewModel
        }
    }
    
}
