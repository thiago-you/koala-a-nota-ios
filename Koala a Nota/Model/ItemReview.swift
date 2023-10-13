//
//  ItemReview.swift
//  Koala a Nota
//
//  Created by user241334 on 9/30/23.
//

import Foundation

struct ItemReview: Identifiable {
    let id: String
    let title: String
    let owner: String
    let rating: Int
    let review: String
    let type: Int
}
