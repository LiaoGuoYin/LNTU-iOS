//
//  CourseTableViewModel.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/26.
//

import Foundation

class CourseTableViewModel: ObservableObject {
    
    @Published var isShowBanner = false
    @Published var banner = BannerModifier.Data() {
        didSet {
            isShowBanner = true
        }
    }
    
    @Published var user: User
    @Published var martrix: CourseTableMatrix
    @Published var currentWeek: Int {
        didSet {
            self.martrix = flatToMatrix(courseList: courseTableResponseList, currentWeek: currentWeek)
        }
    }
    @Published var courseTableResponseList: [CourseTableResponseData] {
        didSet {
            self.martrix = flatToMatrix(courseList: courseTableResponseList, currentWeek: currentWeek)
        }
    }
    
    var selectedWeekString: String {
        return "第 \(self.currentWeek) 周"
    }
    
    init(user: User) {
        self.user = user
        self.courseTableResponseList = []
        self.currentWeek = 1
        self.martrix = CourseTableMatrix()
        refreshToGetCurrentWeek { self.currentWeek = $0 }
        
        if let actualData = UserDefaults.standard.object(forKey: SettingsKey.courseTableData.rawValue) as? Data {
            self.courseTableResponseList = (try? JSONDecoder().decode([CourseTableResponseData].self, from: actualData)) ?? []
        }
    }
}

extension CourseTableViewModel {
    func refreshCourseTable(completion: @escaping () -> ()) {
        user = UserDefaults.standard.loadLocalUser()
        APIClient.courseTable(user: self.user, semester: Constants.currentSemester) { (result) in
            switch result {
            case .failure(let error):
                self.banner.type = .Error
                self.banner.title = "拉取课表失败"
                self.banner.content = self.banner.title + "，请稍后再试 " + error.localizedDescription
                completion()
            case .success(let response):
                self.banner.type = .Success
                self.banner.content = response.message
                guard response.code == 200 else {
                    self.banner.type = .Error
                    completion()
                    return
                }
                
                self.banner.title = "拉取课表成功"
                self.courseTableResponseList = response.data ?? []
                UserDefaults.standard[.courseTableData] = try? JSONEncoder().encode(self.courseTableResponseList)
            }
        }
    }
}

func flatToMatrix(courseList: [CourseTableResponseData], currentWeek: Int) -> CourseTableMatrix {
    var courseTableMatrix = CourseTableMatrix()
    
    // 按照 scheudles 展平
    courseList.forEach { (course) in
        course.scheduleList.forEach { (schedule) in
            let cell = CourseTableMatrixCell(code: course.code, name: course.name, teacher: course.teacher, credit: course.credit, room: schedule.room, weekday: schedule.weekday, index: schedule.index, weeksString: schedule.weeksString, weeks: schedule.weeks)
            if schedule.weeks.contains(currentWeek) {
                courseTableMatrix[schedule.weekday, schedule.index, at: 0] = [cell]
            }
        }
    }
    
    return courseTableMatrix
}

