//
//  NoticeCardView.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/29.
//

import SwiftUI

struct NoticeCardView: View {
    @Binding var message: String
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image("Avatar")
                    .resizable()
                    .frame(width: 28, height: 28)
                    .clipShape(Circle())
                
                Text("管理员")
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                Text(message)
                    .font(.subheadline)
                    .bold()
                    .lineLimit(10)
                    .padding(.vertical)
                    .multilineTextAlignment(.leading)
            }
        }
    }
}


struct NoticeCardView_Previews: PreviewProvider {
    static var previews: some View {
        NoticeCardView(message: .constant("This is an admin notification"))
    }
}
