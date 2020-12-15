//
//  GradeAndQualityActivityView.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/12/15.
//

import SwiftUI

struct GradeAndQualityActivityView: View {
    
    @State var viewModel: GradeViewModel
    @State private var isShowQuality: Bool = false
    @State private var qualityViewModel = QualityActivityViewModel()
    
    var body: some View {
        NavigationView {
            if isShowQuality {
                QualityActivityView(viewModel: qualityViewModel)
                    .navigationBarTitle(Text(TabBarItemEnum.qualitActivity.rawValue), displayMode: .large)
//                    .banner(data: $qualityViewModel.banner, isShow: $qualityViewModel.isShowBanner)
            } else {
                GradeView(viewModel: viewModel, tappedCourse: MockData.gradeList.first!)
                    .navigationBarTitle(Text(TabBarItemEnum.grade.rawValue), displayMode: .large)
                    .navigationBarItems(trailing: modeSwitchButton)
            }
        }
    }
    
    var modeSwitchButton: some View {
        Toggle(isOn: $isShowQuality) {
            Text("")
        }
    }
}

struct GradeAndQualityActivityView_Previews: PreviewProvider {
    static var previews: some View {
        GradeAndQualityActivityView(viewModel: GradeViewModel())
    }
}
