//
//  ClassroomView.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/25.
//

import SwiftUI

struct ClassroomView: View {
    
    @ObservedObject var viewModel: ClassroomViewModel
    var screenWidth: CGFloat = UIScreen.main.bounds.width
    @State var selectedWeekday: Int = getCurrentWeekDay()
    
    var body: some View {
        
        List {
            Text("当前选择: \(viewModel.form.campus.rawValue) \(viewModel.form.selectedBuilding) 第 \(viewModel.form.week) 周")
                .foregroundColor(Color.secondary)
            
            VStack {
                Picker("校区", selection: $viewModel.form.campus) {
                    ForEach(CampusEnum.allCases) {
                        Text($0.rawValue).tag($0)
                    }
                }
                Picker("教学楼", selection: $viewModel.form.selectedBuilding) {
                    ForEach(viewModel.form.buildingList, id: \.self) { building in
                        Text(building)
                    }
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            
            VStack {
                WeekSelectorView(title: .constant("第 \(viewModel.form.week) 周"), selectedWeek: $viewModel.form.week)
                WeekSelectorView(title: .constant("星期 \(selectedWeekday)"), selectedWeek: $selectedWeekday, endNumber: 7)
            }
            
            ClassroomDetailView(classroomList: $viewModel.classroomList,
                                selectedWeekday: $selectedWeekday)
                .foregroundColor(Color.secondary)
        }
        .font(.subheadline)
        .foregroundColor(Color("primary"))
//        .banner(data: $viewModel.banner, isShow: $viewModel.isShowBanner)
    }
}

struct ClassroomView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ClassroomViewModel(form: ClassroomForm(week: 16, campus: .hld, selectedBuilding: AllBuildingEnum.yhl.rawValue))
        return ClassroomView(viewModel: viewModel)
    }
}
