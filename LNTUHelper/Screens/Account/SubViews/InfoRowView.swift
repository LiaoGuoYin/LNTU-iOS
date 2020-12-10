//
//  InfoRowView.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/12/5.
//

import SwiftUI

struct InfoRowView: View {
    @State var key: String
    @State var value: String
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                Text(key)
                    .font(.headline)
                    .fontWeight(.bold)
                Text(value)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .padding(.trailing)
    }
}

struct InfoRowView_Previews: PreviewProvider {
    static var previews: some View {
        InfoRowView(key: "姓名", value: "CoinLiao")
    }
}
