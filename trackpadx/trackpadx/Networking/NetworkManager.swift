//
//  NetworkManager.swift
//  trackpadx
//
//  Created by Pranchal Shah on 12/29/23.
//

import Foundation
import Network

let client = Client();

class Client {

    // An object you use to browse for available network services.
    private var browser: NWBrowser
    // Store discovered devices
    @Published var discoveredDevices: [NWBrowser.Result] = []

    init() {
        // Initialize browser before using it
        browser = NWBrowser(for: .bonjour(type: "_superapp._tcp",
                                          domain: nil),
                            using: .tcp)
        }


    func startBrowsing() {
        // A handler that receives browser state updates.
        browser.stateUpdateHandler = { newState in
                    print("browser.stateUpdateHandler \(newState)")
                }

        // A handler that delivers updates about discovered services.
        browser.browseResultsChangedHandler = { results, changes in
                    for result in results {
                        if case NWEndpoint.service = result.endpoint {
                            print("browser.browseResultsChangedHandler result: \(result)" + result.endpoint.debugDescription)
                            self.handleDeviceDiscovered(result)
                        }
                    }
                }

        // Starts browsing for services, and sets the queue on which all browser events will be delivered.
        browser.start(queue: .main)
    }
    
    // Function to handle discovered devices
    private func handleDeviceDiscovered(_ result: NWBrowser.Result) {
            if !discoveredDevices.contains(result) {
                discoveredDevices.append(result)
            }
        }
}

