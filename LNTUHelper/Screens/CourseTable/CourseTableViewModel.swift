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
            if let actualCourseTableData = try? JSONEncoder().encode(courseTableResponseList) {
                UserDefaults.standard.setValue(actualCourseTableData, forKey: "course-table")
            }
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
    }
}

extension CourseTableViewModel {
    func refreshCourseTable() {
        APIClient.courseTable(user: self.user, semester: Constants.currentSemester) { (result) in
            switch result {
            case .failure(let error):
                self.banner.type = .Error
                self.banner.title = "拉取课表失败"
                self.banner.content = error.localizedDescription
            case .success(let response):
                self.banner.content = response.message
                if response.code == 200 {
                    self.banner.type = .Success
                    self.banner.title = "拉取课表成功"
                    if let actualCourseTableResponse = response.data {
                        self.courseTableResponseList = actualCourseTableResponse
                    }
                } else {
                    self.banner.type = .Error
                    self.banner.title = "拉取课表失败"
                }
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

