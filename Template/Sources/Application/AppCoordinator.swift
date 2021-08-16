//
//  AppCoordinator.swift
//  iOSTemplate
//
//  Created by doi on 2021/07/26.
//  Copyright © 2021 andfactory. All rights reserved.
//

import UIKit
import UserNotifications
import CoreSpotlight

final class AppCoordinator: Coordinator {
    private let window: UIWindow
    private let rootViewController: UINavigationController
    private var sampleGithubCoordinator: SampleGithubCoordinator
    private let launchType: LaunchType

    enum LaunchType {
        case normal
        case notification(UNNotificationRequest)
        case userActivity(NSUserActivity)
        case openURL(URL)
        case shortcutItem(UIApplicationShortcutItem)
    }

    init(window: UIWindow, launchType: LaunchType) {
        self.window = window
        rootViewController = .init()
        self.launchType = launchType

        sampleGithubCoordinator = SampleGithubCoordinator(navigator: rootViewController)
    }

    // swiftlint:disable cyclomatic_complexity
    func start() {
        window.rootViewController = rootViewController

        defer {
            window.makeKeyAndVisible()
        }

        switch launchType {
        case .normal:
            sampleGithubCoordinator.start()
        case .notification(let request):
            if request.trigger is UNPushNotificationTrigger {
                // remote notification
            } else if request.trigger is UNTimeIntervalNotificationTrigger {
                // local notification
            }
        case .userActivity(let userActivity):
            switch userActivity.activityType {
            case NSUserActivityTypeBrowsingWeb:
                break
            // universal links
            case CSSearchableItemActionType:
                break
            // Core spotlight
            case CSQueryContinuationActionType:
                break
            // Core soptlight (incremental search)
            default:
                fatalError("Unreachable userActivity:'\(userActivity.activityType)")
            }
        case .openURL(let url):
            print("open url: \(url)")
        case .shortcutItem(let shortcutItem):
            print("shotcut: \(shortcutItem)")
        }
    }
}
