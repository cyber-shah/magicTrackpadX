//
//  NetworkManager.swift
//  trackpadx
//
//  Created by Pranchal Shah on 12/29/23.
//

import Foundation

func sendDataToMac() {
    let url = URL(string: "http://mac-local-ip:port/api/trackpad")!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    // Encode your data here
    let dataToSend = ["gesture": "swipe"]
    let jsonData = try? JSONSerialization.data(withJSONObject: dataToSend)

    request.httpBody = jsonData
    
    let task = URLSession.shared.dataTask(with: request) { data, _, error in
        if let error = error {
            print("Error: \(error)")
        } else {
            print("Data sent successfully!")
        }
    }

    task.resume()
}

