//
//  SignIn.swift
//  SelfProjectLatihan
//
//  Created by mac pro on 23/11/21.
//

import Foundation
import SwiftUI

struct SignIn : View {
    var body: some View {
        VStack(spacing:20) {
            Text("Hello Again!")
                .bold()
                .font(.largeTitle)
            Text("Welcome back")
                .font(.title3)
            FormBox()
        }
        .padding(.all, 20)
    }
}

struct FormBox: View {
    
    @State var username: String = ""
    @State var password: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Username")
                .bold()
            TextField("Username...", text: $username)
                .padding(20)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
            
            Text("Password")
                .bold()
            SecureField("Password...", text: $password)
                .padding(20)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)

            Button(action: {
                print("Hello \(username) \(password)")
            }){
                Text("Sign In")
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(.blue)
            .cornerRadius(10)
            .foregroundColor(.white)
            .padding(.top)
        }
    }
}
