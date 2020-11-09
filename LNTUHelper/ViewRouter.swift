//
//  ViewRouter.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/27.
//

import Foundation

class ViewRouter: ObservableObject {
    
    @Published var isShowBanner: Bool = false
    @Published var banner: BannerModifier.Data = BannerModifier.Data(content: "登录成功") {
        willSet {
            self.isShowBanner = true
        }
    }
    
    @Published var user: User
    @Published var isLogin: Bool = false {
        didSet {
            UserDefaults.standard.setValue(isLogin, forKey: "is-login")
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
    
    init(user: User) {
        self.user = user
        self.courseTableViewModel = CourseTableViewModel(user: user)
        self.noticeViewModel = NoticeViewModel()
        self.gradeViewModel = GradeViewModel(user: user)
        self.loginViewModel = LoginViewModel(user: user)
        self.classroomViewModel = ClassroomViewModel(form: ClassroomForm(week: 1, campus: .hld))
    }
    
    convenience init(user: User, isLogin: Bool) {
        self.init(user: user)
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
                    self.gradeViewModel.gradePointAverage = data.gpa
                    self.isLogin = true
                }
            }
        }
    }
}
