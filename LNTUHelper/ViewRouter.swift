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
    @Published var isLogin: Bool = false
    
    @Published var courseTableViewModel: CourseTableViewModel
    @Published var noticeViewModel: NoticeViewModel
    @Published var classroomViewModel: ClassroomViewModel
    @Published var gradeViewModel: GradeViewModel
    @Published var loginViewModel: LoginViewModel
    
    init(user: User) {
        self.user = user
        self.isLogin = false
        self.courseTableViewModel = CourseTableViewModel(user: user)
        self.noticeViewModel = NoticeViewModel()
        self.classroomViewModel = ClassroomViewModel(form: ClassroomForm(week: 10, campus: .hld))
        self.gradeViewModel = GradeViewModel(user: user)
        self.loginViewModel = LoginViewModel(user: user)
    }
    
    convenience init(user: User, isLogin: Bool) {
        self.init(user: user)
        self.isLogin = false
    }
}
