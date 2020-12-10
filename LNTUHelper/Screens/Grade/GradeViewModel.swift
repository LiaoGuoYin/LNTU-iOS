//
//  GradeViewModel.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/29.
//

import Foundation

class GradeViewModel: ObservableObject {
    
    @Published var user: User
    @Published var isShowBanner = false
    @Published var banner = BannerModifier.Data() {
        willSet {
            isShowBanner = true
        }
    }
    
    @Published var gradeList: [GradeResponseData] {
        didSet {
            if let actualGradeListData = try? JSONEncoder().encode(gradeList) {
                UserDefaults.standard.setValue(actualGradeListData, forKey: "grade")
            }
        }
    }
    @Published var selectedSemester: String = MockData.gradeList.first!.semester
    
    var gradeResult: [String: [GradeResponseData]] {
        get {
            Dictionary(grouping: gradeList, by: { $0.semester })
        }
    }
    
    var gradeResultKeyList: [String] {
        get {
            Array(gradeResult.keys).sorted().reversed()
        }
    }
    
    init(user: User) {
        self.user = user
        self.gradeList = []
//        self.refreshGradeList {
//            self.selectedSemester = self.gradeResultKeyList.first ?? "2020-春"
//        }
    }
    
    init() {
        self.user = MockData.user
        self.gradeList = MockData.gradeList
    }
    
}

extension GradeViewModel {
    func refreshGradeList(completion: @escaping () -> ()) {
        APIClient.grade(user: user) { (result) in
            switch result {
            case .failure(let error):
                debugPrint(result)
                self.banner.type = .Error
                self.banner.title = "刷新成绩、绩点失败"
                self.banner.content = error.localizedDescription
            case .success(let response):
                self.banner.content = response.message
                if response.code == 200 {
                    self.banner.type = .Success
                    self.banner.title = "刷新成绩、绩点成功"
                    self.gradeList = response.data
                    completion()
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
