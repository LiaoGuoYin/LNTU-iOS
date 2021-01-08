//
//  GradeView.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/29.
//

import SwiftUI

struct GradeView: View {
    
    @ObservedObject var router = ViewRouter.router
    @ObservedObject var viewModel: GradeViewModel
    @State private var selectedKeyIndex: Int = 0
    
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
                                Haptic.shared.tappedHaptic()
                                router.showBlurView {
                                    DetailGradeRowView(course: course)
                                        .onTapGesture {
                                            router.isBlured.toggle()
                                        }
                                }
                            }
                    }
                }
                // SemesterPickerView()
                // GradePointAverageView(gpa: $viewModel.gradePointAverage)
            }
        }
        .navigationBarTitle(Text(TabBarItemEnum.grade.rawValue), displayMode: .large)
    }
}

struct GradeView_Previews: PreviewProvider {
    static var previews: some View {
        GradeView(viewModel: GradeViewModel())
    }
}
