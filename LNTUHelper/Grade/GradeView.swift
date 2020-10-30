//
//  GradeView.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/29.
//

import SwiftUI

struct GradeView: View {
    
    @ObservedObject var viewModel: GradeViewModel
    @State var isShowDetail = false
    @State var tapedCourseIndex = 0
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack {
                    SemesterPickerView()
                    ForEach(viewModel.gradeList, id: \.code) { course in
                        GradeRowView(course: course)
                            .onTapGesture {
                                isShowDetail.toggle()
                            }
                            .sheet(isPresented: $isShowDetail) {
                                GradeRowDetailView(course: course)
                            }
                    }
                    GradePointAverageView(gpa: $viewModel.gradePointAverage)
                }
                .padding()
            }
            .navigationBarItems(trailing: refreshButton)
            .navigationBarTitle("成绩",displayMode: .large)
            .navigationViewStyle(DefaultNavigationViewStyle())
        }
        .banner(data: $viewModel.banner, isShow: $viewModel.isShowBanner)
    }
    
    var refreshButton: some View {
        Button(action: {
            Haptic.shared.complexSuccess()
            viewModel.refreshGradeList(semester: "2020-1")
        }) {
            Text("刷新")
                .foregroundColor(Color("navyBlue"))
        }
    }
}


struct GradeView_Previews: PreviewProvider {
    static var previews: some View {
        GradeView(viewModel: GradeViewModel())
    }
}
