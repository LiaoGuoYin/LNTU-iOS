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
    @EnvironmentObject var router: ViewRouter
    
    var body: some View {
        NavigationView {
            if isShowQuality {
                QualityActivityView(viewModel: qualityViewModel)
                    .navigationBarTitle(Text(TabBarItemEnum.qualitActivity.rawValue), displayMode: .large)
            } else {
                GradeView(viewModel: viewModel, tappedCourse: MockData.gradeList.first!)
                    .navigationBarTitle(Text(TabBarItemEnum.grade.rawValue), displayMode: .large)
                    .navigationBarItems(trailing: modeSwitchButton)
                    .onAppear(perform: {
                        Haptic.shared.tappedHaptic()
//                        viewModel.refreshGradeList(completion: {
//                            router.isShowingLoginView = true
//                        })
                    })
            }
        }
        .onAppear { Haptic.shared.tappedHaptic() }
    }
    
    var modeSwitchButton: some View {
        Toggle(isOn: $isShowQuality) {
            Text("素拓模式")
        }
    }
}

struct GradeAndQualityActivityView_Previews: PreviewProvider {
    static var previews: some View {
        GradeAndQualityActivityView(viewModel: GradeViewModel())
            .environmentObject(ViewRouter(user: MockData.user))
    }
}
