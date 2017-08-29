//
//  ChatMessages+CoreDataProperties.swift
//  TestfulApp
//
//  Created by Nick Melnick on 8/28/17.
//  Copyright © 2017 Nick Melnick. All rights reserved.
//
//

import Foundation
import CoreData


extension ChatMessages {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ChatMessages> {
        return NSFetchRequest<ChatMessages>(entityName: "ChatMessages")
    }

    @NSManaged public var identifier: Int64
    @NSManaged public var message: String?
    @NSManaged public var sendingDate: TimeInterval
    @NSManaged public var contact: ChatContact?

}
