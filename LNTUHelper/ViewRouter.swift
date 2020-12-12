//
//  ViewRouter.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/27.
//

import Foundation

class ViewRouter: ObservableObject {
    
    @Published var isShowBanner = false
    @Published var banner = BannerModifier.Data() {
        didSet {
            isShowBanner = true
        }
    }
    
    @Published var user: User
    @Published var isLogin: Bool = false {
        didSet {
            UserDefaults.standard[.isLogin] = isLogin
        }
    }
    
    @Published var courseTableViewModel: CourseTableViewModel
    @Published var noticeViewModel: NoticeViewModel
    @Published var classroomViewModel: ClassroomViewModel
    @Published var gradeViewModel: GradeViewModel
    @Published var loginViewModel: LoginViewModel
    @Published var isOffline: Bool = false {
        willSet {
            UserDefaults.standard[.isOffline] = newValue
        }
    }
    
    init(user: User) {
        self.user = user
        self.noticeViewModel = NoticeViewModel()
        self.classroomViewModel = ClassroomViewModel(form: ClassroomForm(week: 1, campus: .hld))
        
        self.loginViewModel = LoginViewModel(user: user)
        self.courseTableViewModel = CourseTableViewModel(user: user)
        self.gradeViewModel = GradeViewModel(user: user)
        // self.refreshEducationData()
    }
    
    convenience init(user: User, isLogin: Bool, isOffline: Bool) {
        self.init(user: user)
        self.isOffline = isOffline
        self.isLogin = isLogin
    }
}

extension ViewRouter {
    func refreshEducationData() {
        UserDefaults.standard[.educationUsername] = self.user.username
        UserDefaults.standard[.educationPassword] = self.user.password
        APIClient.educationData(user: self.user) { (result) in
            switch result {
            case .failure(let error):
                self.banner.title = "登录拉取所有数据失败"
                self.banner.type = .Error
                self.banner.content = self.banner.title + "，请稍后再试 " + error.localizedDescription
            case .success(let response):
                self.banner.type = .Success
                self.banner.content = response.message
                guard response.code == 200 else {
                    self.banner.type = .Error
                    return
                }
                
                self.loginViewModel.userInfo = response.data!.info
                self.courseTableViewModel.courseTableResponseList = response.data?.courseTable ?? []
                self.gradeViewModel.gradeList = response.data?.grade ?? []
                UserDefaults.standard[.educationUsername] = self.user.username
                UserDefaults.standard[.educationPassword] = self.user.password
                self.isLogin = true
            }
        }
    }
}
