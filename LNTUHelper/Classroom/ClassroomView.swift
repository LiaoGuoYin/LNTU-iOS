//
//  ClassroomView.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/25.
//

import SwiftUI

struct ClassroomView: View {
    
    @ObservedObject var viewModel: ClassroomViewModel
    @State var selectedWeekday: Int = 0
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack {
                    Picker("校区", selection: $viewModel.form.campus) {
                        ForEach(CampusEnum.allCases) {
                            Text($0.rawValue).tag($0)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    Picker("教学楼", selection: $viewModel.form.selectedBuilding) {
                        ForEach(viewModel.form.buildingList, id: \.self) { building in
                            Text(building)
                        }
                    }
                    
                    Stepper(value: $viewModel.form.week, in: 1...22) {
                        Text("第 \(viewModel.form.week) 周")
                    }
                    ClassroomDetailView(classroomList: $viewModel.classroomList)
                }
                .padding()
            }
            .navigationBarTitle(Text("自习室查询"), displayMode: .large)
            .navigationBarItems(trailing: queryButton)
        }
        .banner(data: $viewModel.banner, isShow: $viewModel.isShowBanner)
        .onAppear(perform: {
            viewModel.refreshClassroomList()
        })
    }
    
    var queryButton: some View {
        Button(action: {
            viewModel.refreshClassroomList()
        }) {
            Text("查询")
        }
    }
    
}

struct ClassroomView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ClassroomViewModel(form: ClassroomForm(week: 10, campus: .hld))
        return ClassroomView(viewModel: viewModel)
    }
}
