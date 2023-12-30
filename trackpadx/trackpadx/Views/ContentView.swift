//
//  ContentView.swift
//  trackpadx
//
//  Created by Pranchal Shah on 12/29/23.
//

import SwiftUI

struct ContentView: View {
   var server: Client = Client()

    var body: some View {
        NavigationView {
            VStack {
                List(server.discoveredDevices, id: \.self) { result in
                    // Display discovered devices in a list
                    Text("Hellow")
                }
                .listStyle(.plain)
                .navigationTitle("Discovered Devices")

                Button("Browse") {
                    server.startBrowsing()
                }
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

