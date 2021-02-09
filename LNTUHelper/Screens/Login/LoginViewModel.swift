//
//  LoginViewModel.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/27.
//

import Foundation

class LoginViewModel: ObservableObject {
    
    @Published var needsTeacherEvaluation: Bool = false
    // Why the initial value of this variable is false:
    // If the checkForEvaluation() method fails to update the value of this variable, it means that something wrong has happened
    // to the server, so that we shouldn't let the user submit the evaluation request to the server. (Because the server is probably down....)
    
    @Published var isShowBanner = false
    @Published var banner = BannerModifier.Data() {
        didSet {
            isShowBanner = true
        }
    }
    
    @Published var userInfo: EducationInfoResponseData
    @Published var helperMessage: HelperMessageResponseData
    @Published var qualityViewModel: QualityActivityViewModel
    
    var teacherEvaluationData: [TeacherEvaluationResponseData] = []

    init() {
        self.helperMessage = MockData.helperMessage
        self.userInfo = MockData.educationInfo
        self.qualityViewModel = QualityActivityViewModel()
        
        if let actualData = UserDefaults.standard.object(forKey: SettingsKey.educationInfoData.rawValue) as? Data {
            self.userInfo = (try? JSONDecoder().decode(EducationInfoResponseData.self, from: actualData)) ?? MockData.educationInfo
        }
    }
}

extension LoginViewModel {
    func login(completion: @escaping (Bool) -> ()) {
        APIClient.info(user: Constants.currentUser) { (result) in
            switch result {
            case .failure(let error):
                self.banner.type = .Error
                self.banner.title = "登录获取个人信息失败"
                self.banner.content = self.banner.title + "，请稍后再试 " + error.localizedDescription
                completion(false)
            case .success(let response):
                self.banner.content = response.message
                guard response.code == 200 else {
                    self.banner.type = .Error
                    self.banner.title = "登录获取个人信息失败"
                    Constants.isLogin = false
                    completion(false)
                    return
                }
                
                self.banner.type = .Success
                self.banner.title = "登录获取信息成功"
                self.userInfo = response.data ?? MockData.educationInfo
                UserDefaults.standard[.educationInfoData] = try? JSONEncoder().encode(self.userInfo)
                Constants.isLogin = true
                completion(true)
            }
        }
    }
    
    func checkForEvaluation(completion: @escaping (Bool) -> Void) {
        APIClient.evaluateTeacher(user: Constants.currentUser, submit: false) { (result) in
            switch result {
            case .failure(_):
                print("Fail to check the evaluation status")
                completion(false)
            case .success(let response):
                if response.code == 200 { // Teacher evaluation is needed
                    self.teacherEvaluationData = response.data.filter { $0.status != .finished }
                } else {
                    self.teacherEvaluationData = response.data.filter { $0.status == .finished }
                }
                self.needsTeacherEvaluation = (response.code == 200)
                completion(true)
            }
        }
    }
    
    func beginEvaluation(completion: @escaping (Bool) -> Void) {
        APIClient.evaluateTeacher(user: Constants.currentUser, submit: true) { (result) in
            switch result {
            case .failure(_):
                completion(false)
                self.banner.title = "评教错误"
                self.banner.content = "尝试评教时发生错误，请确保网络通畅或联系开发者"
                self.banner.type = .Error
            case .success(let response):
                if response.code == 200 {
                    completion(true)
                    self.banner.title = "评教成功"
                    self.banner.content = "评教已完成"
                    self.banner.type = .Success
                } else {
                    completion(false)
                    self.banner.title = "评教错误"
                    self.banner.content = response.message
                    self.banner.type = .Error
                }
            }
        }
    }
}
