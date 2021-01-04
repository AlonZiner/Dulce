//
//  ModelFirebaseStorage.swift
//  Dulce
//
//  Created by admin on 02/01/2021.
//  Copyright © 2021 colman. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class FirebaseStorage {
    static func saveImage(image:UIImage, imageName:String, callback:@escaping (String)->Void){
        let storageRef = Storage.storage().reference(forURL: "gs://dulce-acbaa.appspot.com")
        let data = image.jpegData(compressionQuality: 0.5)
        let imageRef = storageRef.child(imageName)
        let metadata = StorageMetadata()
        
        metadata.contentType = "image/jpeg"
        imageRef.putData(data!, metadata: metadata) { (metadata, error) in
            imageRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    return
                }
                print("url: \(downloadURL)")
                callback(downloadURL.absoluteString)
            }
        }
    }
}
