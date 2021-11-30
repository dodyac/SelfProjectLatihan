//
//  SignUp.swift
//  SelfProjectLatihan
//
//  Created by mac pro on 23/11/21.
//

import Foundation
import SwiftUI
import AlertToast

struct SignUp : View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing:20) {
                Text("Manage your product with us!")
                    .bold()
                    .font(.title)
                Text("Takes less than 10 minutes to fill out all the information needed to register your bussiness.")
                    .font(.caption)
                    .foregroundColor(.gray)
                FormBoxSignUp()
                    .padding(.top)
            }
            .padding(.all, 20)
        }
    }
}

struct FormBoxSignUp: View {
    
    @State var mail: String = ""
    @State var fname: String = ""
    @State var lname: String = ""
    @State var username: String = ""
    @State var password: String = ""
    @State var city: String = ""
    @State var street: String = ""
    @State var number: String = ""
    @State var zipcode: String = ""
    @State var phone: String = ""
    @State var usernameEmpty = false
    @State var passwordEmpty = false
    @State var mailEmpty = false
    
    @State var showToast = false
    @State var isLoading = false
    

    func makeRequestSignUp(user: UserPost) {
//        apiRequestSignUpFix(userPost: user) { result in
//            print("Result adalah \(result)")
//            isLoading = false
//
//        }
        apiRequestSignUp(url: "https://fakestoreapi.com/users", user: user) { result in
            print("Result adalah \(result)")
            isLoading = false
            showToast = true
            
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
            
            VStack(alignment: .leading) {
                Group {
                    Text("Email")
                        .bold()
                    TextField("Email...", text: $mail)
                        .padding(20)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                    
                    Text("First Name")
                        .bold()
                    TextField("First Name...", text: $fname)
                        .padding(20)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                    
                    Text("Last Name")
                        .bold()
                    TextField("Last Name...", text: $lname)
                        .padding(20)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)

                    Text("Username")
                        .bold()
                    TextField("Username...", text: $username)
                        .padding(20)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                }
                
                Text("Password")
                    .bold()
                SecureField("Password...", text: $password)
                    .padding(20)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                
                Group {
                    Text("City")
                        .bold()
                    TextField("City...", text: $city)
                        .padding(20)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                    
                    Text("Street")
                        .bold()
                    TextField("Street...", text: $street)
                        .padding(20)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                    
                    Text("Number")
                        .bold()
                    TextField("Number...", text: $number)
                        .keyboardType(.numberPad)
                        .padding(20)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                    
                    Text("Zip Code")
                        .bold()
                    TextField("Zip Code...", text: $zipcode)
                        .keyboardType(.numberPad)
                        .padding(20)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                }
                
                Text("Phone")
                    .bold()
                TextField("Phone...", text: $phone)
                    .keyboardType(.numberPad)
                    .padding(20)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                

                Button(action: {
                    if mail.isEmpty {
                        mailEmpty = true
                    } else {
                        mailEmpty = false
                    }
                    
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
                        let geoLocation = GeoLocation(lat: "2828282", long: "57.333")
                        
                        let address = Address(city: city, street: street, number: number, zipcode: zipcode, geolocation: geoLocation)
                        
                        let name = Name(firstname: fname, lastname: lname)
                        
                        let user = UserPost(id: 1, email: mail, username: username, password: password, name: name, address: address, phone: phone)
                        
                        makeRequestSignUp(user: user)
                        isLoading = true
                    }
                }){
                    Text("Sign Up")
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(.blue)
                .cornerRadius(10)
                .foregroundColor(.white)
                .padding(.top)
                .confirmationDialog("E-mail cannot be empty!", isPresented: $mailEmpty,
                                    titleVisibility: .visible) {
                    Button("OK", role: .cancel) {
                        
                    }
                }
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
        }.toast(isPresenting: $showToast) {
            AlertToast(type: .complete(.green), title: "Successfully register your account")
        }
    }
}
