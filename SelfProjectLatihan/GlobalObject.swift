//
//  GlobalObject.swift
//  SelfProjectLatihan
//
//  Created by mac pro on 22/11/21.
//

import Foundation



class GlobalObject: ObservableObject {
    @Published var jumlah : Int = 0
    @Published var productList = [ProductReal]()
    
    @Published var cart = [ProductReal]()
}
