//
//  NoticeRowView.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/29.
//

import SwiftUI

struct NoticeRowView: View {
    @State var notice: NoticeResponseData
    @ObservedObject var webViewModel: SwiftUIWebViewModel
    var body: some View {
        VStack(alignment: .leading) {
            Text(notice.title)
                .font(.headline)
                .lineLimit(1)
            NavigationLink(destination:
                            SwiftUIWebView(viewModel: webViewModel)
                            .navigationBarTitle(Text(notice.title), displayMode: .inline)) {
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
        NoticeRowView(notice: NoticeViewModel().noticeList[0], webViewModel: SwiftUIWebViewModel(link: NoticeViewModel().noticeList[0].url))
    }
}
