//
//  Browser.swift
//  trackpadx
//
//  Created by Pranchal Shah on 12/29/23.
//

import Foundation
import Network

// A class for browsing Bonjour services using Network framework
class Browser {

    // An instance of NWBrowser for browsing Bonjour services
    let browser: NWBrowser

    init() {
        let parameters = NWParameters()
        parameters.includePeerToPeer = true

        browser = NWBrowser(for: .bonjour(type: "_superapp._tcp", domain: nil), using: parameters)
    }

    // Start browsing for Bonjour services with the specified handler
    // called when user presses "browse" on the page
    func start(handler: @escaping (NWBrowser.Result) -> Void) {
        browser.stateUpdateHandler = { newState in
            print("browser.stateUpdateHandler \(newState)")
        }
        browser.browseResultsChangedHandler = { results, changes in
            for result in results {
                if case NWEndpoint.service = result.endpoint {
                    handler(result)
                }
            }
        }
        browser.start(queue: .main)
    }
}
