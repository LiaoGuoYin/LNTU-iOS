//
//  APIRouter.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/25.
//

import Alamofire
import Foundation

enum APIEducationRouter: URLRequestConvertible {
    static var defaultParams = ["IMEICode": "nil"] // set the default params
    
    case notice
    case classroom(week: Int, buildingName: String)
    
    case data(user: User)
    case info(user: User)
    case courseTable(user: User, semester: String)
    
    case grade(user: User, semester: String)
    case gpa(user: User)
    
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
    
    // MARK: - Query Parameters
    private var queryParameters: Parameters? {
        var params = APIEducationRouter.defaultParams
        switch self {
        case .classroom(let week, let buildingName):
            params.updateValue(String(week), forKey: K.Education.week)
            params.updateValue(AllBuildingEnum(rawValue: buildingName)?.varName ?? "", forKey: K.Education.buildingName)
        case .courseTable(_, let semester):
            params.updateValue(semester, forKey: K.Education.semester)
        default:
            return nil
        }
        return params
    }
    
    // MARK: - POST Body Parameters
    private var parameters: Parameters? {
        switch self {
        case .grade(let user, _), .courseTable(let user, _), .info(let user):
            return [
                K.Education.username: user.username,
                K.Education.password: user.password,
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
        
        // Query Parameters
        if let actualQueryParameters = queryParameters {
            do {
                urlRequest = try URLEncoding.default.encode(urlRequest, with: actualQueryParameters)
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        
        // Body Parameters
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
