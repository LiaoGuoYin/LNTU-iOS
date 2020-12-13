//
//  QualityActivityViewModel.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/12/9.
//

import UIKit

final class QualityActivityViewModel: ObservableObject {
    
    @Published var user: User
    @Published var isShowBanner = false
    @Published var banner = BannerModifier.Data() {
        willSet {
            isShowBanner = true
        }
    }
    
    @Published var qualityActivityList: [QualityActivityResponseData]
    var groupedQualityActivityList: [String: [QualityActivityResponseData]] {
        get {
            Dictionary(grouping: qualityActivityList, by: { $0.type })
        }
    }
    
    init(user: User, qualityActivityList: [QualityActivityResponseData]) {
        self.user = user
        self.qualityActivityList = qualityActivityList
    }
    
    init() {
        self.user = MockData.user
        if let usernameForQuality = UserDefaults.standard.value(forKey: "usernameForQuality") as? String,
           let passwordForQuality =  UserDefaults.standard.value(forKey: "passwordForQuality") as? String {
            self.user = User(username: usernameForQuality, password: passwordForQuality)
        }
        self.qualityActivityList = []
//        refreshToGetActivityList()
    }
}

extension QualityActivityViewModel {
    func refreshToGetActivityList() {
        APIClient.qualityActivity(user: user) { (result) in
            switch result {
            case .failure(let error):
                self.banner.type = .Error
                self.banner.title = "拉取素拓网数据失败"
                self.banner.content = self.banner.title + "，请稍后再试 " + error.localizedDescription
            case .success(let response):
                self.banner.type = .Success
                self.banner.content = response.message
                guard response.code == 200 else {
                    self.banner.type = .Error
                    return
                }
                
                self.qualityActivityList = response.data
                UserDefaults.standard[.qualityUsername] = self.user.username
                UserDefaults.standard[.qualityPassword] = self.user.password
            }
        }
    }
}

extension QualityActivityViewModel {
    func alertLoginView() {
        let alertController = UIAlertController(title: "登录您的素拓网", message: "当前登录账号\(self.user.username)", preferredStyle: .alert)
        
        alertController.addTextField { (addTextField) in
            addTextField.placeholder = "账号"
            addTextField.text = UserDefaults.standard[.qualityUsername]
            addTextField.becomeFirstResponder()
        }
        
        alertController.addTextField { (addTextField) in
            addTextField.placeholder = "密码"
            addTextField.text = UserDefaults.standard[.qualityPassword]
            addTextField.isSecureTextEntry = true
        }
        
        let check = UIAlertAction(title: "取消", style: .destructive) { (_) in
            
        }
        
        let add = UIAlertAction(title: "登录", style: .default) { (_) in
            self.user.username = alertController.textFields?.first?.text ?? "没有输入账号"
            self.user.password = alertController.textFields?[1].text ?? ""
            self.refreshToGetActivityList()
        }
        
        alertController.addAction(check)
        alertController.addAction(add)
        
        UIApplication.shared.windows.first?.rootViewController?.present(alertController, animated: true, completion: {
            
        })
    }
}
