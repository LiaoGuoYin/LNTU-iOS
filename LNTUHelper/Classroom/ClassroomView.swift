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
            ScrollView {
                VStack {
                    Stepper(value: $viewModel.form.week, in: 1...22) {
                        Text("第 \(viewModel.form.week) 周")
                    }
                    .padding(6)
                    
                    Picker("校区", selection: $viewModel.form.campus) {
                        ForEach(CampusEnum.allCases) {
                            Text($0.rawValue).tag($0)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    Picker(LocalizedStringKey.init("教学楼"), selection: $viewModel.form.selectedBuilding) {
                        ForEach(viewModel.form.buildingList, id: \.self) { building in
                            Text(building)
                        }
                    }
                    ClassroomDetailView(classroomList: $viewModel.classroomList)
                }
                .padding()
                .navigationBarTitle(Text("自习室查询"), displayMode: .large)
                .navigationBarItems(trailing: queryButton)
            }
        }
        .banner(data: .constant(BannerModifier.Data(title: "Result", content: viewModel.message)), isShow: $viewModel.isShowBanner)
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
