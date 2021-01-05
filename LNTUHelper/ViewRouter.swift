//
//  ViewRouter.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/27.
//

import Foundation
import SwiftUI

class ViewRouter: ObservableObject {
    
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
    
    @Published var isBlured = false
    var topView: AnyView?
    
    init() {
        self.noticeViewModel = NoticeViewModel()
        self.classroomViewModel = ClassroomViewModel(form: ClassroomForm(week: 1, campus: .hld))
        self.loginViewModel = LoginViewModel()
        self.courseTableViewModel = CourseTableViewModel()
        self.gradeViewModel = GradeViewModel()
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
