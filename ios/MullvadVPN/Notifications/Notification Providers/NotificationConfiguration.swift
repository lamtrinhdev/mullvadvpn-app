//
//  NotificationConfiguration.swift
//  MullvadVPN
//
//  Created by pronebird on 27/04/2023.
//  Copyright © 2025 Mullvad VPN AB. All rights reserved.
//

import Foundation

enum NotificationConfiguration {
    /**
     Duration measured in days, before the account expiry, when a system notification is scheduled to remind user
     to add more time on account.
     */
    static let closeToExpirySystemTriggerIntervals = [3, 1]

    /**
     Duration measured in days, before the account expiry, when an in-app notification is scheduled to remind user
     to add more time on account.
     */
    static let closeToExpiryInAppTriggerIntervals: [Int] = [3, 2, 1, 0]

    /**
     Time interval measured in seconds at which to refresh account expiry in-app notification, which reformats
     the duration until account expiry over time.
     */
    static let closeToExpiryInAppNotificationRefreshInterval = 60
}
