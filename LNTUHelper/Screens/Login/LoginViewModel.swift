//
//  LoginViewModel.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/27.
//

import Foundation

class LoginViewModel: ObservableObject {
    
    @Published var isShowBanner = false
    @Published var banner = BannerModifier.Data() {
        didSet {
            isShowBanner = true
        }
    }
    
    @Published var userInfo: EducationInfoResponseData
    @Published var helperMessage: HelperMessageResponseData
    @Published var qualityViewModel: QualityActivityViewModel

    init() {
        self.helperMessage = MockData.helperMessage
        self.userInfo = MockData.educationInfo
        self.qualityViewModel = QualityActivityViewModel()
        
        if let actualData = UserDefaults.standard.object(forKey: SettingsKey.educationInfoData.rawValue) as? Data {
            self.userInfo = (try? JSONDecoder().decode(EducationInfoResponse.self, from: actualData))?.data ?? MockData.educationInfo
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
}
