//
//  NoticeView.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/29.
//

import SwiftUI

struct NoticeView: View {
    
    @ObservedObject var viewModel: NoticeViewModel
    
    @State private var isShowingSafariView = false
    @State private var selectedURL = ""
    @State private var didTap = false
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    SectionLabelView(name: "助手公告", systemName: "text.bubble")
                    HStack(alignment: VerticalAlignment.top){
                        Image("Avatar")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .cornerRadius(30)
                        Text(viewModel.helperMessage.notice)
                            .foregroundColor(Color.gray)
                            .font(.body)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)
                    }
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
            Haptic.shared.tappedHaptic()
            viewModel.refreshNoticeList()
            viewModel.refreshHelperMessage()
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

