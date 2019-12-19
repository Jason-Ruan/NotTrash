//
//  Post.swift
//  NotTrash
//
//  Created by albert coelho oliveira on 12/18/19.
//  Copyright © 2019 albert coelho oliveira. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

struct Post {
    //MARK: - Properties
    let creatorID: String
    let itemID: String
    let borough: String
    let isAvailable: Bool
    let imageURLStrings: [String]
    let description: String
    let dateCreated: Date
    
    
    //MARK: - Initializers
    init(from user: AppUser, itemID: String, borough: String, imageURLStrings: [String], description: String, isAvailable: Bool) {
        self.creatorID = user.uid
        self.itemID = itemID
        self.borough = borough
        self.imageURLStrings = imageURLStrings
        self.description = description
        self.isAvailable = isAvailable
        self.dateCreated = Date()
    }
    
    init?(from dict: [String: Any], id: String) {
        guard let itemID = dict["itemID"] as? String,
            let borough = dict["borough"] as? String,
            let isAvailable = dict["isAvailable"] as? Bool,
            let imageURLStrings = dict["imageURLStrings"] as? [String],
            let description = dict["description"] as? String,
            let dateCreated = (dict["dateCreated"] as? Timestamp)?.dateValue() else { return nil }
        
        self.creatorID = id
        self.itemID = itemID
        self.borough = borough
        self.imageURLStrings = imageURLStrings
        self.description = description
        self.isAvailable = isAvailable
        self.dateCreated = dateCreated
    }
    
    
    //MARK: - Firestore Fields Dictionary
    var fieldsDict: [String: Any] {
        return [
            "creatorID": self.creatorID,
            "itemID": self.itemID,
            "borough": self.borough,
            "isAvailable": self.isAvailable,
            "imageURLStrings": self.imageURLStrings,
            "description": self.description,
            "dateCreated": self.dateCreated
        ]
    }
}
