//
//  User.swift
//  SelfProjectLatihan
//
//  Created by mac pro on 25/11/21.
//

import Foundation
import Alamofire
import UIKit

struct User: Codable, Identifiable {
    var id: Int
    var email: String
    var username: String
    var password: String
    var name: Name
    var address: Address
    var phone: String
    
    init(id: Int, email: String, username: String, password: String, name: Name, address: Address, phone: String){
        self.id = id
        self.email = email
        self.username = username
        self.password = password
        self.name = name
        self.address = address
        self.phone = phone
    }
}

struct UserPost: Decodable {
    var id: Int
    var email: String
    var username: String
    var password: String
    var name: Name?
    var address: Address
    var phone: String
}

struct Name: Codable {
    var firstname: String
    var lastname: String
}

struct Address: Codable {
    var city: String
    var street: String
    var number: String?
    var zipcode: String?
    var geolocation: GeoLocation
}

struct GeoLocation: Codable {
    var lat: String
    var long: String
}

struct TokenSignIn: Decodable {
    let token: String?
    let status: String?
    let msg: String?
}

func apiRequestSignIn(url: String, username: String, password: String, completion: @escaping (TokenSignIn) -> ()) {
    let parameter: Parameters = ["username": username, "password": password]
    Session.default.request(url, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: nil)
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


func apiRequestSignUpFix(userPost: UserPost, completion: @escaping (UserPost) -> ()) {
    guard let url = URL(string: "https://fakestoreapi.com/users") else {
        return
    }
    
    
    let finalData = try! JSONSerialization.data(withJSONObject: userPost)
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.httpBody =  finalData
    request.setValue("application/jspn", forHTTPHeaderField: "Content-Type")
    
    URLSession.shared.dataTask(with: url) {
        (data, res, err) in
        do {
            if let data = data {
                let result = try JSONDecoder().decode(UserPost.self, from: data)
                print(result)
                completion(result)
            }
            else {
                print("No Data")
            }
        } catch (let error){
            print("Error: ", error.localizedDescription)
        }
    }.resume()
}


func apiRequestSignUp(url: String, user: UserPost, completion: @escaping (UserPost) -> ()) {
    let parameter: Parameters = [
        "email" : user.email,
        "username" : user.username,
        "password" : user.password,
        "name" : [
            "firstname" : user.name?.firstname,
            "lastname" : user.name?.lastname
        ],
        "address": [
            "city" : user.address.city,
            "street" : user.address.street,
            "number" : user.address.number,
            "zipcode" : user.address.zipcode,
            "geolocation" : [
                "lat" : user.address.geolocation.lat,
                "long" : user.address.geolocation.long
            
            ]
        ],
        "phone" : user.phone
    ]
    Session.default.request(url, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: nil)
        .responseDecodable(of: UserPost.self) {
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
