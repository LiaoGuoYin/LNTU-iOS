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
    @State private var isShowingSafariView = false
    @State private var selectedURL = ""
    @State private var didTap = false
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    SectionLabelView(name: "助手公告", systemName: "text.bubble")
                    HStack(alignment: VerticalAlignment.top){
                        Image("Avatar")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .cornerRadius(30)
                        Text(viewModel.helperMessage.notice)
                            .foregroundColor(Color.secondary)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)
                    }
                    .padding(.vertical)
                    .contextMenu {
                        Button(action: {
                            UIPasteboard.general.string = viewModel.helperMessage.notice
                        }) {
                            Text("复制到剪贴板")
                            Image(systemName: "doc.on.doc")
                        }
                    }
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

