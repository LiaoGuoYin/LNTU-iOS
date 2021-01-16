//
//  ViewRouter.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/27.
//

import Foundation
import SwiftUI

class ViewRouter: ObservableObject {
    
    public static var router = ViewRouter(isLogin: UserDefaults.standard[.isLogin] ?? false, isOffline: UserDefaults.standard[.isOffline] ?? false)
    public static var notificationCenter = UNUserNotificationCenter.current()
    
    @Published var isShowBanner = false
    @Published var banner = BannerModifier.Data() {
        didSet {
            isShowBanner = true
        }
    }
    
    @Published var isShowLoginView: Bool = false
    @Published var courseTableViewModel: CourseTableViewModel
    @Published var noticeViewModel: NoticeViewModel
    @Published var classroomViewModel: ClassroomViewModel
    @Published var gradeViewModel: GradeViewModel
    @Published var loginViewModel: LoginViewModel
    @Published var isOffline: Bool = false {
        didSet {
            UserDefaults.standard[.isOffline] = isOffline
        }
    }
    
    @Published var isLogin: Bool = false {
        didSet {
            UserDefaults.standard[.isLogin] = isLogin
        }
    }
    
    @Published var selectedTab: TabBarItemEnum = TabBarItemEnum.init(rawValue: UserDefaults.standard.string(forKey: SettingsKey.lastestSelectedTab.rawValue) ?? TabBarItemEnum.account.rawValue)! {
        // UserDefaults.standard[.lastestSelectedTab] 的来源一定是干净的，即来自 didSet，所以此处用 force unwrap !
        didSet {
            UserDefaults.standard[.lastestSelectedTab] = selectedTab.rawValue
        }
    }
    
    @Published var subscribedItems: Set<String> {
        didSet {
            // Try to ask for authorization
            ViewRouter.notificationCenter.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
                if !granted {
                    DispatchQueue.main.async {
                        ViewRouter.router.banner.title = "无法订阅，请先开启通知权限"
                        ViewRouter.router.banner.content = "请前往设置 > 通知 开启此App的通知权限后再尝试订阅"
                        ViewRouter.router.banner.type = .Error
                        
                        if self.subscribedItems != Set((UserDefaults.standard.array(forKey: SettingsKey.subscribedItems.rawValue) as? [String]) ?? []) {
                            self.subscribedItems = Set((UserDefaults.standard.array(forKey: SettingsKey.subscribedItems.rawValue) as? [String]) ?? [])
                        }
                        
                        return
                    }
                } else {
                    if let assignedToken = Constants.notificationToken, self.isLogin {
                        APIClient.registerNotificationTokenOrUpdateSubscriptionList(token: assignedToken, username: Constants.currentUser.username, subscriptionList: Array(self.subscribedItems)) { (result) in
                            var success = false
                            switch result {
                            case .failure(let error):
                                print("Nofication Registration To Server Error: " + error.localizedDescription)
                            case .success(let response):
                                if response.code != 200 {
                                    print("Notification Registration To Server Responded with Code " + String(response.code) + ":" + response.message)
                                } else {
                                    UserDefaults.standard[.subscribedItems] = Array(self.subscribedItems)
                                    success = true
                                    print("The Notification token was successfully sent to the server")
                                }
                            }
                            
                            if !success {
                                Thread.sleep(forTimeInterval: 30*60)
                                let tmp = self.subscribedItems
                                self.subscribedItems = tmp
                            }
                        }
                    }
                }
            }
        }
    }
    
    @Published var isBlured = false
    var topView: AnyView?
    
    init() {
        self.noticeViewModel = NoticeViewModel()
        self.classroomViewModel = ClassroomViewModel(form: ClassroomForm(week: 1, campus: .hld))
        self.loginViewModel = LoginViewModel()
        self.courseTableViewModel = CourseTableViewModel()
        self.gradeViewModel = GradeViewModel()
        self.subscribedItems = Set((UserDefaults.standard.array(forKey: SettingsKey.subscribedItems.rawValue) as? [String]) ?? [])
    }
    
    func showBlurView<ViewType: View>(@ViewBuilder view: @escaping () -> ViewType) {
        isBlured = true
        topView = AnyView(
            ZStack {
                Rectangle()
                    .background(Color.clear)
                    .foregroundColor(.clear)
                    .contentShape(Rectangle()) // if this is not provided, the onTapGesture won't work
                    .onTapGesture {
                        self.hideBlurView()
                    }
                
                view()
            }
        )
    }
    
    func hideBlurView() {
        isBlured = false
        topView = nil
    }
    
    convenience init(isLogin: Bool, isOffline: Bool) {
        self.init()
        self.isOffline = isOffline
        self.isLogin = isLogin
    }
}

extension ViewRouter {
    func refreshEducationData(completion: @escaping (Bool) -> ()) {
        APIClient.educationData(user: Constants.currentUser) { (result) in
            switch result {
            case .failure(let error):
                self.banner.type = .Error
                self.banner.title = "登录拉取所有数据失败"
                self.banner.content = self.banner.title + "，请稍后再试 " + error.localizedDescription
                completion(false)
            case .success(let response):
                self.banner.content = response.message
                guard response.code == 200 else {
                    self.banner.type = .Error
                    self.banner.title = "登录拉取所有数据失败"
                    Constants.isLogin = false
                    completion(false)
                    return
                }
                
                self.banner.type = .Success
                self.banner.title = "登录拉取所有数据成功"
                self.loginViewModel.userInfo = response.data!.info
                self.courseTableViewModel.courseTableResponseList = response.data?.courseTable ?? []
                self.gradeViewModel.gradeList = response.data?.grade ?? []
                Constants.isLogin = true
                completion(true)
            }
        }
    }
}
