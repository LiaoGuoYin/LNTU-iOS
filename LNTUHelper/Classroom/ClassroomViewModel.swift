//
//  ClassroomViewModel.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/25.
//

import Foundation

class ClassroomViewModel: ObservableObject {
    
    @Published var isShowBanner: Bool = false
    @Published var message: String = "" {
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
                self.message = error.localizedDescription
            case .success(let classroomResponse):
                self.message = classroomResponse.data.description
                self.classroomList = classroomResponse.data
            }
        }
    }
    
}
