//
//  KeychainManager.swift
//  instaPocket
//
//  Created by Ислам Батыргереев on 23.12.2023.
//

import Foundation
import KeychainAccess


protocol KeychainManagerProtocol: AnyObject{
    func save(key: String, value: String)
    func load(key: String) -> Result<String, Error>
}


class KeychainManager: KeychainManagerProtocol{
    func save(key: String, value: String) {
        keychain[key] = value
    }
    
    func load(key: String) -> Result<String, Error> {
        do {
            let passcode = try keychain.getString(key) ?? ""
            return .success(passcode)
        } catch {
            return .failure(error)
        }
    }
    
    
    private let keychain = Keychain(service: "PASSCODE")
    
}

enum KeychainKeys: String{
    case passcode = "passcod3"
}
