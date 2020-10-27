//
//  LoginViewModel.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/27.
//

import Foundation

class LoginViewModel: ObservableObject {
    
    @Published var isLogin: Bool = false
    @Published var user: User
    @Published var userInfo: EducationInfoResponseData?
    
    @Published var isShowBanner: Bool = false
    @Published var banner: BannerModifier.Data = BannerModifier.Data(content: "") {
        willSet {
            self.isShowBanner = true
        }
    }
    
    init(user: User) {
        self.user = user
    }
    
}

extension LoginViewModel {
    func login(completion: @escaping (Bool) -> ()) {
        APIClient.info(user: self.user) { (result) in
            switch result {
            case .failure(let error):
                self.banner.content = error.localizedDescription
            case .success(let info):
                self.banner.content = info.message
                self.userInfo = info.data
                if info.code == 200 {
                    self.banner.type = .Success
                    backupUserToLocal(user: self.user)
                    completion(true)
                } else {
                    self.banner.type = .Error
                    completion(false)
                }
            }
        }
    }
}
