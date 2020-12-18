//
//  GradeView.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/29.
//

import SwiftUI

struct GradeView: View {
    
    @ObservedObject var viewModel: GradeViewModel
    @State private var selectedKeyIndex: Int = 0
    @State private var isShowDetail = false
    @State var tappedCourse: GradeResponseData {
        didSet {
            isShowDetail = true
        }
    }
    
    var body: some View {
        VStack {
            GroupedListKeysHorizontalScrollView(keys: $viewModel.groupedGradeDictKeyList,
                                                selectedIndex: $selectedKeyIndex)
            
            if viewModel.gradeList.isEmpty {
                Text("Oops, 还没有成绩记录噢")
                    .foregroundColor(Color.secondary)
            } else {
                List {
                    ForEach(viewModel.groupedGradeDict[viewModel.groupedGradeDictKeyList[selectedKeyIndex]] ?? [], id: \.self) { course in
                        GradeRowView(course: course)
                            .onTapGesture {
                                tappedCourse = course
                            }
                    }
                }
                // SemesterPickerView()
                // GradePointAverageView(gpa: $viewModel.gradePointAverage)
            }
        }
        .sheet(isPresented: $isShowDetail) {
            GradeRowDetailView(course: $tappedCourse)
        }
    }
    
    var refreshButton: some View {
        Button(action: {
            Haptic.shared.tappedHaptic()
            viewModel.refreshGradeList {
            }
        }) {
            Text("刷新")
                .foregroundColor(Color("primary"))
        }
    }
}

struct GradeView_Previews: PreviewProvider {
    static var previews: some View {
        GradeView(viewModel: GradeViewModel(), tappedCourse: MockData.gradeList.first!)
    }
}

