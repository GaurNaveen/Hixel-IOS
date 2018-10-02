//
//  Credentials.swift
//  Hixel IOS App
//
//  Created by Jonah Jeleniewski on 3/03/18.
//

import Foundation
import KeychainSwift

class Credentials {
    let authToken : String
    let refreshToken : String
    
    init(authToken : String, refreshToken : String) {
        self.authToken = authToken
        self.refreshToken = refreshToken
    }
    
    static func currentCredentials() -> Credentials {
        let keychain = KeychainSwift()
        
        return Credentials(authToken: keychain.get("authToken") ?? "",
                           refreshToken: keychain.get("refreshToken") ?? "")
    }
    
    static func setCredentials(newCredentials : Credentials) {
        let keychain = KeychainSwift()
        
        keychain.set(newCredentials.authToken, forKey: "authToken")
        keychain.set(newCredentials.refreshToken, forKey: "refreshToken")
    }
}
