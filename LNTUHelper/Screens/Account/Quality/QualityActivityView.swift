//
//  QualityActivityView.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/12/9.
//

import SwiftUI

struct QualityActivityView: View {
    
    @ObservedObject var viewModel: QualityActivityViewModel
    
    var body: some View {
        List(viewModel.qualityActivityList, id: \.name) { activity in
            QualityActivityCardView(qualityActivityResponseData: activity)
        }
        .navigationBarItems(trailing: loginButton)
        .navigationBarTitle(Text("素拓网活动记录"), displayMode: .large)
        .banner(data: $viewModel.banner, isShow: $viewModel.isShowBanner)
        .onAppear(perform: {
            viewModel.refreshToGetActivityList()
        })
    }
    
    var loginButton: some View {
        Button(action: {
            Haptic.shared.tappedHaptic()
            viewModel.alertLoginView()
        }) {
            Image(systemName: "person.crop.square")
                .padding(.leading)
                .padding(.vertical)
        }
    }
}

struct QualityActivityView_Previews: PreviewProvider {
    static var previews: some View {
        QualityActivityView(viewModel: QualityActivityViewModel(user: MockData.user, qualityActivityList: MockData.qualityActivityList))
    }
}
