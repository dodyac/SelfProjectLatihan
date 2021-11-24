//
//  AuthView.swift
//  SelfProjectLatihan
//
//  Created by mac pro on 23/11/21.
//

import Foundation
import SwiftUI


struct AccountIcon : View {
    
    var body: some View {
        ZStack {
            Image(systemName: "person.fill")
                .resizable()
                .frame(width: 20, height: 20)
        }
    }
}



struct AuthView : View {
    var body: some View {
        ZStack {
            TabView {
                SignIn()
                    .tabItem {
                        Image(systemName: "person.crop.circle")
                        Text("Sign In")
                    }
                SignUp()
                    .tabItem {
                        Image(systemName: "person.crop.circle.badge.plus")
                        Text("Sign Up")
                    }
            }
        }
    }
}
