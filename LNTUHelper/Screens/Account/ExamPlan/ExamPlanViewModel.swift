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
    
    @Published var examPlanList: [ExamPlanResponseData] = []
    
    init(examPlanList: [ExamPlanResponseData]) {
        self.examPlanList = examPlanList
    }
    
    init() {
        if let actualData = UserDefaults.standard.object(forKey: SettingsKey.examPlanData.rawValue) as? Data {
            self.examPlanList = (try? JSONDecoder().decode([ExamPlanResponseData].self, from: actualData)) ?? []
        }
    }
    
    func refreshExamPlanList(completion: @escaping (Bool) -> ()) {
        APIClient.examPlan(user: Constants.currentUser, semester: MockData.semester) { (result) in
            switch result {
            case .failure(let error):
                self.banner.type = .Error
                self.banner.title = "拉取考试安排失败"
                self.banner.content = self.banner.title + "，请稍后再试 " + error.localizedDescription
                completion(false)
            case .success(let response):
                self.banner.content = response.message
                guard response.code == 200 else {
                    self.banner.type = .Error
                    self.banner.title = "拉取考试安排失败"
                    completion(false)
                    return
                }
                
                self.banner.type = .Success
                self.banner.title = "拉取考试安排成功"
                self.examPlanList = response.data ?? []
                self.examPlanList.sort { (course1, course2) -> Bool in
                    course1.secondsIntervalToNow < course2.secondsIntervalToNow
                }
                UserDefaults.standard[.examPlanData] = try? JSONEncoder().encode(self.examPlanList)
                completion(true)
            }
        }
    }
}
