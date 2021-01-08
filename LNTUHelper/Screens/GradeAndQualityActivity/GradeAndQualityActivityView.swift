//
//  GradeAndQualityActivityView.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/12/15.
//

import SwiftUI

struct GradeAndQualityActivityView: View {
    
    @State var viewModel: GradeViewModel
    @State private var qualityViewModel = QualityActivityViewModel()
    @ObservedObject var router = ViewRouter.router
    @State private var selectingGradeMode = GradeMode.education
    
    var body: some View {
        NavigationView {
            if selectingGradeMode == GradeMode.education {
                GradeView(viewModel: viewModel)
                    .navigationBarItems(leading: refreshButton, trailing: selectingGradePicker)
                    .onAppear(perform: {
                        Haptic.shared.tappedHaptic()
                        if !Constants.isLogin { router.isShowLoginView = true }
                    })
            } else  {
                QualityActivityView(viewModel: qualityViewModel)
                    .onAppear(perform: {
                        qualityViewModel.refreshToGetActivityList()
                    })
            }
        }
    }
    
    var selectingGradePicker: some View {
        HStack {
            Picker(selection: $selectingGradeMode, label: Text("成绩模式")) {
                ForEach(GradeMode.allCases) {
                    Text($0.rawValue).tag($0)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
        }
    }
    
    var refreshButton: some View {
        Button(action: {
            Haptic.shared.tappedHaptic()
            viewModel.refreshGradeList { (isSuccess) in
                router.isShowLoginView = isSuccess ? false : true
                router.banner = viewModel.banner
            }
        }) {
            Text("刷新")
                .foregroundColor(Color("primary"))
        }
    }
}

enum GradeMode: String, CaseIterable, Identifiable {
    case quality = "素拓记录"
    case education = "教务成绩"
    
    var id: String {
        return self.rawValue
    }
}

struct GradeAndQualityActivityView_Previews: PreviewProvider {
    static var previews: some View {
        GradeAndQualityActivityView(viewModel: GradeViewModel())
    }
}
