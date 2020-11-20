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
            VStack {
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
                }
                .pickerStyle(SegmentedPickerStyle())
                .navigationBarTitle(Text("空教室"), displayMode: .large)

                Stepper(value: $viewModel.form.week, in: 1...22) {
                    Text("第 \(viewModel.form.week) 周")
                        .foregroundColor(Color("primary"))
                }
                
                ClassroomDetailView(classroomList: $viewModel.classroomList)
            }
            .font(.subheadline)
            .padding()
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .banner(data: $viewModel.banner, isShow: $viewModel.isShowBanner)
    }
}

struct ClassroomView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ClassroomViewModel(form: ClassroomForm(week: 16, campus: .hld, selectedBuilding: AllBuildingEnum.yhl.rawValue))
        return ClassroomView(viewModel: viewModel)
    }
}
