//
//  Client.swift
//  Hixel IOS App
//
//  Created by Jonah Jeleniewski on 11/9/18.

import Foundation
import Moya
import RxSwift

/// Instances of this class are used to make network requests to the CorpReport Server
final class Client {
    
    /// Interfaces with the CorpReport Server
    /// The Client class is a wrapper around this MoyaProvider
    private let provider: MoyaProvider<ServerInterface>
    
    init() {
        self.provider = MoyaProvider()
    }
    
    /// This method is used to make network requests.
    /// It also quietly reauthorizes with the Refresh Token when the server returns 401.
    /// It's effectively just a wrapper on MoyaProvider.rx.request that adds auth flow logic.
    ///
    /// - Parameter token: The Moya enum of the request being made (See ServerInterface)
    /// - Returns: A MoyaResponse containing data received from the CorpReport Server
    func request(_ token: ServerInterface) -> Single<Moya.Response> {
        let request = provider.rx.request(token)
        return request
            .flatMap { response in
                if response.statusCode == 401 && token.authorizationType == .bearer {
                    let oldCredentials = Credentials.currentCredentials()
                    return self.refreshAuthorization(oldCredentials: oldCredentials)
                        .do(onSuccess: {
                            Credentials.setCredentials(newCredentials: $0)
                        })
                        .flatMap { _ in return self.request(token) }
                } else {
                    return Single.just(response)
                }
            }
    }
    

    /// Refreshes the current credentials: Access Token and Refresh Token
    ///
    /// - Parameter oldCredentials: The user's credentials
    /// - Returns: A Disposable object
    private func refreshAuthorization(oldCredentials: Credentials) -> Single<Credentials> {
        return Single.create { subscriber in
            self.provider.request(.refresh(token: oldCredentials.refreshToken)) { result in
                switch result {
                    case let .success(response):
                        do {
                            _ = try response.filterSuccessfulStatusCodes()
                            let authToken = response.response?.allHeaderFields["Authorization"] as? String
                            let refreshToken = response.response?.allHeaderFields["Refresh"] as? String
                            
                            subscriber(.success(Credentials(authToken: authToken ?? "",
                                                            refreshToken: refreshToken ?? "")))
                        }
                        catch let error {
                            subscriber(.error(error))
                        }
                    
                    case let .failure(error):
                        subscriber(.error(error))
                    }
                }
            return Disposables.create()
        }
    }
}
