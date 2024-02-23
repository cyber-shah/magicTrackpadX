//
//  ContentView.swift
//  trackpadServer
//
//  Created by Pranchal Shah on 12/29/23.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationView {
                Button("Make device discoverable") {
                    server.startListening()
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
