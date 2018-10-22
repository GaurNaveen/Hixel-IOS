//
//  Credentials.swift
//  Hixel IOS App
//
//  Created by Jonah Jeleniewski on 3/03/18.
//

import Foundation
import KeychainSwift

/// Represents the user's current authorization
class Credentials {
    /// The user's current Access Token (Expires frequently)
    let accessToken : String

    /// The user's current Refresh Token (Expires rarely)
    let refreshToken : String

    init(authToken : String, refreshToken : String) {
        self.accessToken = authToken
        self.refreshToken = refreshToken
    }
    
    
    /// Retrieves the user's Access and Refresh tokens from the keychain
    ///
    /// - Returns: The user's Access and Refresh tokens as a Credentials object
    static func currentCredentials() -> Credentials {
        let keychain = KeychainSwift()
        
        return Credentials(authToken: keychain.get("accessToken") ?? "",
                           refreshToken: keychain.get("refreshToken") ?? "")
    }
    
    
    /// Sets new values for the user's Access and Refresh tokens in the keychain
    ///
    /// - Parameter newCredentials: The user's new credentials - Contains the new token values
    static func setCredentials(newCredentials : Credentials) {
        let keychain = KeychainSwift()
        
        keychain.set(newCredentials.accessToken, forKey: "accessToken")
        keychain.set(newCredentials.refreshToken, forKey: "refreshToken")
    }
}
