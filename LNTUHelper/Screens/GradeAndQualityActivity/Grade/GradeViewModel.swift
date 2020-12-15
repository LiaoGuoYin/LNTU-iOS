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
    
    @Published var gradeList: [GradeResponseData]
    
    var groupedGradeDict: [String: [GradeResponseData]] {
        get {
            Dictionary(grouping: gradeList, by: { $0.semester })
        }
        set {}
    }
    
    var groupedGradeDictKeyList: [String] {
        get {
            Array(groupedGradeDict.keys).sorted().reversed()
        }
        set {}
    }
    
    init(gradeList: [GradeResponseData]) {
        self.user = MockData.user
        if let username = UserDefaults.standard.string(forKey: SettingsKey.educationUsername.rawValue),
           let password =  UserDefaults.standard.string(forKey: SettingsKey.educationPassword.rawValue) {
            self.user = User(username: username, password: password)
        }
        self.gradeList = gradeList
    }
    
    convenience init() {
        self.init(gradeList: MockData.gradeList)
        self.gradeList = []
        if let actualData = UserDefaults.standard.object(forKey: SettingsKey.gradeData.rawValue) as? Data {
            self.gradeList = (try? JSONDecoder().decode([GradeResponseData].self, from: actualData)) ?? []
        }
        self.refreshGradeList(completion: {
            // self.selectedSemester = self.gradeResultKeyList.first ?? "2020-春"
        })
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
                self.banner.content = self.banner.title + "，请稍后再试 " + error.localizedDescription
            case .success(let response):
                self.banner.type = .Success
                self.banner.content = response.message
                guard response.code == 200 else {
                    self.banner.type = .Error
                    return
                }
                
                self.banner.title = "刷新成绩、绩点成功"
                self.banner.type = .Success
                self.gradeList = response.data ?? []
                UserDefaults.standard[.gradeData] = try? JSONEncoder().encode(self.gradeList)
                completion()
            }
        }
    }
    
    func loadLocalGrade() {
        
    }
    
    func exportGradeToLocal() {
        
    }
    
}
