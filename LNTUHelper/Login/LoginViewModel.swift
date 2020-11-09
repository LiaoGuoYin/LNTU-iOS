//
//  LoginViewModel.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/27.
//

import Foundation

class LoginViewModel: ObservableObject {
    
    @Published var user: User
    @Published var isShowBanner: Bool = false
    @Published var banner: BannerModifier.Data = BannerModifier.Data(content: "") {
        willSet {
            self.isShowBanner = true
        }
    }
    
    @Published var isLogin: Bool = false
    // MARK: - TODO
    @Published var userInfo: EducationInfoResponseData {
        didSet {
            if let actualInfoData = try? JSONEncoder().encode(userInfo) {
                UserDefaults.standard.setValue(actualInfoData, forKey: "info")
            }
        }
    }
    @Published var helperMessage: HelperMessageResponseData
    
    init(user: User) {
        self.user = user
        self.helperMessage = HelperMessageResponseData()
        self.userInfo = demoUserInfoResponse
        self.refreshHelperMessage()
    }
    
}

extension LoginViewModel {
    func login(completion: @escaping (Bool) -> ()) {
        APIClient.info(user: self.user) { (result) in
            switch result {
            case .failure(let error):
                self.banner.type = .Error
                self.banner.title = "登录获取信息失败"
                self.banner.content = error.localizedDescription
                completion(false)
            case .success(let response):
                self.banner.content = response.message
                if response.code == 200 {
                    self.banner.type = .Success
                    self.banner.title = "登录获取信息成功"
                    if let actualUserInfoData = response.data {
                        self.userInfo = actualUserInfoData
                    }
                    completion(true)
                } else {
                    self.banner.type = .Error
                    self.banner.title = "登录获取信息失败"
                    completion(false)
                }
            }
        }
    }
}

extension LoginViewModel {
    func refreshHelperMessage() {
        APIClient.helperMessage { (result) in
            switch result {
            case .failure(let error):
                self.banner.type = .Error
                self.banner.title = "初始化数据拉取失败"
                self.banner.content = error.localizedDescription
            case .success(let response):
                self.banner.content = response.message
                if response.code == 200 {
                    self.banner.type = .Success
                    self.banner.title = "初始化数据拉取成功"
                    self.helperMessage = response.data
                } else {
                    self.banner.type = .Error
                    self.banner.title = "初始化数据拉取失败"
                }
            }
        }
    }
}
