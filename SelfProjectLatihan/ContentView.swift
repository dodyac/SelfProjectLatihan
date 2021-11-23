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
    @State var productList = [ProductReal]()
    @State var categoryList = [String]()
    @State var currentCategory = "All"
    @State var isLoading = false
    
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
            url = "https://fakestoreapi.com/products/category/\(currentCategory)"
        }
        apiRequestProduct(url: url) { products in
            var tempList = [ProductReal]()
            
            for product in products {
                tempList.append(product)
            }
            productList.self = tempList
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

    @ObservedObject var globalData = GlobalObject()
    
    let gridProduct = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        NavigationView {
            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                    .scaleEffect(3)
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
                        ForEach(productList) {
                            row in VStack(alignment: .leading, spacing: 10) {
                                NavigationLink(destination: DetailProductView(namaProduk: row.title)) {
                                    ProductView(data: row, jumlahKeranjang: globalData)
                                }
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("iProducts")
            .navigationBarItems(trailing:
            HStack(spacing: 10){
                NavigationLink(destination: DetailView(globalData: globalData)) {
                    cartView(jumlahKeranjang: globalData)
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
    
    @ObservedObject var globalData : GlobalObject
    
    var body: some View {
        NavigationView {
            Text("Daftar Keranjang")
                .navigationBarTitle("Cart")
                .navigationBarItems(trailing:
                HStack(spacing: 10){
                    Button(action: {
                        print("image")
                    }) {
                        Image(systemName: "person.fill")
                    }
                    cartView(jumlahKeranjang: globalData)
                })
        }
    }
}


struct DetailProductView : View {
    var namaProduk: String
    var body: some View {
        NavigationView {
            Text("Detail Produk")
                .navigationBarTitle(namaProduk)
                .navigationBarItems(trailing:
                HStack(spacing: 10){
                    Button(action: {
                        print("image")
                    }) {
                        Image(systemName: "person.fill")
                    }
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
//    @Binding var jumlah: Int
    @ObservedObject var jumlahKeranjang : GlobalObject
    
    var body: some View {
        ZStack {
            Image(systemName: "cart.fill")
                .resizable()
                .frame(width: 20, height: 20)
            Text(String(self.jumlahKeranjang.jumlah))
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

struct ProductView : View {
    let data: ProductReal
    @ObservedObject var jumlahKeranjang: GlobalObject
    @State var animate = false
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .topTrailing) {
                AsyncImage(url: URL(string: self.data.image)!,
                           placeholder: {
//                    ZStack {
//                        Circle()
//                            .trim(from: 0, to: 0.7)
//                            .stroke(
//                                AngularGradient(gradient: .init(colors: [Color.gray, Color.gray.opacity(0.5)]), center: .center), style: StrokeStyle(lineWidth: 6, lineCap: .round)
//                            )
//                            .rotationEffect(Angle(degrees: animate ? 360 : 0))
//                            .animation(Animation.linear(duration: 0.7).repeatForever(autoreverses: false))
//                    }.onAppear {
//                        self.animate.toggle()
//                    }.padding(75)
                    Text("Loading")
                },
                           image: {
                    Image(uiImage: $0).resizable()
                })
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 200, height: 200)
                    .clipped()
                Button(action: {
                    print("OK")
                }) {
                    Image(systemName: "heart")
                        .padding()
                        .foregroundColor(.red)
                }
            }
            
            Text(self.data.title)
                .font(.body)
                .bold()
                .padding(.leading)
                .padding(.trailing)
                .lineLimit(2)
                .multilineTextAlignment(TextAlignment.leading)
            
            Text("Rp.\(self.data.price)")
                .font(.body)
                .bold()
                .foregroundColor(.green)
                .padding(.leading)
                .padding(.trailing)
            
            Text(self.data.description)
                .font(.caption)
                .padding(.top, 2)
                .padding(.leading)
                .padding(.trailing)
                .lineLimit(3)
                .multilineTextAlignment(TextAlignment.leading)
            
            HStack {
                HStack {
                    ForEach(0 ..< Int(self.data.rating.rate)) {
                        items in
                            Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                            .frame(width: 10, height: 10)
                    }
                    Text("(\(self.data.rating.count))")
                        .font(.caption)
                }
            }
            .padding(.leading)
            .padding(.trailing)
            .padding(.top, 5)
            
            tambahKeranjang(keranjang: jumlahKeranjang)
        }
        .background(Color.gray.opacity(0.10))
        .cornerRadius(15)    }
}

struct tambahKeranjang : View {
//    @Binding var jumlah: Int
    @ObservedObject var keranjang : GlobalObject
    
    var body: some View {
        Button(action: {
            self.keranjang.jumlah += 1
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
