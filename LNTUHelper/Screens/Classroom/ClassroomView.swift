//
//  ClassroomView.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/25.
//

import SwiftUI

struct ClassroomView: View {
    
    @ObservedObject var router = ViewRouter.router
    @ObservedObject var viewModel: ClassroomViewModel
    @State var selectedWeekday: Int = getCurrentWeekDay()
    var screenWidth: CGFloat = UIScreen.main.bounds.width
    let weekList = ["一", "二", "三", "四", "五", "六", "日"]
    
    var body: some View {
        NavigationView {
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
                    WeekSelectorView(title: .constant("\(viewModel.form.week) 周"),
                                     selectedIndex: $viewModel.form.week,
                                     numberList: (1...22).map {String($0)},
                                     displayMode: .normal
                    )
                    WeekSelectorView(title: .constant("星期\(weekList[selectedWeekday - 1])"),
                                     selectedIndex: $selectedWeekday,
                                     numberList: weekList,
                                     displayMode: .normal
                    )
                }
                
                ClassroomDetailView(classroomList: $viewModel.classroomList,
                                    selectedWeekday: $selectedWeekday)
                    .foregroundColor(Color.secondary)
            }
            .font(.subheadline)
            .navigationBarTitle(Text(TabBarItemEnum.classroom.rawValue), displayMode: .large)
        }
        .banner(data: $viewModel.banner, isShow: $viewModel.isShowBanner)
        .onAppear(perform: {
            Haptic.shared.tappedHaptic()
        })
    }
}

struct ClassroomView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ClassroomViewModel(form: ClassroomForm(week: 16, campus: .hld, selectedBuilding: AllBuildingEnum.yhl.rawValue))
        return ClassroomView(viewModel: viewModel)
    }
}
