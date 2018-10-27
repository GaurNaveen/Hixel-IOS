//
//  ServerInterface.swift
//  Hixel IOS App
//
//  Created by Jonah Jeleniewski on 11/9/18.
//

import Foundation
import Moya

/// The different requests that can be performed
///
/// - login: Log in to the CorpReport Server
/// - signup: Create a new account
/// - userData: Get information about this user
/// - addCompany: Adds a company to the user's portfolio
/// - removeCompany: Removes a company from the user's portfolio
/// - resetEmail: Request a password-reset email
/// - resetCode: Check the validity of a reset-code
/// - resetPassword: Reset password with a reset-code
/// - changePassword: Change current password
/// - refresh: Request a new Access Token and Refresh Token
/// - companydata: Request data about companies
/// - search: Query for companies with names or tickers matching a search termm
enum ServerInterface {
    
    case login(loginData: LoginData)
    
    // "users/"
    case signup(applicationUser: ApplicationUser)
    case userData()
    case addCompany(ticker: String)
    case removeCompany(ticker: String)
    case resetEmail(email: String)
    case resetCode(email: String, code: String)
    case resetPassword(email: String, code: String, password: String)
    case changePassword(oldPassword: String, newPassword: String)
    case refresh(token: String)
    
    case companydata(tickers: String, years: Int)
    case search(query: String)
}

extension ServerInterface: TargetType, AccessTokenAuthorizable {

    /// The base URL which the path is appended to
    var baseURL: URL { return URL(string: "https://game.bones-underground.org:8443")! }

    /// The URL path to the API endpoint. This gets appended to baseURL
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
            case .addCompany, .removeCompany:
                return "users/portfolio/company"
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
        }
    }
    
    /// Represents what kind of request this will be (GET, POST, DELETE, etc.)
    var method: Moya.Method {
        switch self {
            case .login, .signup, .addCompany:
                return .post
            case .removeCompany:
                return .delete
            default:
                return .get
        }
    }
    
    /// Controls how data is encoded and sent to the server (JSON, URL parameters, etc.)
    var task: Task {
        switch self {
            case .login(let loginData):
                return .requestJSONEncodable(loginData)
            case .signup(let applicationUser):
                return .requestJSONEncodable(applicationUser)
            case .addCompany(let ticker):
                return .requestParameters(parameters: ["ticker": ticker], encoding: URLEncoding.queryString)
            case .removeCompany(let ticker):
                return .requestParameters(parameters: ["ticker": ticker], encoding: URLEncoding.queryString)
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
    
    /// Controls which headers will be sent with the request
    var headers: [String : String]? {
        var h = ["Content-type": "application/json"]
        
        switch self {
            case .login, .signup, .resetEmail, .resetCode, .resetPassword:
                break
            case .refresh:
                h["Refresh"] = Credentials.currentCredentials().refreshToken
            default:
                h["Authorization"] = Credentials.currentCredentials().accessToken
        }
        
        return h
    }
    
    /// Controls the level of authorization
    var authorizationType: AuthorizationType {
        switch self {
            case .login, .signup, .resetEmail, .resetCode, .resetPassword:
                return .none
            default:
                return .bearer
        }
    }
    
    /// Sample data which is used for testing
    var sampleData: Data {
        return Data()
    }
}
