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
    
    @Published var gradeList: [GradeResponseData] = [] {
        didSet {
            self.transformGradeListForViewIfNeeded()
        }
    }
    
    @Published var semesterStyle: SemesterStyle {
        didSet {
            UserDefaults.standard[.semesterStyle] = semesterStyle.rawValue
            if let actualData = UserDefaults.standard.object(forKey: SettingsKey.gradeData.rawValue) as? Data {
                self.gradeList = (try? JSONDecoder().decode([GradeResponseData].self, from: actualData)) ?? []
            }
        }
    }
    
    var groupedGradeDict: [String: [GradeResponseData]] {
        get {
            Dictionary(grouping: gradeList, by: { $0.semester })
        }
        set {}
    }
    
    var groupedGradeDictKeyList: [String] {
        get {
            Array(groupedGradeDict.keys).sorted { (key1, key2) -> Bool in
                if key1.contains("大") && key2.contains("大") {
                    let numberInChinese = ["零","一","二","三","四","五","六","七","八","九","十"]
                    let numberForKey1 = numberInChinese.firstIndex(of: String(key1.prefix(2).last!))!
                    let numberForKey2 = numberInChinese.firstIndex(of: String(key2.prefix(2).last!))!
                    
                    if numberForKey1 != numberForKey2 {
                        return numberForKey1 < numberForKey2
                    } else {
                        return (key1.contains("上") ? true : false)
                    }
                } else {
                    return key1 < key2
                }
            }.reversed()
        }
        set {}
    }
    
    init(gradeList: [GradeResponseData]) {
        self.gradeList = gradeList
        self.semesterStyle = SemesterStyle(rawValue: UserDefaults.standard.string(forKey: SettingsKey.semesterStyle.rawValue) ?? "year") ?? .year
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
                if var responseData = response.data {
                    responseData.sort { (grade1, grade2) -> Bool in
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
                    UserDefaults.standard[.gradeData] = try? JSONEncoder().encode(responseData)
                    self.gradeList = responseData
                } else {
                    self.gradeList = []
                }
                
                completion(true)
            }
        }
    }
    
    func transformGradeListForViewIfNeeded() {
        if self.gradeList != [] &&
            self.semesterStyle == .tier &&
            !self.gradeList[0].semester.contains("大") {
            func resolveTierAndSemesterName(for yearStyleSemester: String) -> String {
                
                guard let yearInteger = Int(yearStyleSemester.prefix(4)),
                      ((yearStyleSemester.contains("春") && !yearStyleSemester.contains("秋")) ||
                        (yearStyleSemester.contains("秋") && !yearStyleSemester.contains("春")))
                else {
                    fatalError("resolveTier(for:): the string passed in as the argument was expected to contain either \"春\" or \"秋\" as well as a year, but actually it's \(yearStyleSemester)")
                }
                
                let initialYear: Int
                
                // Resolve the year when the user enrolled LNTU
                var userInfo: EducationInfoResponseData?
                
                if let actualData = UserDefaults.standard.object(forKey: SettingsKey.educationInfoData.rawValue) as? Data {
                    userInfo = (try? JSONDecoder().decode(EducationInfoResponseData.self, from: actualData))
                }
                
                if let unwrappedUserInfo = userInfo,
                   Int(unwrappedUserInfo.enrollDate.prefix(4)) != nil {
                    initialYear = Int(unwrappedUserInfo.enrollDate.prefix(4))!
                } else if (Int(groupedGradeDictKeyList.last!.prefix(4)) != nil) {
                    initialYear = Int(groupedGradeDictKeyList.last!.prefix(4))!
                } else {
                    fatalError("resolveTierAndSemesterName(for:): Error when trying to get the enrollment year")
                }
                
                let season = yearStyleSemester.contains("春") ? "春" : "秋"
                
                
                let tier: Int
                let semsterName: String
                
                if season == "春" {
                    semsterName = "下"
                    tier = yearInteger - initialYear
                } else {
                    semsterName = "上"
                    tier = yearInteger - initialYear + 1
                }
                
                
                guard tier >= 1 else {
                    fatalError("resolveTier(for:): the year in the argument passed shouldn't be earlier than or the same to the year of the first semester")
                }
                
                let numberInChinese = ["零","一","二","三","四","五","六","七","八","九","十"]
                
                return "大" + numberInChinese[tier] + semsterName
            }
            
            var resultList = self.gradeList
            for index in self.gradeList.indices {
                resultList[index].semester = resolveTierAndSemesterName(for: resultList[index].semester)
            }
            
            self.gradeList = resultList
        }
    }
}
