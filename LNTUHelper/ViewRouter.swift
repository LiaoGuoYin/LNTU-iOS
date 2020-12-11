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
            UserDefaults.standard[.isLogin] = newValue
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
            case .success(let response):
                self.banner.type = .Success
                self.banner.content = response.message
                guard response.code == 200 else { return }
                if let reponseData = response.data {
                    self.loginViewModel.userInfo = reponseData.info
                    self.courseTableViewModel.courseTableResponseList = reponseData.courseTable
                    self.gradeViewModel.gradeList = reponseData.grade
                    UserDefaults.standard[.educationAccount] = try? JSONEncoder().encode(self.user)
                    self.isLogin = true
                }
            }
        }
    }
}
