//
//  ContactViewModel.swift
//  TestfulApp
//
//  Created by Nick Melnick on 8/28/17.
//  Copyright © 2017 Nick Melnick. All rights reserved.
//

import UIKit
import CoreData

class ContactViewModel: NSObject {
    private let contact: ChatContact
    
    var fullname: String? {
        return contact.fullname
    }
    
    var avatar: Data? {
        guard let data = contact.avatar as? Data else { return nil }
        return data
    }
    
    var avatarURL: URL? {
        guard let urlString = contact.avatarURL else { return nil }
        return URL(string: urlString)
    }
    
    var lastMessage: String? {
        return contact.lastMessage
    }
    
    var lastMessageTime: String? {
        let time = Date(timeIntervalSince1970: contact.lastMessageTime)
        let result:String
        if time.timeIntervalSinceNow < 3600 * 23 {
            result = dateFormatter.string(from: time)
        } else {
            let shortFormatter = dateFormatter
            shortFormatter.dateStyle = .none
            result = shortFormatter.string(from: time)
        }
        return result
    }
    
    var unreadCountText: String? {
        guard contact.unreadMessagesCount > 0 else { return nil }
        return String(format: "+ %d %@", contact.unreadMessagesCount, NSLocalizedString("messages", comment: "messages"))
    }
    
    init(withContact contact: ChatContact) {
        self.contact = contact
    }
    
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.doesRelativeDateFormatting = true
        return formatter
    }()
    
    func saveAvatar(_ avatar: UIImage) {
        let saveContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        saveContext.parent = contact.managedObjectContext
        let contactObjectID = contact.objectID
        saveContext.perform {
            guard let updateContact = saveContext.object(with: contactObjectID) as? ChatContact else { return }
            updateContact.avatar = avatar as NSObject
            do {
                try saveContext.save()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    
}
