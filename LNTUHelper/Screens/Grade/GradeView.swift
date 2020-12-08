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
    @State var tappedCourse: GradeResponseData {
        didSet {
            isShowDetail = true
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(Array(viewModel.gradeResultKeyList), id: \.self) { key in
                            Text(key)
                                .foregroundColor(.white)
                                .padding()
                                .background(viewModel.selectedSemester == key ? Color("primary") : Color("primary").opacity(0.4))
                                .cornerRadius(6)
                                .onTapGesture {
                                    viewModel.selectedSemester = key
                                }
                        }
                    }
                    .padding(.horizontal)
                }
                if viewModel.gradeResultKeyList.contains(viewModel.selectedSemester) {
                    ForEach(Array(arrayLiteral: viewModel.gradeResult[viewModel.selectedSemester]!), id: \.self) { each in
                        ForEach(each, id: \.code) { course in
                            GradeRowView(course: course)
                                .padding(.horizontal)
                                .padding(.vertical, 2)
                                .onTapGesture {
                                    self.tappedCourse = course
                                }
                        }
                    }
                } else {
                    Text("Oops, 还没有考试成绩噢")
                        .padding()
                }
                // SemesterPickerView()
                // GradePointAverageView(gpa: $viewModel.gradePointAverage)
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarItems(trailing: refreshButton)
            .navigationBarTitle("成绩",displayMode: .large)
            .sheet(isPresented: $isShowDetail) {
                GradeRowDetailView(course: $tappedCourse)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .banner(data: $viewModel.banner, isShow: $viewModel.isShowBanner)
    }
    
    var refreshButton: some View {
        Button(action: {
            Haptic.shared.tappedHaptic()
            viewModel.refreshGradeList {
                viewModel.selectedSemester = viewModel.gradeResultKeyList.first ?? "2020-春"
            }
        }) {
            Text("刷新")
                .foregroundColor(Color("primary"))
        }
    }
}

struct GradeView_Previews: PreviewProvider {
    static var previews: some View {
        return GradeView(viewModel: GradeViewModel(user: MockData.user), tappedCourse: MockData.gradeList.first!)
    }
}

