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
    
    
    func storeImage(image: [Data],  completion: @escaping (Result<[String],Error>) -> ()) {
        var urls = [String]()
        let dispatchGroup = DispatchGroup()
        for i in image{
            dispatchGroup.enter()
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"
            let uuid = UUID()
            let imageLocation = imagesFolderReference.child(uuid.description)
            imageLocation.putData(i, metadata: metadata) { (responseMetadata, error) in
                if let error = error {
                    dispatchGroup.leave()
                    completion(.failure(error))
                } else {
                    imageLocation.downloadURL { (url, error) in
                        guard error == nil else {completion(.failure(error!));return}
                        guard let urlSaved = url else {completion(.failure(error!));return}
                        urls.append(urlSaved.absoluteString)
                        dispatchGroup.leave()
                    }
                }
            }
        }
        dispatchGroup.notify(queue: .main) {
            completion(.success(urls))
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

