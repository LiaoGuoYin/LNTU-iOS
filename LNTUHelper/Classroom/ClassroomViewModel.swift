//
//  ClassroomViewModel.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/25.
//

import Foundation

class ClassroomViewModel: ObservableObject {
    
    @Published var isShowBanner: Bool = false
    @Published var banner: BannerModifier.Data = BannerModifier.Data(content: "") {
        willSet {
            isShowBanner = true
        }
    }
    
    @Published var form: ClassroomForm
    @Published var classroomList: [ClassroomResponseData] = []
    
    init(form: ClassroomForm) {
        self.form = form
    }
    
    func refreshClassroomList() {
        APIClient.classroom(week: form.week, buildingName: form.selectedBuilding) { (response) in
            switch response {
            case .failure(let error):
                self.banner.content = error.localizedDescription
            case .success(let classroomResponse):
                if classroomResponse.code == 200 {
                    self.banner.type = .Success
                    self.banner.content = "刷新空教室列表成功"
                    self.classroomList = classroomResponse.data
                } else {
                    self.banner.type = .Error
                    self.banner.content = "刷新空教室列表失败: \(classroomResponse.message)"
                }
            }
        }
    }
    
}
