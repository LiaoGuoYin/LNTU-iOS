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
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(Array(viewModel.gradeResultKeyList), id: \.self) { key in
                        Text(key)
                            .foregroundColor(.white)
                            .padding(12)
                            .background(viewModel.selectedSemester == key ? Color("primary") : Color("primary").opacity(0.3))
                            .cornerRadius(6)
                            .onTapGesture {
                                Haptic.shared.tappedHaptic()
                                viewModel.selectedSemester = key
                            }
                    }
                }
            }
            .padding(.horizontal)
            
            List {
                ForEach(Array(arrayLiteral: viewModel.gradeResult[viewModel.selectedSemester] ?? []), id: \.self) { courses in
                    ForEach(courses, id: \.code) { course in
                        GradeRowView(course: course)
                            .onTapGesture {
                                self.tappedCourse = course
                            }
                    }
                }
                // SemesterPickerView()
                // GradePointAverageView(gpa: $viewModel.gradePointAverage)
            }
        }
        .banner(data: $viewModel.banner, isShow: $viewModel.isShowBanner)
//        .navigationBarItems(trailing: refreshButton)
        .sheet(isPresented: $isShowDetail) {
            GradeRowDetailView(course: $tappedCourse)
        }
        .accentColor(Color("primary"))
        .onAppear(perform: {
            Haptic.shared.tappedHaptic()
            viewModel.refreshGradeList(completion: {})
        })
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
        NavigationView {
            GradeView(viewModel: GradeViewModel(), tappedCourse: MockData.gradeList.first!)
                .navigationBarTitle("成绩",displayMode: .large)
        }
    }
}

