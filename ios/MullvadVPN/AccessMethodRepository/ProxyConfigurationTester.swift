//
//  ProxyConfigurationTester.swift
//  MullvadVPN
//
//  Created by pronebird on 28/11/2023.
//  Copyright © 2025 Mullvad VPN AB. All rights reserved.
//

import Combine
import Foundation
import MullvadREST
import MullvadSettings
import MullvadTypes

/// A concrete implementation of an access method proxy configuration.
class ProxyConfigurationTester: ProxyConfigurationTesterProtocol {
    private var cancellable: MullvadTypes.Cancellable?
    private let transportProvider: ProxyConfigurationTransportProvider
    private var headRequest: REST.APIAvailabilityTestRequest?

    init(transportProvider: ProxyConfigurationTransportProvider) {
        self.transportProvider = transportProvider
    }

    func start(configuration: PersistentProxyConfiguration, completion: @escaping @Sendable (Error?) -> Void) {
        do {
            let transport = try transportProvider.makeTransport(with: configuration)
            let request = REST.APIAvailabilityTestRequest(transport: transport)
            headRequest = request
            cancellable = request.makeRequest { error in
                DispatchQueue.main.async {
                    completion(error)
                }
            }
        } catch {
            completion(error)
        }
    }

    func cancel() {
        cancellable?.cancel()
        cancellable = nil
        headRequest = nil
    }
}
