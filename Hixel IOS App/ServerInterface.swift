//
//  ServerInterface.swift
//  Hixel IOS App
//
//  Created by Jonah Jeleniewski on 11/9/18.
//

import Foundation
import Moya

enum ServerInterface {
    
    case login(loginData: LoginData)
    
    // "users/"
    case signup(applicationUser: ApplicationUser)
    case refresh(token: String)
    
    case companydata(tickers: String, years: Int)
    case search(query: String)
    
    // "meta/"
    case ratios
}

extension ServerInterface: TargetType {

    var baseURL: URL { return URL(string: "https://game.bones-underground.org:8443")! }

    var path: String {
        switch self {
            case .login:
                return "/login"
            case .signup:
                return "/users/sign-up"
            case .refresh:
                return "/users/refresh"
            case .companydata:
                return "/companydata"
            case .search:
                return "/search"
            case .ratios:
                return "meta/ratios"
        }
    }
    
    var method: Moya.Method {
        switch self {
            case .login, .signup:
                return .post
            default:
                return .get
        }
    }
    
    var task: Task {
        switch self {
            case .login(let loginData):
                return .requestJSONEncodable(loginData)
            case .signup(let applicationUser):
                return .requestJSONEncodable(applicationUser)
            case .companydata(let tickers, let years):
                return .requestParameters(parameters: ["tickers": tickers, "years": years], encoding: URLEncoding.queryString)
            case .search(let query):
                return .requestParameters(parameters: ["query": query], encoding: URLEncoding.queryString)
            default:
                return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        var h = ["Content-type": "application/json"]
        
        switch self {
            case .login, .signup:
                break
            case .refresh:
                h["Refresh"] = Credentials.currentCredentials().refreshToken
            default:
                h["Authorization"] = Credentials.currentCredentials().authToken
        }
        
        return h
    }
    
    var sampleData: Data {
        return Data()
    }
}
