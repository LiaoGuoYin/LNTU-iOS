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
                    .onAppear(perform: {
                        qualityViewModel.refreshToGetActivityList()
                    })
            } else {
                GradeView(viewModel: viewModel, tappedCourse: MockData.gradeList.first!)
                    .navigationBarItems(leading: refreshButton, trailing: modeSwitchButton)
            }
        }
        .onAppear(perform: {
            Haptic.shared.tappedHaptic()
            if !Constants.isLogin { router.isShowLoginView = true }
        })
    }
    
    var modeSwitchButton: some View {
        Toggle(isOn: $isShowQuality) {
            Text("素拓模式")
        }
    }
    
    var refreshButton: some View {
        Button(action: {
            Haptic.shared.tappedHaptic()
            self.refresh()
        }) {
            Text("刷新")
                .foregroundColor(Color("primary"))
        }
    }
    
    func refresh() {
        viewModel.refreshGradeList { (isSuccess) in
            router.isShowLoginView = isSuccess ? false : true
            router.banner = viewModel.banner
        }
    }
}

struct GradeAndQualityActivityView_Previews: PreviewProvider {
    static var previews: some View {
        GradeAndQualityActivityView(viewModel: GradeViewModel())
            .environmentObject(ViewRouter())
    }
}
