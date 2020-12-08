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
        willSet {
            UserDefaults.standard.setValue(newValue, forKey: "is-login")
            if let actualUserData = try? JSONEncoder().encode(user) {
                UserDefaults.standard.setValue(actualUserData, forKey: "user")
            }
        }
    }
    
    @Published var courseTableViewModel: CourseTableViewModel
    @Published var noticeViewModel: NoticeViewModel
    @Published var classroomViewModel: ClassroomViewModel
    @Published var gradeViewModel: GradeViewModel
    @Published var loginViewModel: LoginViewModel
    @Published var isOffline: Bool = false {
        willSet {
            UserDefaults.standard.setValue(newValue, forKey: "isOffline")
            K.isOffline = newValue
        }
    }
    
    init(user: User) {
        self.user = user
        self.noticeViewModel = NoticeViewModel()
        self.classroomViewModel = ClassroomViewModel(form: ClassroomForm(week: 1, campus: .hld))
        self.loginViewModel = LoginViewModel(user: user)
        self.courseTableViewModel = CourseTableViewModel(user: user)
        self.gradeViewModel = GradeViewModel(user: user)
        self.refreshEducationData()
    }
    
    convenience init(user: User, isLogin: Bool, isOffline: Bool) {
        self.init(user: user)
        self.isOffline = isOffline
        self.isLogin = isLogin
    }
}

extension ViewRouter {
    func refreshEducationData() {
        APIClient.educationData(user: self.user) { (result) in
            switch result {
            case .failure(let error):
                self.banner.type = .Error
                self.banner.content = error.localizedDescription
                print(error)
            case .success(let response):
                self.banner.type = .Success
                self.banner.content = response.message
                guard response.code == 200 else {
                    self.banner.type = .Error
                    return
                }
                if let data = response.data {
                    self.loginViewModel.userInfo = data.info
                    self.courseTableViewModel.courseTableResponseList = data.courseTable
                    self.gradeViewModel.gradeList = data.grade
                    self.isLogin = true
                }
            }
        }
    }
}
