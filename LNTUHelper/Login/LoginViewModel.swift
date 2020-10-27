//
//  LoginViewModel.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/27.
//

import Foundation

class LoginViewModel: ObservableObject {
    
    @Published var isShowBanner: Bool = false
    @Published var message: String = "" {
        willSet {
            isShowBanner = true
        }
    }
    
    @Published var user: User
    @Published var userInfo: EducationInfoResponseData?
    @Published var isLogin: Bool = false
    
    init(user: User) {
        self.user = user
    }
    
}

extension LoginViewModel {
    func login(completion: @escaping (Bool) -> ()) {
        APIClient.info(user: self.user) { (result) in
            switch result {
            case .failure(let error):
                self.message = error.localizedDescription
            case .success(let info):
                self.message = info.message
                self.userInfo = info.data
                if info.code == 200 {
                    backupUserToLocal(user: self.user)
                    completion(true)
                } else {
                    completion(false)
                }
            }
        }
    }
}
