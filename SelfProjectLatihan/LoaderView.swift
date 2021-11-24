//
//  LoaderView.swift
//  SelfProjectLatihan
//
//  Created by mac pro on 24/11/21.
//

import Foundation
import SwiftUI

struct LoaderView : View {
    @State var text: String = "Please Wait..."
    @State var background: Color = .white
    @State var animate = false
    var body: some View {
        VStack {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                .scaleEffect(3)
                .frame(width: 40, height: 40)
                .padding()
            
            Text(text)
        }
        .padding()
        .background(background)
        .cornerRadius(15)
        .onAppear {
            self.animate.toggle()
        }
    }
}
