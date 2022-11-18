//
//  LoginView.swift
//  Exam
//
//  Created by Pauline Broängen on 2022-11-09.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var dbConnection: DatabaseConnection
    
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        
        VStack(spacing: 30) {
            Image("logo")
            
            Text("Please log in").bold().font(.title)
            
            VStack(alignment: .leading) {
                Text("Email")
                TextField("", text: $email).textFieldStyle(.roundedBorder)
                
                Text("Password")
                SecureField("", text: $password).textFieldStyle(.roundedBorder)
            }.padding()
            
            Button(action: {
                if email != "" && password != "" {
                    dbConnection.LoginUser(email: email, password: password)
                }
            }, label: {
                Text("Login").padding().background(.black).foregroundColor(.white).cornerRadius(9)
            })
            
            NavigationLink(destination: RegisterView(), label: {
                Text("Register an account").foregroundColor(.black).bold()
            })
        }.padding().padding()
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

