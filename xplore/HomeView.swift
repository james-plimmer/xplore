//
//  HomeView.swift
//  xplore
//
//  Created by James Plimmer on 18/09/2024.
//

import SwiftUI
import Foundation
import Supabase
 
struct HomeView: View{
    
    let user = supabase.auth.currentUser?.email ?? "NONE"
    @State private var signedOut = false
    @State private var status = ""
    
    var body: some View {
        NavigationStack{
            VStack{
                
                Text("Welcome \(user)")
                
                Button("Log Out"){
                    signOutPressed()
                }
                .buttonStyle(.borderedProminent)
                .navigationDestination(isPresented: $signedOut){
                    SignInView()
                }
                
                if status != ""{
                    Text(status)
                }
                
            }
        }
        .navigationBarBackButtonHidden(true)
        
    }
    
    func signOutPressed(){
        Task {
            do {
                try await supabase.auth.signOut()
                signedOut = true
            } catch {
                status = "\(error.localizedDescription)"
            }
        }
    }
}
#Preview {
    HomeView()
}
