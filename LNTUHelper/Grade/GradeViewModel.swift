//
//  GradeViewModel.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/29.
//

import Foundation

class GradeViewModel: ObservableObject {
    
    @Published var user: User
    @Published var isShowBanner: Bool = false
    @Published var banner: BannerModifier.Data = BannerModifier.Data(content: "") {
        willSet {
            self.isShowBanner = true
        }
    }
    
    @Published var gradeList: [GradeResponseDataGrade]
    @Published var gradePointAverage: GradeResponseDataGPA
    
    init(user: User) {
        self.user = user
        self.gradeList = []
        self.gradePointAverage = GradeResponseDataGPA(semester: "", gradePointAverage: 0.0, weightedAverage: 0.0, gradePointTotal: 0.0, scoreTotal: 0.0, creditTotal: 0, courseCount: 0)
        self.refreshGradeList(semester: "2020-1")
    }
    
}

extension GradeViewModel {
    func refreshGradeList(semester: String) {
        APIClient.grade(user: user) { (result) in
            switch result {
            case .failure(let error):
                self.banner.content = error.localizedDescription
            case .success(let response):
                guard let actualGradeResponseData = response.data else {
                    self.banner.content = response.message
                    return
                }
                self.banner.type = .Success
                self.gradeList = actualGradeResponseData.grade
                self.gradePointAverage = actualGradeResponseData.gpa
                self.banner.content = "拉取成绩成功: \(response.message)"
            }
        }
    }
    
    func loadLocalGrade() {
        
    }
    
    func exportGradeToLocal() {
        
    }
    
}
