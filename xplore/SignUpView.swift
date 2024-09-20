//
//  AuthView.swift
//  xplore
//
//  Created by James Plimmer on 16/09/2024.
//

import Foundation
import SwiftUI
import Supabase

struct SignUpView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var status: String = ""
    @State private var isLoading = false
    @State private var isRegistered = false
    
    var body: some View {
        NavigationStack {
            
            
            VStack{
                Text("XPLORE")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                
                Form {
                    Section{
                        Label(
                            title: { Text("Email Address") },
                            icon: { Image(systemName: "envelope").foregroundStyle(.pink) }
                        )
                        TextField("Email", text: $email)
                    }
                    .textContentType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    
                    Section{
                        Label(
                            title: { Text("Password") },
                            icon: { Image(systemName: "key").foregroundStyle(.pink) }
                        )
                        
                        SecureField("Password", text: $password)
                    }
                    .textContentType(.password)
                    
                    Section {
                        Button(isLoading ? "Signing Up..." : "Sign Up"){
                            signUpButtonTapped()
                        }
                        .foregroundStyle(.pink)
                        .font(.title2.bold())
                        .navigationDestination(isPresented: $isRegistered) {
                            HomeView()
                        }
                        
                        if status != "" {
                            Text(status)
                        }
                        
                    }
                    
                    
                    NavigationLink("Already an Xplorer? Sign In Here!", destination: SignInView())
                        .foregroundStyle(.pink)
                }
                
                
            }
            .background(.pink)
        }
        .navigationBarBackButtonHidden(true)
        
    }
    
    func signUpButtonTapped(){
        
        guard !email.isEmpty, !password.isEmpty else {
            status = "Enter email and password!"
            return
        }
        
        Task {
            isLoading = true
            defer { isLoading = false }
            
            do {
                _ = try await supabase.auth.signUp(email: email, password: password)
                status = "Sucessfully Signed Up! "
                try await Task.sleep(nanoseconds: 1_000_000_000)
                isRegistered = true
            } catch {
                status = "\(error.localizedDescription)"
            }
        }
    }
}

#Preview {
    SignUpView()
}
