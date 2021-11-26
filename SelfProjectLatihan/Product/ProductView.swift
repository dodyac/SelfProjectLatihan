//
//  ProductView.swift
//  SelfProjectLatihan
//
//  Created by mac pro on 24/11/21.
//

import Foundation
import SwiftUI
struct ProductView : View {
    let data: ProductReal
    @ObservedObject var globalData: GlobalObject
    @State var isDeleteCartVisible = false
    @State var animate = false
    @State var confirmationShown = false
    var body: some View {
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
                    .frame(maxWidth: .infinity, minHeight: 200, maxHeight: 200)
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
            
            Text("$\(String(format: "%0.2f", self.data.price))")
                .font(.body)
                .bold()
                .foregroundColor(.green)
                .padding(.leading)
                .padding(.trailing)
            
//            Text(self.data.description)
//                .font(.caption)
//                .padding(.top, 2)
//                .padding(.leading)
//                .padding(.trailing)
//                .foregroundColor(.gray)
//                .lineLimit(3)
//                .multilineTextAlignment(TextAlignment.leading)
            
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
            
            if self.isDeleteCartVisible {
                Button("Remove from cart") {
                    confirmationShown = true
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(.red)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding()
                .confirmationDialog("Are you sure want to remove \(self.data.title) from cart?", isPresented: $confirmationShown,
                                    titleVisibility: .visible) {
                    Button("Yes", role: .destructive) {
                        let index = self.globalData.cart.firstIndex(where: {
                            $0.id == self.data.id
                        })
                        if let index = index {
                            self.globalData.cart.remove(at: index)
                        }
                    }
                    Button("Cancel", role: .cancel) {
                        
                    }
                }
            } else {
                tambahKeranjang(product: data, globalData: globalData)
            }
        }
        .background(Color.gray.opacity(0.10))
        .cornerRadius(15)
    }
}

