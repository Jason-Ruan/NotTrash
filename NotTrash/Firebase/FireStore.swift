//
//  FireStore.swift
//  NotTrash
//
//  Created by albert coelho oliveira on 12/18/19.
//  Copyright © 2019 albert coelho oliveira. All rights reserved.
//

import Foundation
import FirebaseStorage

//switch on type of reference
enum typeOfReference: String{
    case post = "postImage"
    case profile = "profileImage"
}
class FireStore {
    
    // 2 managers for separate tasks:  one for posts and another for profile image
    static var profilemanager = FireStore(type: .profile)
    static var postManager = FireStore(type: .post)
    private let storage: Storage!
    private let storageReference: StorageReference
    private let imagesFolderReference: StorageReference
    
    init(type: typeOfReference) {
        storage = Storage.storage()
        storageReference = storage.reference()
        imagesFolderReference = storageReference.child(type.rawValue)
    }
    
    //save images
    func storeImage(image: Data,  completion: @escaping (Result<URL,Error>) -> ()) {
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        let uuid = UUID()
        let imageLocation = imagesFolderReference.child(uuid.description)
        imageLocation.putData(image, metadata: metadata) { (responseMetadata, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                imageLocation.downloadURL { (url, error) in
                    guard error == nil else {completion(.failure(error!));return}
                    guard let url = url else {completion(.failure(error!));return}
                    completion(.success(url))
                }
            }
        }
    }
    //get images from firebase
    func getImages(profileUrl: String, completion: @escaping (Result<Data, Error>) -> ()){
        imagesFolderReference.storage.reference(forURL: profileUrl).getData(maxSize: 2000000) { (data, error) in
            if let error = error{
                completion(.failure(error))
            }else  if let data = data {
                completion(.success(data))
            }
        }
    }
}

