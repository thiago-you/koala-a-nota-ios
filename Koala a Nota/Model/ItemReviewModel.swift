//
//  ItemReviewModel.swift
//  Koala a Nota
//
//  Created by user241334 on 9/30/23.
//

import Foundation

final class ItemReviewModel {
    let reviews: [ItemReview] = [
        Cover(title: "Sanduíche de Presunto", owner: "Dona Florinda", rating: 5, review: "QUERIA MAIS! Isso isso isso."),
        Cover(title: "Pastel sabor Pizza", owner: "9 Pasteis", rating: 3, review: "Bom sabor, mas não veio borda recheada!"),
        Cover(title: "Huurh Awwgggghhh!", owner: "Chewie Burger", rating: 5, review: "Melhor hamburger do mundo e do brasil!"),
        Cover(title: "Pizza de 4 queijos", owner: "DiPizzas", rating: 1, review: "Muito bom, perfeito!"),
        Cover(title: "Pizza Tradicional + Refri", owner: "DiPizzas", rating: 5, review: "Ótima pizza, recomendo muito!")
    ]
}