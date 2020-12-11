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
        self.helperMessage = HelperMessageResponseData()
        self.userInfo = MockData.educationInfo
    }
}

extension LoginViewModel {
    func login(completion: @escaping (Bool) -> ()) {
        self.banner.type = .Error
        self.banner.title = "登录获取信息失败"
        APIClient.info(user: self.user) { (result) in
            switch result {
            case .failure(let error):
                self.banner.content = error.localizedDescription
                completion(false)
            case .success(let response):
                self.banner.content = response.message
                guard response.code == 200 else {
                    return
                }
                self.banner.type = .Success
                self.banner.title = "登录获取信息成功"
                if let actualUserInfoData = response.data { self.userInfo = actualUserInfoData }
                UserDefaults.standard[.educationInfoData] = try? JSONEncoder().encode(self.userInfo)
                UserDefaults.standard[.educationAccount] = try? JSONEncoder().encode(self.user)
                completion(true)
            }
        }
    }
}
