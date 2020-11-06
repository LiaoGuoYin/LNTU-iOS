//
//  NoticeView.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/29.
//

import SwiftUI

struct NoticeView: View {
    
    @ObservedObject var viewModel: NoticeViewModel
    @EnvironmentObject var router: ViewRouter
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    SectionTextAndImage(name: "助手公告", image: "number.square.fill")
                    NoticeCardView(message: $router.loginViewModel.helperMessage.notice)
                }
                Section {
                    SectionTextAndImage(name: "教务新闻", image: "tag.fill")
                    ForEach(viewModel.noticeList, id: \.url) { notice in
                        NoticeRowView(notice: notice, webViewModel: SwiftUIWebViewModel(link: notice.url))
                            .padding(.vertical)
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle("News", displayMode: .large)
            .navigationBarItems(trailing: refreshButton)
        }
        .navigationViewStyle(DoubleColumnNavigationViewStyle())
        .accentColor(Color("primary"))
        .banner(data: $viewModel.banner, isShow: $viewModel.isShowBanner)
    }
    
    var refreshButton: some View {
        Button(action: {
            Haptic.shared.complexSuccess()
            router.loginViewModel.refreshHelperMessage()
            viewModel.refreshNoticeList()
        }) {
            Text("刷新")
        }
    }
}

struct NoticeView_Previews: PreviewProvider {
    static var previews: some View {
        NoticeView(viewModel: NoticeViewModel())
            .environmentObject(ViewRouter(user: User(username: "1710030215", password: "")))
    }
}

