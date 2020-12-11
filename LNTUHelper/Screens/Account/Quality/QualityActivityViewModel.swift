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
        refreshToGetActivityList()
    }
}

extension QualityActivityViewModel {
    func refreshToGetActivityList() {
        APIClient.qualityActivity(user: user) { (result) in
            switch result {
            case .failure(let error):
                self.banner.content = error.localizedDescription
                self.banner.type = .Error
            case .success(let response):
                self.banner.type = .Error
                self.banner.content = response.message
                guard response.code == 200 else { return }
                self.banner.type = .Success
                self.qualityActivityList = response.data
                UserDefaults.standard.setValue(self.user.username, forKey: "usernameForQuality")
                UserDefaults.standard.setValue(self.user.password, forKey: "passwordForQuality")
            }
        }
    }
}

extension QualityActivityViewModel {
    func alertLoginView() {
        let alertController = UIAlertController(title: "登录您的素拓网", message: "当前登录账号\(self.user.username)", preferredStyle: .alert)
        
        alertController.addTextField { (addTextField) in
            addTextField.placeholder = "账号"
            addTextField.becomeFirstResponder()
        }
        
        alertController.addTextField { (addTextField) in
            addTextField.placeholder = "密码"
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
