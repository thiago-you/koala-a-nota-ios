//
//  FirestoreManager.swift
//  Koala a Nota
//
//  Created by user241334 on 10/12/23.
//

import Foundation
import Firebase

class FirestoreManager: ObservableObject {
    
    func storeReview(review: ItemReview) -> Bool {
        let db = Firestore.firestore()
        
        var returnValue: Bool = false
        // let uid: String = Auth.auth().currentUser?.uid ?? ""
        
        let docRef = db.collection("reviews").addDocument(data: [
            "title": review.title,
            "owner": review.owner,
            "rating": review.rating,
            "review": review.review,
            "type": review.type
        ]) { err in
            if let err = err {
                returnValue = false
            } else {
                returnValue = true
            }
        }
        
        return returnValue
    }
}
