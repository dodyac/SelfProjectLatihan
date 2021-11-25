//
//  User.swift
//  SelfProjectLatihan
//
//  Created by mac pro on 25/11/21.
//

import Foundation
import Alamofire

struct User: Codable, Identifiable {
    var id: Int
    var email: String
    var username: Double
    var password: String
    var name: Name
    var address: Address
    var phone: String
    
    init(id: Int, email: String, username: Double, password: String, name: Name, address: Address, phone: String){
        self.id = id
        self.email = email
        self.username = username
        self.password = password
        self.name = name
        self.address = address
        self.phone = phone
    }
}

struct Name: Codable {
    var firstname: String
    var lastname: String
}

struct Address: Codable {
    var city: String
    var street: String
    var number: Int
    var zipcode: String
    var geolocation: GeoLocation
}

struct GeoLocation: Codable {
    var lat: Double
    var long: Double
}

struct TokenSignIn: Codable {
    var token: String
    
    init(token: String) {
        self.token = token
    }
}

func apiRequestSignIn(url: String, username: String, password: String, completion: @escaping (TokenSignIn) -> ()) {
    let parameter: Parameters = ["username": username, "password": password]
    Session.default.request(url, method: .post, parameters: parameter, encoding: JSONEncoding.default)
        .responseDecodable(of: TokenSignIn.self) {
            response in switch
            response.result {
                case.success(let result):
                    print(result)
                    completion(result)
            
                case.failure(let error):
                    print(error)
            }
    }
}
