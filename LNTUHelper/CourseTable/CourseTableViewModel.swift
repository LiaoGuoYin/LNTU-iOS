//
//  CourseTableViewModel.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/26.
//

import Foundation

class CourseTableViewModel: ObservableObject {
    
    @Published private var courseTableResponseList: [CourseTableResponseData] {
        willSet {
            courseTableCellList.append(contentsOf: newValue.flatMap({ $0.exportToCellList() }))
        }
    }
    @Published var user: User
    @Published var courseTableCellList: [CourseTableCell] = [] {
        willSet {
            martrix = CourseTableMatrix(courseTableCellList: newValue)
        }
    }
    
    @Published var isShowBanner: Bool = false
    @Published var message: BannerModifier.Data {
        willSet {
            isShowBanner = true
        }
    }
    @Published var martrix: CourseTableMatrix = CourseTableMatrix(courseTableCellList: [])
    
    init(user: User) {
        self.user = user
        self.courseTableResponseList = []
        self.message  = BannerModifier.Data(title: "Result", content: "Content")
        self.martrix = CourseTableMatrix(courseTableCellList: courseTableCellList)
    }

    init(courseTableList: [CourseTableResponseData]) {
        self.message  = BannerModifier.Data(title: "Result", content: "Content")
        self.user = User(username: 0, password: "")
        self.courseTableResponseList = courseTableList
        
        var tmpCellList: [CourseTableCell] = []
        tmpCellList.append(contentsOf: courseTableList.flatMap({ $0.exportToCellList()}))
        self.courseTableCellList = tmpCellList
        self.martrix = CourseTableMatrix(courseTableCellList: courseTableCellList)
    }
    
}

extension CourseTableViewModel {
    func refreshCourseTable() {
        APIClient.courseTable(user: self.user, semester: "2020-2") { (result) in
            switch result {
            case .failure(let error):
                self.message.title = "拉取课表失败"
                self.message.content = error.localizedDescription
            case .success(let courseResponse):
                self.courseTableResponseList = courseResponse.data
                self.message.title = "拉取课表成功"
                self.message.content = courseResponse.data.description
            }
        }
    }
}
