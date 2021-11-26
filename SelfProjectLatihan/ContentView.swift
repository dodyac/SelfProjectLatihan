//
//  ContentView.swift
//  SelfProjectLatihan
//
//  Created by mac pro on 22/11/21.
//  https://fakestoreapi.com/

import SwiftUI

struct ContentView: View {
    @State var input = "100"
    @State var base = "USD"
    @State var currencyList = [String]()
    @FocusState private var inputIsFocused: Bool
    @ObservedObject var globalData = GlobalObject()
    @State var categoryList = [String]()
    @State var currentCategory = "All"
    @State var isLoading = false
    @State var isAsc = false
    
    func makeRequest(showAll: Bool, currencies: [String] = ["USD", "IDR"]) {
        apiRequest(url: "https://api.exchangerate.host/latest?base=\(base)&amount=\(input)") { currency in
            var tempList = [String]()
            
            for currency in currency.rates {
                if showAll {
                    tempList.append("\(currency.key) \(String(format: "%.2f", currency.value))")
                } else if currencies.contains(currency.key) {
                    tempList.append("\(currency.key) \(String(format: "%.2f", currency.value))")
                }
                tempList.sort()
            }
            currencyList.self = tempList
        }
    }
    
//    func makeRequestProduct() {
//        apiRequestProduct(url: "https://fakestoreapi.com/products") { products in
//            var tempList = [ProductReal]()
//
//            for product in products {
//                tempList.append(product)
//            }
//            productList.self = tempList
//        }
//    }
    
    func makeRequestProduct(showAll: Bool = true) {
        let url: String
        if showAll {
            url = "https://fakestoreapi.com/products"
        } else {
            url = "https://fakestoreapi.com/products/category/\(currentCategory.replacingOccurrences(of: " ", with: "%20"))"
        }
        apiRequestProduct(url: url) { products in
            var tempList = [ProductReal]()
            
            for product in products {
                tempList.append(product)
            }
            self.globalData.productList = tempList
            isLoading = false
        }
    }
    
    func makeRequestCategories() {
        apiRequestCategories(url: "https://fakestoreapi.com/products/categories") { category in
            var categories = [String]()
            
            categories.append("All")
            
            for category in category {
                categories.append(category)
            }
            
            categoryList.self = categories
        }
    }
    
