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
    
    case notification(type: NotificationRequestType, username: String, token: String, subscriptionList: [SubscriptionItem]? = nil)
    case teacherEvaluation(user: User, submit: Bool)
    
    enum NotificationRequestType {
        case register
        case remove
    }
    
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case .classroom, .notice, .initHelperMessage:
            return .get
        case .data, .info, .courseTable, .grade, .examPlan, .otherExam, .qualityActivity, .notification, .teacherEvaluation:
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
        case .notification(let type, _, _, _):
            switch type {
            case .register:
                return "/app/notification-register"
            case .remove:
                return "/app/notification-remove"
            }
        case .teacherEvaluation:
            return "/education/evaluation"
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
    private var parameters: EncodableWrapper? {
        
        let value: Encodable?
        
        switch self {
        case .courseTable(let user, _), .info(let user), .grade(let user), .data(let user), .examPlan(let user, _, _), .otherExam(let user), .qualityActivity(let user):
            
            value = UserCredentialsRequestBody(username: user.username, password: user.password)
            
        case .teacherEvaluation(let user, let submit):
            
            value = TeacherEvaluationRequestBody(user: user, submit: submit)
            
        case .notification(let type, let username, let token, let subscriptionList):
            switch type {
            case .register:
                guard subscriptionList != nil else {
                    fatalError("SubscriptionList for token registeration shouldn't be nil (it should at least be a empty array \"[]\")")
                }
                value = NotificationRegistrationRequestBody(token: token, username: username, subscriptionList: subscriptionList!)
            case .remove:
                value = NotificationRemovalRequestBody(token: token, username: username)
            }
            
        default:
            value = nil
        }
        
        
        if let value = value {
            return EncodableWrapper(wrappedValue: value)
        } else {
            return nil
        }
    }
    
    // MARK: - POST Body Encodable Wrapper
    struct EncodableWrapper: Encodable {
        let wrappedValue: Encodable
        
        func encode(to encoder: Encoder) throws {
            return try self.wrappedValue.encode(to: encoder)
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
                urlRequest.httpBody = try JSONEncoder().encode(parameters)
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        
        return urlRequest
    }
}
