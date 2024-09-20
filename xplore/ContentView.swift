//
//  ContentView.swift
//  xplore
//
//  Created by James Plimmer on 16/09/2024.
//

import SwiftUI
import Supabase

struct ContentView: View {
    
    var loggedIn: String = supabase.auth.currentUser?.email ?? "NONE"

    var body: some View {
        
        if loggedIn != "NONE"{
            HomeView()
        }
        else{
            SignInView()
        }
    }
}

#Preview {
    ContentView()
}
