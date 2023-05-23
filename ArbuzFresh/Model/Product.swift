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
    case weight = "кг"
    case count = "шт"
}

var products: [Category: [[Product]]] = [
    .fruitsAndVegetables: [
        [
            Product(id: 1, name: "Яблоки Amal Bio Ред Делишес", category: .fruitsAndVegetables, subcategory: .fruits, type: .weight, price: 645, imageUrl: "apple"),
            Product(id: 2, name: "Бананы", category: .fruitsAndVegetables, subcategory: .fruits, type: .weight, price: 990, imageUrl: "banana"),
            Product(id: 3, name: "Апельсины Марокко", category: .fruitsAndVegetables, subcategory: .fruits, type: .weight, price: 1715, imageUrl: "orange"),
            Product(id: 4, name: "Черника Киргизия", category: .fruitsAndVegetables, subcategory: .fruits, type: .weight, price: 1834, imageUrl: "blueberries"),
            Product(id: 5, name: "Виноград зеленый Перу", category: .fruitsAndVegetables, subcategory: .fruits, type: .weight, price: 3510, imageUrl: "grapes"),
            Product(id: 6, name: "Клубника Альбион 400 г", category: .fruitsAndVegetables, subcategory: .fruits, type: .weight, price: 2540, imageUrl: "strawberries")
        ],
        [
            Product(id: 7, name: "Морковь", category: .fruitsAndVegetables, subcategory: .vegetables, type: .weight, price: 100.0, imageUrl: "carrot"),
            Product(id: 8, name: "Картофель", category: .fruitsAndVegetables, subcategory: .vegetables, type: .weight, price: 150.0, imageUrl: "potato"),
            Product(id: 9, name: "Огурцы", category: .fruitsAndVegetables, subcategory: .vegetables, type: .weight, price: 120.0, imageUrl: "cucumber"),
            Product(id: 10, name: "Помидоры", category: .fruitsAndVegetables, subcategory: .vegetables, type: .weight, price: 250.0, imageUrl: "tomato"),
            Product(id: 11, name: "Лук", category: .fruitsAndVegetables, subcategory: .vegetables, type: .weight, price: 80.0, imageUrl: "onion"),
            Product(id: 12, name: "Баклажаны", category: .fruitsAndVegetables, subcategory: .vegetables, type: .weight, price: 180.0, imageUrl: "eggplant"),
            Product(id: 13, name: "Перцы", category: .fruitsAndVegetables, subcategory: .vegetables, type: .weight, price: 300.0, imageUrl: "peppers"),
            Product(id: 14, name: "Кукуруза", category: .fruitsAndVegetables, subcategory: .vegetables, type: .weight, price: 180.0, imageUrl: "corn")
        ],
        [
            Product(id: 15, name: "Салат", category: .fruitsAndVegetables, subcategory: .herbs, type: .weight, price: 90.0, imageUrl: "salad"),
            Product(id: 16, name: "Зеленый лук", category: .fruitsAndVegetables, subcategory: .herbs, type: .weight, price: 50.0, imageUrl: "chives"),
            Product(id: 17, name: "Чеснок", category: .fruitsAndVegetables, subcategory: .herbs, type: .weight, price: 70.0, imageUrl: "garlic"),
            Product(id: 18, name: "Мята", category: .fruitsAndVegetables, subcategory: .herbs, type: .weight, price: 60.0, imageUrl: "mint"),
            Product(id: 19, name: "Петрушка", category: .fruitsAndVegetables, subcategory: .herbs, type: .weight, price: 40.0, imageUrl: "parsley"),
            Product(id: 20, name: "Шпинат", category: .fruitsAndVegetables, subcategory: .herbs, type: .weight, price: 100.0, imageUrl: "spinach")
        ]
    ],
    .milkProducts: [
        [
            Product(id: 21, name: "Молоко Lactel", category: .milkProducts, subcategory: .milkAndSourCream, type: .count, price: 350.0, imageUrl: "milk_lactel"),
            Product(id: 22, name: "Молоко пакет", category: .milkProducts, subcategory: .milkAndSourCream, type: .count, price: 300.0, imageUrl: "milk_packet"),
            Product(id: 23, name: "Сметана Село", category: .milkProducts, subcategory: .milkAndSourCream, type: .count, price: 250.0, imageUrl: "smetana_selo"),
            Product(id: 24, name: "Сметана Элар", category: .milkProducts, subcategory: .milkAndSourCream, type: .count, price: 280.0, imageUrl: "smetana_elar"),
            Product(id: 25, name: "Молоко Орлов", category: .milkProducts, subcategory: .milkAndSourCream, type: .count, price: 320.0, imageUrl: "milk_orlov"),
            Product(id: 26, name: "Молоко Адал", category: .milkProducts, subcategory: .milkAndSourCream, type: .count, price: 380.0, imageUrl: "milk_adal")
        ],
        [
            Product(id: 27, name: "Йогурт Живой", category: .milkProducts, subcategory: .yogurtAndCottageCheese, type: .count, price: 150.0, imageUrl: "yogurt_jivoy"),
            Product(id: 28, name: "Йогурт Земляника", category: .milkProducts, subcategory: .yogurtAndCottageCheese, type: .count, price: 180.0, imageUrl: "yogurt_straw"),
            Product(id: 29, name: "Йогурт Четыре", category: .milkProducts, subcategory: .yogurtAndCottageCheese, type: .count, price: 200.0, imageUrl: "yogurt_four"),
            Product(id: 30, name: "Творог Село", category: .milkProducts, subcategory: .yogurtAndCottageCheese, type: .count, price: 170.0, imageUrl: "tvorog_selo"),
            Product(id: 31, name: "Творог Президент", category: .milkProducts, subcategory: .yogurtAndCottageCheese, type: .count, price: 220.0, imageUrl: "tvorog_president"),
            Product(id: 32, name: "Творог Простокваш", category: .milkProducts, subcategory: .yogurtAndCottageCheese, type: .count, price: 190.0, imageUrl: "tvorog_prostokv")
        ],
        [
            Product(id: 33, name: "Сыр Голландский", category: .milkProducts, subcategory: .cheese, type: .count, price: 400.0, imageUrl: "cheese_holland"),
            Product(id: 34, name: "Сыр Гальбани", category: .milkProducts, subcategory: .cheese, type: .count, price: 350.0, imageUrl: "cheese_galbani"),
            Product(id: 35, name: "Сыр Томе", category: .milkProducts, subcategory: .cheese, type: .count, price: 320.0, imageUrl: "cheese_tome"),
            Product(id: 36, name: "Сыр Домашний", category: .milkProducts, subcategory: .cheese, type: .count, price: 280.0, imageUrl: "cheese_home"),
            Product(id: 37, name: "Сыр Импортный", category: .milkProducts, subcategory: .cheese, type: .count, price: 450.0, imageUrl: "cheese_import")
        ]
    ]
]

