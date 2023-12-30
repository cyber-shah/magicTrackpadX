//
//  Browser.swift
//  trackpadx
//
//  Created by Pranchal Shah on 12/29/23.
//

import Foundation
import Network

class Browser {

    let browser: NWBrowser

    init() {
        let parameters = NWParameters()
        parameters.includePeerToPeer = true

        browser = NWBrowser(for: .bonjour(type: "_superapp._tcp", domain: nil), using: parameters)
    }

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
