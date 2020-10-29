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
    @Published var userInfo: EducationInfoResponseData?
    
    init(user: User) {
        self.user = user
    }
    
}

extension LoginViewModel {
    func login(completion: @escaping (Bool) -> ()) {
        APIClient.info(user: self.user) { (result) in
            switch result {
            case .failure(let error):
                self.banner.type = .Error
                self.banner.content = error.localizedDescription
                completion(false)
            case .success(let response):
                self.banner.type = .Success
                self.banner.content = response.message
                if response.code == 200 {
                    self.userInfo = response.data
                    backupUserToLocal(user: self.user)
                    completion(true)
                } else {
                    completion(false)
                }
            }
        }
    }
}
