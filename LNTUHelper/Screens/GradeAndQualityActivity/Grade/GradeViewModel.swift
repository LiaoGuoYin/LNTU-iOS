//
//  GradeViewModel.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/29.
//

import Foundation

class GradeViewModel: ObservableObject {
    
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
        self.gradeList = gradeList
    }
    
    convenience init() {
        self.init(gradeList: MockData.gradeList)
        self.gradeList = []
        if let actualData = UserDefaults.standard.object(forKey: SettingsKey.gradeData.rawValue) as? Data {
            self.gradeList = (try? JSONDecoder().decode([GradeResponseData].self, from: actualData)) ?? []
        }
        //        self.refreshGradeList(completion: {_ in
        //            // self.selectedSemester = self.gradeResultKeyList.first ?? "2020-春"
        //        })
    }
}

extension GradeViewModel {
    func refreshGradeList(completion: @escaping (Bool) -> ()) {
        APIClient.grade(user: Constants.currentUser) { (result) in
            switch result {
            case .failure(let error):
                debugPrint(result)
                self.banner.type = .Error
                self.banner.title = "刷新成绩、绩点失败"
                self.banner.content = self.banner.title + "，请稍后再试 " + error.localizedDescription
                completion(false)
            case .success(let response):
                self.banner.content = response.message
                guard response.code == 200 else {
                    self.banner.type = .Error
                    self.banner.title = "刷新成绩、绩点失败"
                    completion(false)
                    return
                }
                
                self.banner.type = .Success
                self.banner.title = "刷新成绩、绩点成功"
                self.gradeList = response.data ?? []
                self.gradeList.sort { (grade1, grade2) -> Bool in
                    if let gradeNumber1 = Double(grade1.result) {
                        if let gradeNumber2 = Double(grade2.result) {
                            return gradeNumber1 > gradeNumber2
                        } else {
                            return true
                        }
                    } else {
                        return false
                    }
                }
                UserDefaults.standard[.gradeData] = try? JSONEncoder().encode(self.gradeList)
                completion(true)
            }
        }
    }
}
