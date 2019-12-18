//
//  FireAuth.swift
//  NotTrash
//
//  Created by albert coelho oliveira on 12/18/19.
//  Copyright © 2019 albert coelho oliveira. All rights reserved.
//

import Foundation
import FirebaseAuth
import Firebase

class FireAuth {
    static let manager = FireAuth()
    private let auth = Auth.auth()
    //returns current user
    var currentUser: User? {
        return auth.currentUser
    }
    func createNewUser(email: String, password: String, completion: @escaping (Result<User,Error>) -> ()) {
        auth.createUser(withEmail: email, password: password) { (result, error) in
            if let createdUser = result?.user {
                completion(.success(createdUser))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
    func updateUserFields(userName: String? = nil,photoURL: URL? = nil,  completion: @escaping (Result<(),Error>) -> ()){
        let changeRequest = auth.currentUser?.createProfileChangeRequest()
        if let userName = userName {
            changeRequest?.displayName = userName
        }
        if let photoURL = photoURL {
            changeRequest?.photoURL = photoURL
        }
        changeRequest?.commitChanges(completion: { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        })
    }
    func loginUser(email: String, password: String, completion: @escaping (Result<(), Error>) -> ()) {
        auth.signIn(withEmail: email, password: password) { (result, error) in
            if let user = result?.user {
                print(user)
                completion(.success(()))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
    //logs user out
    func logOut(completion: @escaping (Result<(), Error>) -> ()) {
        do{ try auth.signOut()}
        catch {
            print(error)
        }
    }
    private init () {}
}
