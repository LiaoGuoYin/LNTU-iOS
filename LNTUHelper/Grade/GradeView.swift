//
//  GradeView.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/29.
//

import SwiftUI

struct GradeView: View {
    
    @ObservedObject var viewModel: GradeViewModel
    @State private var isShowDetail = false
    @State private var tappedCourse: GradeResponseDataGrade {
        didSet {
            isShowDetail = true
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack {
                    SemesterPickerView()
                    ForEach(viewModel.gradeList, id: \.code) { course in
                        GradeRowView(course: course)
                            .onTapGesture {
                                self.tappedCourse = course
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
        .sheet(isPresented: $isShowDetail) {
            GradeRowDetailView(course: tappedCourse)
        }
        .banner(data: $viewModel.banner, isShow: $viewModel.isShowBanner)
    }
    
    var refreshButton: some View {
        Button(action: {
            Haptic.shared.complexSuccess()
            viewModel.refreshGradeList(semester: "2020-1")
        }) {
            Text("刷新")
                .foregroundColor(Color("primary"))
        }
    }
}

extension GradeView {
    init(viewModel: GradeViewModel) {
        let tappedCourse = viewModel.gradeList.first ?? GradeResponseDataGrade()
        self.init(viewModel: viewModel, tappedCourse: tappedCourse)
    }
}
struct GradeView_Previews: PreviewProvider {
    static var previews: some View {
        GradeView(viewModel: GradeViewModel(user: User(username: "", password: "")))
    }
}
