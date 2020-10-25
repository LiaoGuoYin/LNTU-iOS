//
//  APIRouter.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/25.
//

import Alamofire
import Foundation

enum APIEducationRouter: URLRequestConvertible {
    
    case notice
    case classroom(week: Int, buildingName: String)
    
    case data(username: String, password: String)
    case info(username: String, password: String)
    case courseTable(username: String, password: String)
    
    case grade(username: String, password: String, semester: String)
    case gpa(username: String, password: String)
    
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case .classroom, .notice, .gpa, .grade:
            return .get
        case .data, .info, .courseTable:
            return .post
        }
    }
    
    // MARK: - Path
    private var path: String {
        switch self {
        case .notice:
            return "/education/notice"
        case .classroom:
            return "/education/classroom"
            
        case .data:
            return "/education/data"
        case .info:
            return "/education/info"
        case .courseTable:
            return "/education/course-table"
        case .grade:
            return "/education/grade"
        case .gpa:
            return "/education/gpa-all"
        }
    }
    
    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        case .classroom(let week, let buildingName):
            return [
                K.Education.week: week,
                K.Education.buildingName: buildingName
            ]
        case .grade(let username, let password, let semester):
            return [
                K.Education.username: username,
                K.Education.password: password,
                K.Education.semester: semester
            ]
        default:
            return nil
        }
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try K.Education.baseURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        // Parameters
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters)
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        return urlRequest
    }
}
