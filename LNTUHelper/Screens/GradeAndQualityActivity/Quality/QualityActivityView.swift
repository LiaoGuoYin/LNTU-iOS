//
//  QualityActivityView.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/12/9.
//

import SwiftUI

struct QualityActivityView: View {
    
    @State var viewModel: QualityActivityViewModel
    @State private var selectedKeyIndex: Int = 0
    
    var body: some View {
        VStack {
            GroupedListKeysHorizontalScrollView(keys: $viewModel.groupedQualityActivityDictKeyList,
                                                selectedIndex: $selectedKeyIndex)
            
            if viewModel.qualityActivityList.isEmpty {
                Text("Oops, 还没有素拓记录噢")
                    .foregroundColor(Color.secondary)
            } else {
                List {
                    ForEach(viewModel.groupedQualityActivityDict[viewModel.groupedQualityActivityDictKeyList[selectedKeyIndex]] ?? [], id: \.self) { activity in
                        QualityActivityCardView(qualityActivityResponseData: activity)
                    }
                }
            }
        }
        .navigationBarTitle(Text(TabBarItemEnum.qualitActivity.rawValue), displayMode: .large)
        .navigationBarItems(leading: loginQualityButton)
        .onAppear(perform: viewModel.refreshToGetActivityList)
    }
    
    var loginQualityButton: some View {
        Button(action: {
            Haptic.shared.tappedHaptic()
            viewModel.alertLoginView()
        }) {
            Image(systemName: "person.crop.square")
                .padding(.trailing)
                .padding(.vertical)
        }
    }
}

struct QualityActivityView_Previews: PreviewProvider {
    static var previews: some View {
        QualityActivityView(viewModel: QualityActivityViewModel())
    }
}
