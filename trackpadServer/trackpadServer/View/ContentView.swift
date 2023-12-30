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
            VStack {
                Button("Browse") {
                    server.startListening()
                }
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
