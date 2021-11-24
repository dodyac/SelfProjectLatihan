//
//  SignUp.swift
//  SelfProjectLatihan
//
//  Created by mac pro on 23/11/21.
//

import Foundation
import SwiftUI

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
    
    var body: some View {
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
                    .padding(20)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                
                Text("Zip Code")
                    .bold()
                TextField("Zip Code...", text: $zipcode)
                    .padding(20)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
            }
            
            Text("Phone")
                .bold()
            TextField("Phone...", text: $phone)
                .padding(20)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
            

            Button(action: {
                print("Hello \(username) \(password)")
            }){
                Text("Sign Up")
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
