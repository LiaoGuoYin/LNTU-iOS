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
    
    @Published var user: User
    @Published var userInfo: EducationInfoResponseData
    @Published var helperMessage: HelperMessageResponseData
    
    init(user: User) {
        self.user = user
        self.helperMessage = MockData.helperMessage
        self.userInfo = MockData.educationInfo
        
        
        if let actualData = UserDefaults.standard.object(forKey: SettingsKey.educationInfoData.rawValue) as? Data {
            self.userInfo = (try? JSONDecoder().decode(EducationInfoResponse.self, from: actualData))?.data ?? MockData.educationInfo
        }
    }
}

extension LoginViewModel {
    func login(completion: @escaping (Bool) -> ()) {
        UserDefaults.standard[.educationUsername] = self.user.username
        UserDefaults.standard[.educationPassword] = self.user.username
        APIClient.info(user: self.user) { (result) in
            switch result {
            case .failure(let error):
                self.banner.type = .Error
                self.banner.title = "登录获取个人信息失败"
                self.banner.content = self.banner.title + "，请稍后再试 " + error.localizedDescription
                completion(false)
            case .success(let response):
                self.banner.type = .Success
                self.banner.content = response.message
                guard response.code == 200 else {
                    self.banner.type = .Error
                    return
                }
                
                self.banner.title = "登录获取信息成功"
                self.userInfo = response.data ?? MockData.educationInfo
                UserDefaults.standard[.educationInfoData] = try? JSONEncoder().encode(self.userInfo)
                UserDefaults.standard[.educationUsername] = self.user.username
                UserDefaults.standard[.educationPassword] = self.user.username
                completion(true)
            }
        }
    }
}
