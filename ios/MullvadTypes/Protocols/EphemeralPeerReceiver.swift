//
//  PostQuantumKeyReceiver.swift
//  MullvadTypes
//
//  Created by Marco Nikic on 2024-07-04.
//  Copyright © 2025 Mullvad VPN AB. All rights reserved.
//

import Foundation
import NetworkExtension
import WireGuardKitTypes

public class EphemeralPeerReceiver: EphemeralPeerReceiving, TunnelProvider {
    public func tunnelHandle() throws -> Int32 {
        try tunnelProvider.tunnelHandle()
    }

    public func wgFunctions() -> WgFunctionPointers {
        tunnelProvider.wgFunctions()
    }

    unowned let tunnelProvider: any TunnelProvider
    let keyReceiver: any EphemeralPeerReceiving

    public init(tunnelProvider: TunnelProvider, keyReceiver: any EphemeralPeerReceiving) {
        self.tunnelProvider = tunnelProvider
        self.keyReceiver = keyReceiver
    }

    // MARK: - EphemeralPeerReceiving

    public func receivePostQuantumKey(
        _ key: PreSharedKey,
        ephemeralKey: PrivateKey,
        daitaParameters: DaitaV2Parameters?
    ) {
        let semaphore = DispatchSemaphore(value: 0)
        Task {
            await keyReceiver.receivePostQuantumKey(key, ephemeralKey: ephemeralKey, daitaParameters: daitaParameters)
            semaphore.signal()
        }
        semaphore.wait()
    }

    public func receiveEphemeralPeerPrivateKey(
        _ ephemeralPeerPrivateKey: PrivateKey,
        daitaParameters: DaitaV2Parameters?
    ) {
        let semaphore = DispatchSemaphore(value: 0)
        Task {
            await keyReceiver.receiveEphemeralPeerPrivateKey(ephemeralPeerPrivateKey, daitaParameters: daitaParameters)
            semaphore.signal()
        }
        semaphore.wait()
    }

    public func ephemeralPeerExchangeFailed() {
        keyReceiver.ephemeralPeerExchangeFailed()
    }
}
