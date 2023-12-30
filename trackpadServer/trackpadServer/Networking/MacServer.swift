//
//  MacServer.swift
//  trackpadServer
//
//  Created by Pranchal Shah on 12/29/23.
//

import Foundation
import Network

let server = MacServer();

class MacServer {

    private var listener: NWListener?
    private var connections: Set<NWConnection> = []

    init() {
        let tcpOptions = NWProtocolTCP.Options()
                tcpOptions.enableKeepalive = true
                tcpOptions.keepaliveIdle = 2
        let parameters = NWParameters(tls: nil, tcp: tcpOptions)
                parameters.includePeerToPeer = true
        do {
            listener = try NWListener(using: parameters)
            listener?.service = NWListener.Service(name: "server", type: "_superapp._tcp")
        } catch {
            print("Error creating NWListener: \(error)")
            // Handle the error appropriately, e.g., by terminating the application or taking corrective action.
        }
    }

    func startListening() {
        listener?.stateUpdateHandler = { newState in
            print("listener.stateUpdateHandler \(newState)")
        }

        listener?.newConnectionHandler = { newConnection in
            self.handleNewConnection(newConnection)
        }

        listener?.start(queue: .main)
    }

    private func handleNewConnection(_ newConnection: NWConnection) {
        newConnection.stateUpdateHandler = { newState in
            print("newConnection.stateUpdateHandler \(newState)")
            switch newState {
            case .ready:

                print("Connection ready!")
            case .failed(let error):
                // Handle the failure.
                print("Connection failed: \(error)")
            default:
                break
            }
        }

        // Start the connection.
        newConnection.start(queue: .main)

        // Add the connection to your set of connections.
        self.connections.insert(newConnection)
    }
}

extension NWConnection: Hashable {
    public func hash(into hasher: inout Hasher) {
        // Use a unique identifier for each connection, for example, the debugDescription.
        hasher.combine(debugDescription)
    }

    public static func == (lhs: NWConnection, rhs: NWConnection) -> Bool {
        // Compare connections based on their debugDescription.
        return lhs.debugDescription == rhs.debugDescription
    }
}
