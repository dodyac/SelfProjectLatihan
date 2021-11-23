//
//  Product.swift
//  SelfProjectLatihan
//
//  Created by mac pro on 22/11/21.
//

import Foundation
import Alamofire

struct ProductReal: Codable, Identifiable {
    var id: Int
    var title: String
    var price: Double
    var description: String
    var category: String
    var image: String
    var rating: Rating
    
    init(id: Int, title: String, price: Double, description: String, category: String, image: String, rating: Rating){
        self.id = id
        self.title = title
        self.price = price
        self.description = description
        self.category = category
        self.image = image
        self.rating = rating
    }
}

struct Currencies: Codable {
    var success: Bool
    var base: String
    var date: String
    var rates = [String: Double]()
}


struct Rating: Codable {
    var rate: Double
    var count: Int
}

func apiRequest(url: String, completion: @escaping (Currencies) -> ()) {
    Session.default.request(url).responseDecodable(of: Currencies.self) {
        response in switch
        response.result {
        case.success(let currencies):
            print(currencies)
            completion(currencies)
            
        case.failure(let error):
            print(error)
        }
    }
}


func apiRequestProduct(url: String, completion: @escaping ([ProductReal]) -> ()) {
    Session.default.request(url).responseDecodable(of: [ProductReal].self) {
        response in switch
        response.result {
        case.success(let product):
            print(product)
            completion(product)
            
        case.failure(let error):
            print(error)
        }
    }
}


func apiRequestCategories(url: String, completion: @escaping ([String]) -> ()) {
    Session.default.request(url).responseDecodable(of: [String].self) {
        response in switch
        response.result {
        case.success(let categories):
            print(categories)
            completion(categories)
            
        case.failure(let error):
            print(error)
        }
    }
}
