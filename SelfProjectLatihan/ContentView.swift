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
    
    func makeRequestProduct() {
        apiRequestProduct(url: "https://fakestoreapi.com/products") { products in
            var tempList = [ProductReal]()
            
            for product in products {
                tempList.append(product)
            }
            productList.self = tempList
        }
    }

    @ObservedObject var globalData = GlobalObject()
    
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(productList) {
                    row in VStack(spacing: 10) {
                        ProductView(data: row, jumlahKeranjang: globalData)
                    }
                    .padding()
                }
            }
            .navigationBarTitle("iProducts")
            .navigationBarItems(trailing:
            HStack(spacing: 10){
                Button(action: {
                    print("image")
                }) {
                    Image(systemName: "person.fill")
                }
                NavigationLink(destination: DetailView(globalData: globalData)) {
                    cartView(jumlahKeranjang: globalData)
                }
            })
        }
        .onAppear {
            makeRequestProduct()
        }
        .accentColor(.secondary)
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
            Text("Detail")
                .navigationBarTitle("Detail")
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
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .topTrailing) {
                Image(systemName: "")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 200)
                    .clipped()
                    .foregroundColor(.blue)
                
//                Button(action: {
//                    print("OK")
//                }) {
//                    Image(systemName: "heart")
//                        .padding()
//                        .foregroundColor(.red)
//                }
            }
            
            Text(self.data.title)
                .font(.title2)
                .bold()
                .padding(.leading)
                .padding(.trailing)
            
            Text("Rp.\(self.data.price)")
                .font(.title3)
                .bold()
                .foregroundColor(.green)
                .padding(.leading)
                .padding(.trailing)
            
            Text(self.data.description)
                .font(.caption)
                .padding(.leading)
                .padding(.trailing)


            
            HStack {
                HStack {
//                    ForEach(0..<self.data.ratingCount) {
//                        items in
//                            Image(systemName: "star.fill")
//                            .foregroundColor(.yellow)
//                    }
                }
            }
            .padding(.leading)
            .padding(.trailing)
            
            tambahKeranjang(keranjang: jumlahKeranjang)
        }
        .background(Color.gray.opacity(0.10))
        .cornerRadius(15)
    }
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
                    Text("Tambah ke keranjang")
                        .font(.callout)
                        .padding()
                }
                Spacer()
            }
        }
        .background(.green)
        .foregroundColor(.white)
        .cornerRadius(10)
        .padding()
    }
}
