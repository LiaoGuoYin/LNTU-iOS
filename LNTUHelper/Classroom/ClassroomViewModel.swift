//
//  ClassroomViewModel.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/25.
//

import Foundation

class ClassroomViewModel: ObservableObject {
    
    @Published var message: String = ""
    @Published var isShowBanner: Bool = false

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
                self.isShowBanner.toggle()
            case .success(let classroomResponse):
                self.message = classroomResponse.data.description
                self.classroomList = classroomResponse.data
                self.isShowBanner.toggle()
            }
        }
    }
    
}
