//
//  ItemReviewModel.swift
//  Koala a Nota
//
//  Created by user241334 on 9/30/23.
//

import Foundation

final class ItemReviewModel {
    let reviews: [ItemReview] = [
        ItemReview(title: "Sanduíche de Presunto", owner: "Dona Florinda", rating: 5, review: "QUERIA MAIS! Isso isso isso.", type: 1),
        ItemReview(title: "Pastel sabor Pizza", owner: "9 Pasteis", rating: 3, review: "Bom sabor, mas não veio borda recheada!", type: 1),
        ItemReview(title: "Huurh Awwgggghhh!", owner: "Chewie Burger", rating: 5, review: "Melhor hamburger do mundo e do brasil!", type: 1),
        ItemReview(title: "Pizza de 4 queijos", owner: "DiPizzas", rating: 1, review: "Muito bom, perfeito!", type: 1),
        ItemReview(title: "Pizza Tradicional + Refri", owner: "DiPizzas", rating: 5, review: "Ótima pizza, recomendo muito!", type: 1)
    ]
}
