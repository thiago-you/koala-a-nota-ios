//
//  ItemReview.swift
//  Koala a Nota
//
//  Created by user241334 on 9/30/23.
//

import Foundation

struct ItemReview: Identifiable {
    let id = UUID()
    let title: String
    let owner: String
    let rating: Integer
    let review: String
    let type: Integer
}