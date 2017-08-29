//
//  ChatContact+UpdateExtension.swift
//  TestfulApp
//
//  Created by Nick Melnick on 8/28/17.
//  Copyright © 2017 Nick Melnick. All rights reserved.
//

import Foundation
import SwiftyJSON

extension ChatContact {
    
    func updateFromJSON(_ json: JSON) {
        identifier = json["identifier"].int64Value
        fullname = json["fullname"].string
        avatarURL = json["avatarURL"].string
        if avatarURL != avatarURL_old {
            avatar = nil
            avatarURL_old = avatarURL
        }
        lastMessage = json["message"].string
        unreadMessagesCount = json["unreadMessagesCount"].int16Value
        if let dateString = json["sendingDate"].rawValue as? Date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            print(dateString)
//            lastMessageTime = Double(dateFormatter.date(from: dateString)?.timeIntervalSince1970 ?? 0)
        }
    }
    
    func updateFromXML(_ xml: [String: Any]) {
        if let num = xml["identifier"] as? Int64 {
            identifier = num
        }
        if let fname = xml["fullname"] as? String {
            fullname = fname
        }
        if let lastmess = xml["message"] as? String {
            lastMessage = lastmess
        }
        if let unreadCount = xml["unreadMessagesCount"] as? Int16 {
            unreadMessagesCount = unreadCount
        }
        if let avatarurl = xml["avatarURL"] as? String {
            avatarURL = avatarurl
            if avatarURL != avatarURL_old {
                avatarURL_old = avatarURL
                avatar = nil
            }
        }
        if let sendingDate = xml["sendingDate"] as? Date {
            lastMessageTime = sendingDate.timeIntervalSince1970
        }

    }
    
}


