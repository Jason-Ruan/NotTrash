//
//  User.swift
//  NotTrash
//
//  Created by albert coelho oliveira on 12/18/19.
//  Copyright © 2019 albert coelho oliveira. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

struct AppUser {
    //MARK: - Properties
    let uid: String
    let email: String?
    let displayName: String?
    let dateCreated: Date?
    let photoURL: String?
    let numCompletedTransactions: Int?
    let borough: String?
    
    
    //MARK: - Initializers
    init(from user: User) {
        self.displayName = user.displayName
        self.email = user.email
        self.uid = user.uid
        self.dateCreated = user.metadata.creationDate
        self.photoURL = user.photoURL?.absoluteString
        self.numCompletedTransactions = 0
        self.borough = ""
    }
    
    init?(from dict: [String: Any], id: String) {
        guard let displayName = dict["displayName"] as? String,
            let email = dict["email"] as? String,
            let dateCreated = (dict["dateCreated"] as? Timestamp)?.dateValue() else { return nil }
        
        self.displayName = displayName
        self.email = email
        self.uid = id
        self.dateCreated = dateCreated
        
        //User Profile Photo
        var optionalPhotoURL: String = ""
        if let photoURL = dict["photoURL"] as? String {
            optionalPhotoURL = photoURL
        }
        self.photoURL = optionalPhotoURL
        
        //Number of Completed Transactions
        var numCompletedTransactions: Int = 0
        if let retrievedNumCompletedTransactions = dict["numCompletedTransactions"] as? Int {
            numCompletedTransactions = retrievedNumCompletedTransactions
        }
        self.numCompletedTransactions = numCompletedTransactions
        
        //Borough
        var borough = ""
        if let retrievedBorough = dict["borough"] as? String {
            borough = retrievedBorough
        }
        self.borough = borough
        
    }
    
    //MARK: - Firestore Fields Dictionary
    var fieldsDict: [String: Any] {
        return [
            "displayName": self.displayName ?? "",
            "email": self.email ?? "",
            "dateCreated": self.dateCreated ?? "",
            "numCompletedTransactions": self.numCompletedTransactions ?? 0,
            "borough": self.borough ?? ""
        ]
    }
}
