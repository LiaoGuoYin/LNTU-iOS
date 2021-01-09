//
//  APIRouter.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/25.
//

import Alamofire
import Foundation

enum APIEducationRouter: URLRequestConvertible {
    
    case initHelperMessage
    case notice
    case classroom(week: Int, buildingName: String)
    
    case data(user: User)
    case info(user: User)
    case courseTable(user: User, semester: String)
    case grade(user: User)
    case examPlan(user: User, semester: String, offline: Bool)
    case otherExam(user: User)
    
    case qualityActivity(user: User)
    
    case notification(type: NotificationRequestType, username: String, token: String)
    
    enum NotificationRequestType {
        case register
        case remove
    }
    
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case .classroom, .notice, .initHelperMessage:
            return .get
        case .data, .info, .courseTable, .grade, .examPlan, .otherExam, .qualityActivity, .notification:
            return .post
        }
    }
    
    // MARK: - Path
    private var path: String {
        switch self {
        case .initHelperMessage:
            return "/education/init"
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
        case .examPlan:
            return "/education/exam"
        case .otherExam:
            return "/education/other-exam"
        case .qualityActivity:
            return "/quality/activity"
        case .notification(let type, _, _):
            switch type {
            case .register:
                return "/app/notification-register"
            default:
                return "/app/notification-remove"
            }
        }
    }
    
    // MARK: - Query Item Parameters
    private var queryItemParams: [URLQueryItem]? {
        var queryItemParamList = [URLQueryItem(name: K.imei, value: "imei"),
                                  URLQueryItem(name: K.offline, value: String(UserDefaults.standard[.isOffline] ?? false))]
        switch self {
        case .classroom(let week, let buildingName):
            queryItemParamList.append(contentsOf: [URLQueryItem(name: K.Education.week, value: String(week)),
                                                   URLQueryItem(name: K.Education.buildingName, value: AllBuildingEnum(rawValue: buildingName)?.varName ?? "")])
        case .courseTable(_, let semester):
            queryItemParamList.append(contentsOf: [URLQueryItem(name: K.Education.semester, value: semester)])
        case .examPlan(_, let semester, _):
            queryItemParamList.append(contentsOf: [URLQueryItem(name: K.Education.semester, value: semester)])
        default:
            return queryItemParamList
        }
        return queryItemParamList
    }
    
    // MARK: - POST Body Parameters
    private var parameters: Parameters? {
        switch self {
        case .courseTable(let user, _), .info(let user), .grade(let user), .data(let user), .examPlan(let user, _, _), .otherExam(let user), .qualityActivity(let user):
            return [
                K.Education.username: user.username,
                K.Education.password: user.password,
            ]
        case .notification(_, let username, let token):
            return [
                K.Education.username: username,
                K.Education.token: token
            ]
        default:
            return nil
        }
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        
        let url = try K.Education.baseURL.asURL()
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        urlComponents.path = path
        urlComponents.queryItems = queryItemParams
        
        var urlRequest = URLRequest(url: urlComponents.url!)
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
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
