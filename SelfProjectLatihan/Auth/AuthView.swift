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
    
    @State var confirmationShown = false
    @State var isLogged = false
    var body: some View {
        ZStack {
            if isLogged {
                VStack {
                    Form {
                        Section() {
                            NavigationLink(destination: SignIn()){
                                HStack {
                                    Image(systemName: "person.crop.circle")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                        .clipShape(Circle())
                                                
                                    //Nama dan status
                                    VStack(alignment: .leading) {
                                        Text("Dody Ahmad").font(.headline)
                                        Text("Software Developer").font(.caption)
                                    }
                                }
                                .padding(.top, 10)
                                .padding(.bottom, 10)
                            }
                        }
                    }
                    
                    Button("Sign Out") {
                        confirmationShown = true
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding()
                    .confirmationDialog("Are you sure want sign out?", isPresented: $confirmationShown,
                                        titleVisibility: .visible) {
                        Button("Yes", role: .destructive) {

                        }
                        Button("Cancel", role: .cancel) {
                            
                        }
                    }
                }
            } else {
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
}
