//
//  NetworkManager.swift
//  trackpadx
//
//  Created by Pranchal Shah on 12/29/23.
//

import Foundation
import Network

class NetworkingManager {

    private var browser: NWBrowser

    init() {
        // Initialize browser before using it
        browser = NWBrowser(for: .bonjour(type: "_your-service-name._tcp", 
                                          domain: nil),
                            using: .tcp)
        }


    func startBrowsing() {
        browser.stateUpdateHandler = { state in
            // for each STATE
            switch state {
                // if case is ready:
                case .ready:
                    print("Browser is ready")

                // if case is failed
                case .failed(let error):
                    print("Browser failed with error: \(error)")

                default:
                    break
            }
        }

        browser.browseResultsChangedHandler = { changes in
            for change in changes {
                switch change {
                case .added(let endpoint):
                    print("Found service at \(endpoint)")
                    // Establish a connection to the discovered endpoint
                    let connection = NWConnection(to: endpoint, using: .tcp)
                    connection.start(queue: .main)

                case .removed(let endpoint):
                    print("Service removed at \(endpoint)")

                default:
                    break
                }
            }
        }

        browser.start(queue: .main)
    }
}

