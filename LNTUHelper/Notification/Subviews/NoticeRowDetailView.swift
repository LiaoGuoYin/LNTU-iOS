//
//  NoticeDetailView.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/29.
//

import SwiftUI

struct NoticeRowDetailView: View {
    @State var notice: NoticeResponseData
    var body: some View {
        ScrollView {
            VStack {
                Text(notice.title)
                    .font(.title)
                Text(notice.date)
                    .font(.headline)
                Text(notice.content)
                HStack() {
                    Text("原文地址：\(notice.url)")
                        .font(.footnote)
                        .foregroundColor(.gray)
                    Spacer()
                }
            }
            .padding()
        }
    }
}

struct NoticeRowDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NoticeRowDetailView(notice: NoticeViewModel().noticeList[0])
    }
}
