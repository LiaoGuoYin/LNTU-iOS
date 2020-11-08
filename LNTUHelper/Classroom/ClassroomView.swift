//
//  ClassroomView.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/25.
//

import SwiftUI

struct ClassroomView: View {
    
    @ObservedObject var viewModel: ClassroomViewModel
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading) {
                    Text("当前选择: \(viewModel.form.campus.rawValue) \(viewModel.form.selectedBuilding) 第 \(viewModel.form.week) 周")
                        .foregroundColor(.gray)
                    
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
                    
                    Stepper(value: $viewModel.form.week, in: 1...22) {
                        Text("第 \(viewModel.form.week) 周")
                            .foregroundColor(Color("primary"))
                    }
                    
                    ClassroomDetailView(classroomList: $viewModel.classroomList)
                }
                .font(.headline)
                .padding()
            }
            .pickerStyle(SegmentedPickerStyle())
            .navigationBarTitle(Text("空教室"), displayMode: .large)
//            .navigationBarItems(trailing: queryButton)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .banner(data: $viewModel.banner, isShow: $viewModel.isShowBanner)
    }
    
    var queryButton: some View {
        Button(action: {
            Haptic.shared.complexSuccess()
            viewModel.refreshClassroomList()
        }) {
            Text("查询")
        }
    }
    
}

struct ClassroomView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ClassroomViewModel(form: ClassroomForm(week: 20, campus: .hld))
        return ClassroomView(viewModel: viewModel)
    }
}
