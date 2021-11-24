//
//  ProductDetail.swift
//  SelfProjectLatihan
//
//  Created by mac pro on 24/11/21.
//

import Foundation
import SwiftUI


struct ProductDetail : View {
    @State var data: ProductReal
    @State var confirmationShown = false
    
    @ObservedObject var jumlahKeranjang: GlobalObject
    @State var productLists = [ProductReal]()
//    func makeRequestProductById() {
//        apiRequestProduct(url: "https://fakestoreapi.com/products/\(idProduct)") { products in
//            product.self = product
//        }
//    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ZStack(alignment: .topTrailing) {
                    AsyncImage(url: URL(string: self.data.image)!,
                               placeholder: {
                        Text("Loading")
                    },
                               image: {
                        Image(uiImage: $0).resizable()
                    })
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: .infinity, minHeight: 350, maxHeight: 350)
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
                    .multilineTextAlignment(TextAlignment.leading)
                
                Text("$\(String(format: "%0.2f", self.data.price))")
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
                    .foregroundColor(.gray)
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
                
                HStack {
                    
                    Button("Update") {
                        
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    
                    Button("Delete") {
                        confirmationShown = true
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .confirmationDialog("Are you sure want to delete \(self.data.title)?", isPresented: $confirmationShown,
                                        titleVisibility: .visible) {
                        Button("Yes", role: .destructive) {
                            let index = self.productLists.firstIndex(where: {
                                $0.id == self.data.id
                            })
                            if let index = index {
                                self.productLists.remove(at: index)
                            }
                        }
                        Button("Cancel", role: .cancel) {
                            
                        }
                    }
                }
                .padding()
            }
            Spacer()
        }
    }
}
