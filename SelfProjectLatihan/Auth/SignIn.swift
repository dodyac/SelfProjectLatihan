//
//  SignIn.swift
//  SelfProjectLatihan
//
//  Created by mac pro on 23/11/21.
//

import Foundation
import SwiftUI
import AlertToast

struct SignIn : View {
    
    @State var username: String = ""
    @State var password: String = ""
    @State var isLoading = false
    @State var usernameEmpty = false
    @State var passwordEmpty = false
    @State var showToast = false
    @State var isValid = true
    
    
    @ObservedObject var globalData : GlobalObject
    
    func makeRequestSignIn() {
        apiRequestSignIn(url: "https://fakestoreapi.com/auth/login", username: username.lowercased(), password: password) { result in
            if result.status == "Error" {
                isValid = false
                globalData.isLogin = false
            } else {
                isValid = true
                globalData.isLogin = true
            }
            showToast = true
            isLoading = false
        }
    }
    
    var body: some View {
        ZStack {
            if isLoading {
                GeometryReader { geometry in
                    LoaderView()
                        .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                }.background(Color.black.opacity(0.45).edgesIgnoringSafeArea(.all))
                    .zIndex(1)
            }
            
            VStack(spacing:20) {
                Text("Hello Again!")
                    .bold()
                    .font(.largeTitle)
                Text("Welcome back")
                    .font(.title3)
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
                        if username.isEmpty {
                            usernameEmpty = true
                        } else {
                            usernameEmpty = false
                        }
                        
                        if password.isEmpty {
                            passwordEmpty = true
                        } else {
                            passwordEmpty = false
                        }
                        
                        if !usernameEmpty && !passwordEmpty {
                            makeRequestSignIn()
                            isLoading = true
                        }
                    }) {
                        Text("Sign In")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.blue)
                    .cornerRadius(10)
                    .foregroundColor(.white)
                    .padding(.top)
                    .confirmationDialog("Username cannot be empty!", isPresented: $usernameEmpty,
                                        titleVisibility: .visible) {
                        Button("OK", role: .cancel) {
                            
                        }
                    }
                    .confirmationDialog("Password cannot be empty!", isPresented: $passwordEmpty,
                                        titleVisibility: .visible) {
                        Button("OK", role: .cancel) {
                                    
                        }
                    }
                }
            }
            .padding(.all, 20)
        }.toast(isPresenting: $showToast) {
            var alert: AlertToast
            if isValid {
                alert = AlertToast(type: .complete(.green), title: "Successfully login to your account")
            } else {
                alert = AlertToast(type: .error(.red), title: "username or password is wrong")
            }
            return alert
        }
    }
}
