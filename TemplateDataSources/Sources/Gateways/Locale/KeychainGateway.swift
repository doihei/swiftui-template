//
//  KeychainGateway.swift
//  iOSTemplate
//
//  Created by doi on 2021/07/26.
//  Copyright © 2021 andfactory. All rights reserved.
//

import KeychainAccess

final public class KeychainGateway {
    
    private let keychain: Keychain

    public init(keychain: Keychain = .init()) {
        self.keychain = keychain
    }

    var hasToken: Bool {
        return !(get(key: .token)?.isEmpty ?? true)
    }
    
    public func get(key: Key) -> String? {
        return keychain[key.rawValue]
    }
    
    public func set(key: Key, value: String) throws {
        do {
            try keychain.set(value, key: key.rawValue)
        } catch let error {
            throw error
        }
    }
    
    public func delete(key: Key) throws {
        do {
            try keychain.remove(key.rawValue)
        } catch let error {
            throw error
        }
    }
}

extension KeychainGateway {
    public enum Key: String {
        case token
        case refresh
        case expires
    }
}
