//
//  NoticeCardView.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/29.
//

import SwiftUI

struct NoticeCardView: View {
    @State var adminNotice: String
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image("Avatar")
                    .resizable()
                    .frame(width: 32, height: 32)
                    .clipShape(Circle())
                
                Text("Administration")
                    .font(.headline)
                    .foregroundColor(.secondary)
                Spacer()
            }
            Text(adminNotice)
                .lineLimit(4)
                .padding(.vertical)
        }
    }
}


struct NoticeCardView_Previews: PreviewProvider {
    static var previews: some View {
        NoticeCardView(adminNotice: "This is an admin notification")
    }
}
