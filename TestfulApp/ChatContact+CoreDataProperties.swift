//
//  ChatContact+CoreDataProperties.swift
//  TestfulApp
//
//  Created by Nick Melnick on 8/28/17.
//  Copyright © 2017 Nick Melnick. All rights reserved.
//
//

import Foundation
import CoreData


extension ChatContact {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ChatContact> {
        return NSFetchRequest<ChatContact>(entityName: "ChatContact")
    }

    @NSManaged public var avatar: NSObject?
    @NSManaged public var avatarURL: String?
    @NSManaged public var fullname: String?
    @NSManaged public var identifier: Int64
    @NSManaged public var lastMessage: String?
    @NSManaged public var lastMessageTime: TimeInterval
    @NSManaged public var unreadMessagesCount: Int16
    @NSManaged public var avatarURL_old: String?
    @NSManaged public var messages: NSOrderedSet?

}

// MARK: Generated accessors for messages
extension ChatContact {

    @objc(insertObject:inMessagesAtIndex:)
    @NSManaged public func insertIntoMessages(_ value: ChatMessages, at idx: Int)

    @objc(removeObjectFromMessagesAtIndex:)
    @NSManaged public func removeFromMessages(at idx: Int)

    @objc(insertMessages:atIndexes:)
    @NSManaged public func insertIntoMessages(_ values: [ChatMessages], at indexes: NSIndexSet)

    @objc(removeMessagesAtIndexes:)
    @NSManaged public func removeFromMessages(at indexes: NSIndexSet)

    @objc(replaceObjectInMessagesAtIndex:withObject:)
    @NSManaged public func replaceMessages(at idx: Int, with value: ChatMessages)

    @objc(replaceMessagesAtIndexes:withMessages:)
    @NSManaged public func replaceMessages(at indexes: NSIndexSet, with values: [ChatMessages])

    @objc(addMessagesObject:)
    @NSManaged public func addToMessages(_ value: ChatMessages)

    @objc(removeMessagesObject:)
    @NSManaged public func removeFromMessages(_ value: ChatMessages)

    @objc(addMessages:)
    @NSManaged public func addToMessages(_ values: NSOrderedSet)

    @objc(removeMessages:)
    @NSManaged public func removeFromMessages(_ values: NSOrderedSet)

}
