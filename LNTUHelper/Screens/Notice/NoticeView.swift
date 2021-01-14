//
//  NoticeView.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/29.
//

import SwiftUI

struct NoticeView: View {
    
    @ObservedObject var router = ViewRouter.router
    @ObservedObject var viewModel: NoticeViewModel
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    SectionLabelView(name: "助手公告", systemName: "text.bubble")
                    Text(viewModel.helperMessage.notice)
                        .foregroundColor(Color.secondary)
                        .font(.subheadline)
                        .multilineTextAlignment(.leading)
                        .padding(.vertical)
                }
                Section {
                    SectionLabelView(name: "教务新闻", systemName: "text.bubble.fill")
                    ForEach(viewModel.noticeList, id: \.url) { notice in
                        NoticeRowView(notice: notice)
                            .padding(.vertical, 10)
                    }
                }
            }
            .navigationBarTitle(Text(TabBarItemEnum.notice.rawValue), displayMode: .large)
        }
        .onAppear(perform: {
            Haptic.shared.tappedHaptic()
            viewModel.refreshNoticeList()
            viewModel.refreshHelperMessage()
        })
    }
    
    var refreshButton: some View {
        Button(action: {
            Haptic.shared.tappedHaptic()
            viewModel.refreshNoticeList()
            viewModel.refreshHelperMessage()
            router.banner = viewModel.banner
        }) {
            Text("刷新")
        }
    }
}

struct NoticeView_Previews: PreviewProvider {
    static var previews: some View {
        NoticeView(viewModel: NoticeViewModel(noticeList: MockData.noticeList))
    }
}

