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
    
    var gradeResult: [String: [GradeResponseDataGrade]] {
        get {
            Dictionary(grouping: gradeList, by: { $0.semester })
        }
    }
    
    var gradeResultKeyList: [String] {
        get {
            Array(gradeResult.keys).sorted()
        }
    }
    
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
                self.banner.type = .Error
                self.banner.title = "刷新成绩、绩点失败"
                self.banner.content = error.localizedDescription
            case .success(let response):
                self.banner.content = response.message
                if response.code == 200 {
                    self.banner.type = .Success
                    self.banner.title = "刷新成绩、绩点成功"
                    if let actualResponseData = response.data {
                        self.gradeList = actualResponseData.grade
                        self.gradePointAverage = actualResponseData.gpa
                    }
                } else {
                    self.banner.type = .Error
                    self.banner.title = "刷新成绩、绩点失败"
                }
            }
        }
    }
    
    func loadLocalGrade() {
        
    }
    
    func exportGradeToLocal() {
        
    }
    
}
