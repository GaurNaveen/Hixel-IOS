//
//  Client.swift
//  Hixel IOS App
//
//  Created by Jonah Jeleniewski on 11/9/18.

import Foundation
import Moya
import RxSwift

final class Client {
    
    private let provider: MoyaProvider<ServerInterface>
    
    init() {
        self.provider = MoyaProvider()
    }
    
    func request(_ token: ServerInterface) -> Single<Moya.Response> {
        let request = provider.rx.request(token)
        return request
            .flatMap { response in
                if response.statusCode == 401 && token.authorizationType == .bearer {
                    let oldCredentials = Credentials.currentCredentials()
                    return self.refreshSessionToken(oldCredentials: oldCredentials)
                        .do(onSuccess: {
                            Credentials.setCredentials(newCredentials: $0)
                        })
                        .flatMap { _ in return self.request(token) }
                } else {
                    return Single.just(response)
                }
            }
    }
    

    private func refreshSessionToken(oldCredentials: Credentials) -> Single<Credentials> {
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
