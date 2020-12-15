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
    @Published var selectedKey: String = MockData.qualityActivityList.first!.type
    
    var groupedQualityActivityDict: [String: [QualityActivityResponseData]] {
        get {
            Dictionary(grouping: qualityActivityList, by: { $0.type })
        }
        set {}
    }
    
    var groupedQualityActivityDictKeyList: [String] {
        get {
            Array(groupedQualityActivityDict.keys).sorted().reversed()
        }
        set {}
    }
    
    init(qualityActivityList: [QualityActivityResponseData]) {
        self.user = MockData.user
        if let username = UserDefaults.standard.string(forKey: SettingsKey.qualityUsername.rawValue),
           let password = UserDefaults.standard.string(forKey: SettingsKey.qualityPassword.rawValue) {
            self.user = User(username: username, password: password)
        }
        self.qualityActivityList = qualityActivityList
    }
    
    convenience init() {
        self.init(qualityActivityList: MockData.qualityActivityList)
        self.qualityActivityList = []
        if let data = UserDefaults.standard.object(forKey: SettingsKey.qualityActivityData.rawValue) as? Data {
            self.qualityActivityList = (try? JSONDecoder().decode([QualityActivityResponseData].self, from: data)) ?? []
        }
        self.refreshToGetActivityList()
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
                UserDefaults.standard[.qualityActivityData] = try? JSONEncoder().encode(self.qualityActivityList)
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
