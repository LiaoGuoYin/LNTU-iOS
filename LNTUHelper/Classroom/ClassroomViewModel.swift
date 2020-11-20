//
//  ClassroomViewModel.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/25.
//

import Foundation

class ClassroomViewModel: ObservableObject {
    
    @Published var isShowBanner: Bool = false
    @Published var banner: BannerModifier.Data = BannerModifier.Data() {
        didSet {
            isShowBanner = true
        }
    }
    
    @Published var form: ClassroomForm {
        didSet {
            self.refreshClassroomList()
            Haptic.shared.complexSuccess()
        }
    }
    @Published var classroomList: [ClassroomResponseDataRow] = []
    
    init(form: ClassroomForm) {
        self.form = form
        refreshToGetCurrentWeek {
            self.form.week = $0
            self.refreshClassroomList()
        }
    }
    
    func refreshClassroomList() {
        APIClient.classroom(week: form.week, buildingName: form.selectedBuilding) { (response) in
            switch response {
            case .failure(let error):
                self.banner.type = .Error
                self.banner.title = "刷新空教室失败"
                self.banner.content = error.errorDescription ?? "Nil Error"
            case .success(let response):
                self.banner.content = response.message
                if response.code == 200 {
                    self.banner.type = .Success
                    self.banner.title = "刷新空教室成功"
                    self.classroomList = response.data.classroomList
                } else {
                    self.banner.type = .Error
                    self.banner.title = "刷新空教室失败"
                }
            }
        }
    }
    
}
