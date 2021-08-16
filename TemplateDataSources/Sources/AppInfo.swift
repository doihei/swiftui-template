//
//  AppInfo.swift
//  TemplateDataSources
//
//  Created by doi on 2021/07/26.
//  Copyright © 2021 andfactory. All rights reserved.
//

import Foundation
import UIKit

final class AppInfo {
    /// ShortVersionStringを返す
    static var shortVersionString: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }

    /// ビルドの取得
    ///
    /// - Returns: String
    static func bundleVersion() -> String {
        return (Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String) ?? ""
    }

    /// osのバージョン取得
    ///
    /// - Returns: String
    static func osVersion() -> String {
        return UIDevice.current.systemVersion
    }

    /// アプリのバージョンをn.m.l => n * 10000 + m * 100 + l のInt形式で返す
    ///
    /// - Returns: Int
    static func versionInInteger() -> Int {
        let shortVersionString = self.shortVersionString

        return versionStringToInt(versionString: shortVersionString,
                                  majorNumberTimes: 10000,
                                  minorNumberTimes: 100)
    }

    /// iOSのバージョンをn.m.l => n * 10000 + m * 100 + l のInt形式で返す
    ///
    /// - Returns: Int
    static func osVersionInInteger() -> Int {
        let currentSystemVersion = UIDevice.current.systemVersion

        return versionStringToInt(versionString: currentSystemVersion,
                                  majorNumberTimes: 10000,
                                  minorNumberTimes: 100)
    }

    /// バージョン表記(n.m.l)の文字列をInt型にして返す
    /// n.m.l => n * majorNumberTimes + m * minorNumberTimes + l のInt形式、
    /// nは必須だが m, l はオプションで表記されているものとする。
    /// ex-1) 10 => 10 * majorNumberTimes を返す
    /// ex-2) 10.3 => 10 * majorNumberTImes + 3 * minorNumberTimes を返す
    ///
    /// - Parameters:
    ///   - versionString: n.m.l のバージョン表記文字列
    ///   - majorNumberTimes: nの桁に掛ける数値(ex: 10000)
    ///   - minorNumberTimes: mの桁に掛ける数値(ex: 100)
    /// - Returns: Int
    private static func versionStringToInt(versionString: String?, majorNumberTimes: Int, minorNumberTimes: Int) -> Int {
        guard let versions = versionString?.components(separatedBy: ".") else {
            return 0
        }

        return versions.enumerated().reduce(0, { lhs, rhs in
            if rhs.0 == 0 {
                return lhs + (Int(rhs.1) ?? 0) * majorNumberTimes
            } else if rhs.0 == 1 {
                return lhs + (Int(rhs.1) ?? 0) * minorNumberTimes
            } else if rhs.0 == 2 {
                return lhs + (Int(rhs.1) ?? 0)
            } else {
                // . で区切られた4つ目以降のバージョン表記は無効とみなす
                return lhs
            }
        })
    }
}
