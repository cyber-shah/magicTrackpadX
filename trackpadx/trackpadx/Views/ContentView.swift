//
//  ContentView.swift
//  trackpadx
//
//  Created by Pranchal Shah on 12/29/23.
//

import SwiftUI
import Foundation


struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.medium)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            Button("Send data to Mac") {
                sendDataToMac();
            }
            
        }
        .padding()
    }

}

#Preview {
    ContentView()
}


