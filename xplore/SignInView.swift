//
//  SignInView.swift
//  xplore
//
//  Created by James Plimmer on 17/09/2024.
//

import Foundation
import SwiftUI
import Supabase

struct SignInView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var status: String = ""
    @State private var isLoading = false
    @State private var isSignedIn = false
    
    var body: some View {
        NavigationStack{
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
                        Button(isLoading ? "Signing In..." : "Sign In"){
                            signInButtonTapped()
                        }
                        .foregroundStyle(.pink)
                        .font(.title2.bold())
                        .navigationDestination(isPresented: $isSignedIn){
                            HomeView()
                        }
                        
                        if status != "" {
                            Text(status)
                        }
                    }
                    
                    
                    
                    NavigationLink("New Xplorer? Sign Up Here!", destination: SignUpView())
                        .foregroundStyle(.pink)
                        
                }
                
                
            }
            .background(.pink)
        }.navigationBarBackButtonHidden(true)
    }
    
    func signInButtonTapped(){
        
        guard !email.isEmpty, !password.isEmpty else {
            status = "Enter email and password!"
            return
        }
        
        Task {
            isLoading = true
            defer { isLoading = false }
            
            do {
                _ = try await supabase.auth.signIn(email: email, password: password)
                status = "Sucessfully Signed In!"
                try await Task.sleep(nanoseconds: 1_000_000_000)
                isSignedIn = true
            } catch {
                status = "\(error.localizedDescription)"
            }
        }
    }
}

#Preview {
    SignInView()
}