    let gridProduct = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        NavigationView {
            if isLoading {
                GeometryReader { geometry in
                    LoaderView()
                        .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                }.background(Color.black.opacity(0.45).edgesIgnoringSafeArea(.all))
            }
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(categoryList, id: \.self) { category in
                            if category == currentCategory {
                                Button(action: {
                                    currentCategory = category
                                    let showing: Bool
                                    if currentCategory == "All" {
                                        showing = true
                                    } else {
                                        showing = false
                                    }
                                    isLoading = true
                                    makeRequestProduct(showAll: showing)
                                }) {
                                    Text(category)
                                        .font(.callout)
                                        .padding()
                                }
                                .background(.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .padding(.trailing, 5)
                                .padding(.leading, 5)
                            } else {
                                Button(action: {
                                    currentCategory = category
                                    let showing: Bool
                                    if currentCategory == "All" {
                                        showing = true
                                    } else {
                                        showing = false
                                    }
                                    isLoading = true
                                    makeRequestProduct(showAll: showing)
                                }) {
                                    Text(category)
                                        .font(.callout)
                                        .padding()
                                }
                                .background(Color.gray.opacity(0.2))
                                .foregroundColor(.blue)
                                .cornerRadius(10)
                                .padding(.trailing, 5)
                                .padding(.leading, 5)
                            }
                        }
                    }
                    .frame(height: 100)
                }
                ScrollView {
                    LazyVGrid(columns: gridProduct, spacing: 20) {
                        ForEach(self.globalData.productList) {
                            row in NavigationLink(destination: ProductDetail(data: row, globalData: globalData)) {
                                ProductView(data: row, globalData: globalData)
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("iProducts")
            .navigationBarItems(trailing:
            HStack(spacing: 10) {
                Button(action: {
                    self.isAsc.toggle()
                    if isAsc {
                        self.globalData.productList.sort(by:) {
                            $0.title.lowercased() < $1.title.lowercased()
                        }
                    } else {
                        self.globalData.productList.sort(by:) {
                            $0.title.lowercased() > $1.title.lowercased()
                        }
                    }
                }){
                    Image(systemName: "arrow.up.arrow.down.circle.fill")
                }
                NavigationLink(destination: DetailView(globalData: globalData)) {
                    cartView(globalData: globalData)
                }
                NavigationLink(destination: AuthView()) {
                    AccountIcon()
                }
            })
        }
        .onAppear {
            isLoading = true
            makeRequestProduct()
            makeRequestCategories()
        }
        .navigationViewStyle(StackNavigationViewStyle())
//        VStack {
//            HStack {
//                Text("Currencies")
//                    .font(.system(size: 30))
//                    .bold()
//                Image(systemName: "eurosign.circle.fill")
//                    .font(.system(size: 30))
//                    .foregroundColor(.blue)
//            }
//            List {
//                ForEach(currencyList, id: \.self) { currency in
//                    Text(currency)
//                }
//            }
//            VStack {
//                Rectangle()
//                    .frame(height: 8.0)
//                    .foregroundColor(.blue)
//                    .opacity(0.90)
//                TextField("Enter an amount", text: $input)
//                    .padding()
//                    .background(Color.gray.opacity(0.10))
//                    .cornerRadius(20.0)
//                    .padding()
//                    .keyboardType(.decimalPad)
//                    .focused($inputIsFocused)
//
//            TextField("Enter a currency", text: $base)
//                .padding()
//                .background(Color.gray.opacity(0.10))
//                .cornerRadius(20.0)
//                .padding()
//                .focused($inputIsFocused)
//            }
//
//            Button("Convert!") {
//                makeRequest(showAll: false, currencies: ["DKK", "SEK", "IDR"])
//                inputIsFocused = false
//            }.padding()
//        }.onAppear {
////            makeRequest(showAll: true)
//            makeRequestProduct()
    }
}

struct DetailView : View {
    
    
    let gridProduct = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    @ObservedObject var globalData : GlobalObject
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: gridProduct, spacing: 20) {
                    ForEach(self.globalData.cart) {
                        row in NavigationLink(destination: ProductDetail(data: row, globalData: globalData)) {
                            ProductView(data: row, globalData: globalData, isDeleteCartVisible: true)
                        }
                    }
                }
            }
            .navigationBarItems(trailing:
            HStack(spacing: 10){
                NavigationLink(destination: AuthView()) {
                    AccountIcon()
                }
                cartView(globalData: globalData)
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct cartView : View {
    @ObservedObject var globalData : GlobalObject
    
    var body: some View {
        ZStack {
            Image(systemName: "cart.fill")
                .resizable()
                .frame(width: 20, height: 20)
            Text(String(self.globalData.cart.count))
                .foregroundColor(.white)
                .frame(width: 10, height: 10)
                .font(.body)
                .padding(5)
                .background(.red)
                .clipShape(Circle())
                .offset(x:10, y:-10)
        }

    }
}

struct tambahKeranjang : View {
    @State var product: ProductReal
    @ObservedObject var globalData : GlobalObject
    
    var body: some View {
        Button(action: {
            self.globalData.cart.insert(product, at: self.globalData.cart.count)
        }){
            HStack{
                Spacer()
                HStack {
                    Image(systemName: "cart")
                    Text("Add to Cart")
                        .font(.caption)
                        .padding()
                }
                Spacer()
            }
        }
        .frame(maxWidth: .infinity)
        .background(.green)
        .foregroundColor(.white)
        .cornerRadius(10)
        .padding()
    }
}
