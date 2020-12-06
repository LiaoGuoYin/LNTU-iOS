//
//  ExamPlanViewModel.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/11/9.
//

import Foundation

class ExamPlanViewModel: ObservableObject {
    
    @Published var isShowBanner = false
    @Published var banner = BannerModifier.Data() {
        didSet {
            isShowBanner = true
        }
    }
    
    @Published var user: User
    @Published var examPlanList: [ExamPlanResponseData] = []
    
    
    init(user: User, examPlanList: [ExamPlanResponseData]) {
        self.user = user
        self.examPlanList = examPlanList
    }
    
    init(user: User) {
        self.user = user
        self.refreshExamPlanList()
    }
    
    func refreshExamPlanList() {
        APIClient.examPlan(user: user, semester: MockData.semester) { (result) in
            switch result {
            case .failure(let error):
                self.banner.type = .Error
                self.banner.title = "拉取考试安排失败"
                self.banner.content = error.localizedDescription
                print(error)
            case .success(let response):
                self.banner.title = "拉取考试安排成功"
                self.banner.content = response.message
                guard response.code == 200 else { return }
                self.examPlanList = response.data
            }
        }
    }
}
