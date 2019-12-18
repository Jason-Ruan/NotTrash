//
//  FireService.swift
//  NotTrash
//
//  Created by albert coelho oliveira on 12/18/19.
//  Copyright © 2019 albert coelho oliveira. All rights reserved.
//

import Foundation
import FirebaseFirestore

enum FireStoreCollections: String {
    case users
    case posts
}

class FireService {
    static let manager = FireService()
    private let db = Firestore.firestore()
   
    //MARK: AppUsers
    func SaveUser(user: AppUser, completion: @escaping (Result<(), Error>) -> ()) {
        var fields = user.fieldsDict
        fields["dateCreated"] = Date()
        db.collection(FireStoreCollections.users.rawValue).document(user.uid).setData(fields) { (error) in
            if let error = error {
                completion(.failure(error))
                print(error)
            }
            completion(.success(()))
        }
    }
    func updateCurrentUser(userName: String? = nil, photoURL: URL? = nil, completion: @escaping (Result<(), Error>) -> ()){
        guard let userId = FirebaseAuthService.manager.currentUser?.uid else {
            //MARK: TODO - handle can't get current user
            return
        }
        var updateFields = [String:Any]()
        
        if let user = userName {
            updateFields["userName"] = user
        }
        
        if let photo = photoURL {
            updateFields["photoURL"] = photo.absoluteString
        }
        
        db.collection(FireStoreCollections.users.rawValue).document(userId).updateData(updateFields) { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    func createPost(post: Post, completion: @escaping (Result<(), Error>) -> ()) {
         var fields = post.fieldsDict
         fields["dateCreated"] = Date()
         db.collection(FireStoreCollections.posts.rawValue).addDocument(data: fields) { (error) in
             if let error = error {
                 completion(.failure(error))
             } else {
                 completion(.success(()))
             }
         }
     }
    func getAllPost(completion: @escaping (Result<[Post], Error>) -> ()){
        db.collection(FireStoreCollections.posts.rawValue).getDocuments {(snapshot, error) in
            if let error = error{
                completion(.failure(error))
            }else {
                let posts = snapshot?.documents.compactMap({ (snapshot) -> Post? in
                    let postID = snapshot.documentID
                    let post = Post(from: snapshot.data(), id: postID)
                    return post
                })
                completion(.success(posts ?? []))
                }
    }
    }
    func getUserPosts(for UserID: String, completion: @escaping (Result<[Post],Error>) ->()) {
        db.collection(FireStoreCollections.posts.rawValue).whereField("creatorID", isEqualTo: UserID).getDocuments { (snapshot, error) in
            if let error = error{
                completion(.failure(error))
            }else {
                let posts = snapshot?.documents.compactMap({ (snapshot) -> Post? in
                    let postID = snapshot.documentID
                    let post = Post(from: snapshot.data(), id: postID)
                    return post
                })
                completion(.success(posts ?? []))
            }
        }
    }
    func getUserFromPost(creatorID: String, completion: @escaping (Result<AppUser,Error>) -> ()) {
           db.collection(FireStoreCollections.users.rawValue).document(creatorID).getDocument { (snapshot, error)  in
               if let error = error {
                   completion(.failure(error))
               } else if let snapshot = snapshot,
                   let data = snapshot.data() {
                   let userID = snapshot.documentID
                   let user = AppUser(from: data, id: userID)
                   if let appUser = user {
                       completion(.success(appUser))
                   }
               }
           }
       }
         private init () {}
}
