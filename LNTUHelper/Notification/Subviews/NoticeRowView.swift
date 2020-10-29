//
//  NoticeRowView.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/29.
//

import SwiftUI

struct NoticeRowView: View {
    @State var notice: NoticeResponseData
    var body: some View {
        VStack(alignment: .leading) {
            Text(notice.title)
                .font(.headline)
                .lineLimit(1)
            NavigationLink(destination: NoticeRowDetailView(notice: notice)) {
                HStack {
                    Text(notice.date)
                        .font(.subheadline)
                    Spacer()
                }
            }
        }
    }
}


struct NoticeRowView_Previews: PreviewProvider {
    static var previews: some View {
        NoticeRowView(notice: NoticeViewModel().noticeList[0])
    }
}
