//
//  CourseTableViewModel.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/26.
//

import Foundation

class CourseTableViewModel: ObservableObject {
    
    @Published var isShowBanner: Bool = false
    @Published var banner: BannerModifier.Data = BannerModifier.Data(content: "") {
        willSet {
            self.isShowBanner = true
        }
    }
    
    @Published var user: User
    @Published var martrix = CourseTableMatrix(courseTableCellList: [])
    @Published private var courseTableResponseList: [CourseTableResponseData] {
        willSet {
            courseTableCellList.append(contentsOf: newValue.flatMap({ $0.exportToCellList() }))
        }
    }
    @Published var courseTableCellList: [CourseTableCell] = [] {
        willSet {
            martrix = CourseTableMatrix(courseTableCellList: newValue)
        }
    }
    
    init(user: User) {
        self.user = user
        self.courseTableResponseList = []
        self.refreshCourseTable()
    }
    
}

extension CourseTableViewModel {
    func refreshCourseTable() {
        APIClient.courseTable(user: self.user, semester: "2020-2") { (result) in
            switch result {
            case .failure(let error):
                self.banner.type = .Error
                self.banner.content = "拉取课表失败\(error.localizedDescription)"
            case .success(let courseResponse):
                guard courseResponse.data != nil else {
                    return
                }
                if courseResponse.code == 200 {
                    self.banner.type = .Success
                    self.banner.content = "拉取课表成功: \(courseResponse.message)"
                    self.courseTableResponseList = courseResponse.data!
                } else {
                    self.banner.type = .Error
                    self.banner.content = "拉取课表失败: \(courseResponse.message)"
                }
            }
        }
    }
}
