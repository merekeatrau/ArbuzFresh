//
//  Product.swift
//  ArbuzFresh
//
//  Created by Mereke on 22.05.2023.
//

import Foundation
import UIKit

struct Product {
    let id: Int
    let name: String
    let category: Category
    let subcategory: Subcategory
    let type: ProductType
    let price: Double
    let imageUrl: String
}

enum Category: String {
    case fruitsAndVegetables = "Свежие овощи и фрукты"
    case milkProducts = "Молочные продукты"
}

enum Subcategory: String {
    case fruits = "Фрукты, ягоды"
    case vegetables = "Овощи"
    case herbs = "Зелень, салат"
    case milkAndSourCream = "Молоко, сметана"
    case yogurtAndCottageCheese = "Йогурты, творог"
    case cheese = "Сыры"
    
    var coverImageUrl: String {
        switch self {
        case .fruits:
            return "fruits"
        case .vegetables:
            return "vegetables"
        case .herbs:
            return "herbs"
        case .milkAndSourCream:
            return "milk"
        case .yogurtAndCottageCheese:
            return "yogurt"
        case .cheese:
            return "cheese"
        }
    }
}

enum ProductType: String {
    case weight = "kg"
    case count = "items"
}

var products: [Category: [[Product]]] = [
    .fruitsAndVegetables: [
        [
            Product(id: 1, name: "Apple", category: .fruitsAndVegetables, subcategory: .fruits, type: .weight, price: Double.random(in: 1...10), imageUrl: "apple"),
            Product(id: 2, name: "Banana", category: .fruitsAndVegetables, subcategory: .fruits, type: .weight, price: Double.random(in: 1...10), imageUrl: "banana"),
            Product(id: 3, name: "Orange", category: .fruitsAndVegetables, subcategory: .fruits, type: .weight, price: Double.random(in: 1...10), imageUrl: "orange"),
            Product(id: 4, name: "Blueberries", category: .fruitsAndVegetables, subcategory: .fruits, type: .weight, price: Double.random(in: 1...10), imageUrl: "blueberries"),
            Product(id: 5, name: "Grapes", category: .fruitsAndVegetables, subcategory: .fruits, type: .weight, price: Double.random(in: 1...10), imageUrl: "grapes"),
            Product(id: 6, name: "Strawberries", category: .fruitsAndVegetables, subcategory: .fruits, type: .weight, price: Double.random(in: 1...10), imageUrl: "strawberries")
        ],
        [
            Product(id: 7, name: "Carrot", category: .fruitsAndVegetables, subcategory: .vegetables, type: .weight, price: Double.random(in: 1...10), imageUrl: "carrot"),
            Product(id: 8, name: "Potato", category: .fruitsAndVegetables, subcategory: .vegetables, type: .weight, price: Double.random(in: 1...10), imageUrl: "potato"),
            Product(id: 9, name: "Cucumber", category: .fruitsAndVegetables, subcategory: .vegetables, type: .weight, price: Double.random(in: 1...10), imageUrl: "cucumber"),
            Product(id: 10, name: "Tomato", category: .fruitsAndVegetables, subcategory: .vegetables, type: .weight, price: Double.random(in: 1...10), imageUrl: "tomato"),
            Product(id: 11, name: "Onion", category: .fruitsAndVegetables, subcategory: .vegetables, type: .weight, price: Double.random(in: 1...10), imageUrl: "onion"),
            Product(id: 12, name: "Eggplant", category: .fruitsAndVegetables, subcategory: .vegetables, type: .weight, price: Double.random(in: 1...10), imageUrl: "eggplant"),
            Product(id: 13, name: "Peppers", category: .fruitsAndVegetables, subcategory: .vegetables, type: .weight, price: Double.random(in: 1...10), imageUrl: "peppers"),
            Product(id: 14, name: "Corn", category: .fruitsAndVegetables, subcategory: .vegetables, type: .weight, price: Double.random(in: 1...10), imageUrl: "corn")
        ],
        [
            Product(id: 15, name: "Salad", category: .fruitsAndVegetables, subcategory: .herbs, type: .weight, price: Double.random(in: 1...10), imageUrl: "salad"),
            Product(id: 16, name: "Chives", category: .fruitsAndVegetables, subcategory: .herbs, type: .weight, price: Double.random(in: 1...10), imageUrl: "chives"),
            Product(id: 17, name: "Garlic", category: .fruitsAndVegetables, subcategory: .herbs, type: .weight, price: Double.random(in: 1...10), imageUrl: "garlic"),
            Product(id: 18, name: "Mint", category: .fruitsAndVegetables, subcategory: .herbs, type: .weight, price: Double.random(in: 1...10), imageUrl: "mint"),
            Product(id: 19, name: "Parsley", category: .fruitsAndVegetables, subcategory: .herbs, type: .weight, price: Double.random(in: 1...10), imageUrl: "parsley"),
            Product(id: 20, name: "Spinach", category: .fruitsAndVegetables, subcategory: .herbs, type: .weight, price: Double.random(in: 1...10), imageUrl: "spinach")
        ]
    ],
    .milkProducts: [
        [
            Product(id: 21, name: "Milk Lactel", category: .milkProducts, subcategory: .milkAndSourCream, type: .count, price: Double.random(in: 1...10), imageUrl: "milk_lactel"),
            Product(id: 22, name: "Milk Packet", category: .milkProducts, subcategory: .milkAndSourCream, type: .count, price: Double.random(in: 1...10), imageUrl: "milk_packet"),
            Product(id: 23, name: "Smetana Selo", category: .milkProducts, subcategory: .milkAndSourCream, type: .count, price: Double.random(in: 1...10), imageUrl: "smetana_selo"),
            Product(id: 24, name: "Smetana Elar", category: .milkProducts, subcategory: .milkAndSourCream, type: .count, price: Double.random(in: 1...10), imageUrl: "smetana_elar"),
            Product(id: 25, name: "Milk Orlov", category: .milkProducts, subcategory: .milkAndSourCream, type: .count, price: Double.random(in: 1...10), imageUrl: "milk_orlov"),
            Product(id: 26, name: "Mild Adal", category: .milkProducts, subcategory: .milkAndSourCream, type: .count, price: Double.random(in: 1...10), imageUrl: "mild_adal")
        ],
        [
            Product(id: 27, name: "Yogurt Jivoy", category: .milkProducts, subcategory: .yogurtAndCottageCheese, type: .count, price: Double.random(in: 1...10), imageUrl: "yogurt_jivoy"),
            Product(id: 28, name: "Yogurt Straw", category: .milkProducts, subcategory: .yogurtAndCottageCheese, type: .count, price: Double.random(in: 1...10), imageUrl: "yogurt_straw"),
            Product(id: 29, name: "Yogurt Four", category: .milkProducts, subcategory: .yogurtAndCottageCheese, type: .count, price: Double.random(in: 1...10), imageUrl: "yogurt_four"),
            Product(id: 30, name: "Tvorog Selo", category: .milkProducts, subcategory: .yogurtAndCottageCheese, type: .count, price: Double.random(in: 1...10), imageUrl: "tvorog_selo"),
            Product(id: 31, name: "Tvorog President", category: .milkProducts, subcategory: .yogurtAndCottageCheese, type: .count, price: Double.random(in: 1...10), imageUrl: "tvorog_president"),
            Product(id: 32, name: "Tvorog Prostokv", category: .milkProducts, subcategory: .yogurtAndCottageCheese, type: .count, price: Double.random(in: 1...10), imageUrl: "tvorog_prostokv")
        ],
        [
            Product(id: 33, name: "Cheese Holland", category: .milkProducts, subcategory: .cheese, type: .count, price: Double.random(in: 1...10), imageUrl: "cheese_holland"),
            Product(id: 34, name: "Cheese Galbani", category: .milkProducts, subcategory: .cheese, type: .count, price: Double.random(in: 1...10), imageUrl: "cheese_galbani"),
            Product(id: 35, name: "Cheese Tome", category: .milkProducts, subcategory: .cheese, type: .count, price: Double.random(in: 1...10), imageUrl: "cheese_tome"),
            Product(id: 36, name: "Cheese Home", category: .milkProducts, subcategory: .cheese, type: .count, price: Double.random(in: 1...10), imageUrl: "cheese_home"),
            Product(id: 37, name: "Cheese Import", category: .milkProducts, subcategory: .cheese, type: .count, price: Double.random(in: 1...10), imageUrl: "cheese_import")
        ]
    ]
]
