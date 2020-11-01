//
//  NoticeView.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/29.
//

import SwiftUI

struct NoticeView: View {
    
    @ObservedObject var viewModel: NoticeViewModel
    @State var adminNotice: String = "This is an admin notification"
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    SectionTextAndImage(name: "系统公告", image: "number.square.fill")
                    NoticeCardView(adminNotice: adminNotice)
                        .padding(.vertical)
                }
                
                Section {
                    SectionTextAndImage(name: "教务新闻", image: "tag.fill")
                    ForEach(viewModel.noticeList, id: \.url) { notice in
                        NoticeRowView(notice: notice)
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
    }
    
    var refreshButton: some View {
        Button(action: {
            Haptic.shared.complexSuccess()
            viewModel.refreshNoticeList()
        }) {
            Text("刷新")
        }
    }
}

struct NoticeView_Previews: PreviewProvider {
    static var previews: some View {
        NoticeView(viewModel: NoticeViewModel())
    }
}

