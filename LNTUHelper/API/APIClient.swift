//
//  APIClient.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/25.
//

import Alamofire
import Foundation

class APIClient {
    
    @discardableResult
    private static func performRequest<T:Decodable>(route:APIEducationRouter, decoder: JSONDecoder = JSONDecoder(), completion:@escaping (Result<T, AFError>)->Void) -> DataRequest {
        return AF.request(route)
            .responseDecodable (decoder: decoder){ (response: DataResponse<T, AFError>) in
                completion(response.result)
            }
    }
    
    static func classroom(week: Int, buildingName: String, completion: @escaping (Result<ClassroomResponse, AFError>) -> Void) {
        performRequest(route: APIEducationRouter.classroom(week: week, buildingName: buildingName), completion: completion)
    }
    
    static func courseTable(user: User, semester: String, completion: @escaping (Result<CourseTableResponse, AFError>) -> Void) {
        performRequest(route: APIEducationRouter.courseTable(user: user, semester: semester), completion: completion)
    }
    
    static func info(user: User, completion: @escaping (Result<EducationInfoResponse, AFError>) -> Void) {
        performRequest(route: APIEducationRouter.info(user: user), completion: completion)
    }
    
    static func grade(user: User, isIncludingOptionalCourse:String="1", completion: @escaping (Result<GradeResponse, AFError>) -> Void) {
        performRequest(route: APIEducationRouter.grade(user: user, isIncludingOptionalCourse: isIncludingOptionalCourse), completion: completion)
    }
    
    static func notice(completion: @escaping (Result<NoticeResponse, AFError>) -> Void) {
        performRequest(route: APIEducationRouter.notice, completion: completion)
    }
    
    static func educationData(user: User, completion: @escaping (Result<EducationDataResponse, AFError>) -> Void) {
        performRequest(route: APIEducationRouter.data(user: user), completion: completion)
    }
    
    static func helperMessage(completion: @escaping (Result<HelperMessageResponse, AFError>) -> Void) {
        performRequest(route: APIEducationRouter.initHelperMessage, completion: completion)
    }
    
}
