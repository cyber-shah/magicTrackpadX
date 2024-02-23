//
//  ContentView.swift
//  trackpadx
//
//  Created by Pranchal Shah on 12/29/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var client: Client = Client()
    
    var body: some View {
        NavigationView {
            VStack {
                List($client.discoveredDevices, id: \.self) { $result in
                    // Display discovered devices in a list
                    Text(String(describing: $result))
                }

                .listStyle(.plain)
                .navigationTitle("Discovered Devices")

                Button("Browse") {
                    client.startBrowsing()
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
