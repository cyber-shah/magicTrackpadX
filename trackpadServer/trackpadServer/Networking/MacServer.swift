//
//  MacServer.swift
//  trackpadServer
//
//  Created by Pranchal Shah on 12/29/23.
//

import Foundation
import Network

class MacServer {

    private var listener: NWListener
    private var connections: Set<NWConnection> = []

    init() {
        listener = try! NWListener(using: .tcp, on: 0) // 0 means the system will assign a random available port
    }

    func startListening() {
        listener.stateUpdateHandler = { newState in
            print("listener.stateUpdateHandler \(newState)")
        }

        listener.newConnectionHandler = { newConnection in
            self.handleNewConnection(newConnection)
        }

        listener.start(queue: .main)
    }

    private func handleNewConnection(_ newConnection: NWConnection) {
        newConnection.stateUpdateHandler = { newState in
            print("newConnection.stateUpdateHandler \(newState)")
            switch newState {
            case .ready:
                // The connection is established and ready for communication.
                // Handle your magic trackpad logic here.
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
