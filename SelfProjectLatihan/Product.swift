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

struct Product: Codable {
    var success: Bool
    var base: String
    var date: String
    var rates = [String: Double]()
}


struct Rating: Codable {
    var rate: Double
    var count: Int
}

func apiRequest(url: String, completion: @escaping (Product) -> ()) {
    Session.default.request(url).responseDecodable(of: Product.self) {
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
