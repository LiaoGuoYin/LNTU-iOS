//
//  NoticeRowView.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/29.
//

import SwiftUI

struct NoticeRowView: View {
    
    @State var notice: NoticeResponseData
    @State private var isShowingSheet = false
    
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            VStack(alignment: .leading, spacing: 5) {
                Text(notice.title)
                    .font(.headline)
                    .lineLimit(1)
                
                Text(notice.date)
                    .foregroundColor(.gray)
                    .font(.subheadline)
            }
            Spacer()
            Image(systemName: "doc.plaintext")
        }
        .onTapGesture {
            isShowingSheet = true
            Haptic.shared.simpleSuccess()
        }
        .sheet(isPresented: $isShowingSheet) {
            SafariView(urlString: notice.url)
        }
    }
}


struct NoticeRowView_Previews: PreviewProvider {
    static var previews: some View {
        NoticeRowView(notice: MockData.noticeList.randomElement()!)
    }
}
