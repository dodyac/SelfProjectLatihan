//
//  ProductEdit.swift
//  SelfProjectLatihan
//
//  Created by mac pro on 25/11/21.
//

import Foundation
import SwiftUI
import MapKit

struct ProductEdit: View {
    @State var product: ProductReal
    @ObservedObject var globalData: GlobalObject
    @State var title: String = ""
    @State var description: String = ""
    @State var price: Double = 0.0
    
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                Text("Title")
                    .bold()
                TextField("Title...", text: $title)
                    .padding(20)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                
                Text("Description")
                    .bold()
                TextField("Description...", text: $description)
                    .padding(20)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                
//                Text("Price")
//                    .bold()
//                TextField("Price...", text: .constant(String(price)))
//                    .padding(20)
//                    .background(Color.gray.opacity(0.1))
//                    .cornerRadius(10)
                
                Button(action: {
                    let index = self.globalData.productList.firstIndex(where: {
                        $0.id == self.product.id
                    })
                    if let index = index {
                        self.product.title = self.title
                        self.product.description = self.description
//                        self.product.price = self.price
                        
                        self.globalData.productList.remove(at: index)
                        self.globalData.productList.insert(self.product, at: index)
                        NavigationUtil.popToRootView()
                    }
                }){
                    Text("Update")
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(.blue)
                .cornerRadius(10)
                .foregroundColor(.white)
                .padding(.top)
            }
        }
        .padding(.all, 20)
    }
}

struct NavigationUtil {
  static func popToRootView() {
    findNavigationController(viewController: UIApplication.shared.windows.filter { $0.isKeyWindow }.first?.rootViewController)?
      .popToRootViewController(animated: true)
  }

  static func findNavigationController(viewController: UIViewController?) -> UINavigationController? {
    guard let viewController = viewController else {
      return nil
    }

    if let navigationController = viewController as? UINavigationController {
      return navigationController
    }

    for childViewController in viewController.children {
      return findNavigationController(viewController: childViewController)
    }

    return nil
  }
}
