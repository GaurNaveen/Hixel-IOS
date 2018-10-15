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
    case userData()
    case resetEmail(email: String)
    case resetCode(email: String, code: String)
    case resetPassword(email: String, code: String, password: String)
    case changePassword(oldPassword: String, newPassword: String)
    case refresh(token: String)
    
    case companydata(tickers: String, years: Int)
    case search(query: String)
    
    // "meta/"
    case ratios
}

extension ServerInterface: TargetType, AccessTokenAuthorizable {

    var baseURL: URL { return URL(string: "https://game.bones-underground.org:8443")! }

    var path: String {
        switch self {
            case .login:
                return "/login"
            case .signup:
                return "/users/sign-up"
            case .refresh:
                return "/users/refresh"
            case .userData:
                return "users/profile"
            case .resetEmail:
                return "users/reset-email"
            case .resetCode:
                return "users/reset-code"
            case .resetPassword:
                return "users/reset-password"
            case .changePassword:
                return "users/change-password"
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
            case .resetEmail(let email):
                return .requestParameters(parameters: ["email": email], encoding: URLEncoding.queryString)
            case .resetCode(let email, let code):
                return .requestParameters(parameters: ["email": email, "code": code], encoding: URLEncoding.queryString)
            case .resetPassword(let email, let code, let password):
                return .requestParameters(parameters: ["email": email, "code": code, "password": password], encoding: URLEncoding.queryString)
            case .changePassword(let oldPassword, let newPassword):
                return .requestParameters(parameters: ["oldPassword": oldPassword, "newPassword": newPassword], encoding: URLEncoding.queryString)
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
            case .login, .signup, .resetEmail, .resetCode, .resetPassword:
                break
            case .refresh:
                h["Refresh"] = Credentials.currentCredentials().refreshToken
            default:
                h["Authorization"] = Credentials.currentCredentials().authToken
        }
        
        return h
    }
    
    var authorizationType: AuthorizationType {
        switch self {
            case .login, .signup, .resetEmail, .resetCode, .resetPassword:
                return .none
            default:
                return .bearer
        }
    }
    
    var sampleData: Data {
        return Data()
    }
}
