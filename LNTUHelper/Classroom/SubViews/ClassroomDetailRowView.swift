//
//  ClassroomDetailRowView.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/25.
//

import SwiftUI

struct ClassroomDetailRowView: View {
    @Binding var roomStatusString: String
    var body: some View {
        HStack(spacing: 2) {
            ForEach(roomStatusString.map { String($0) }, id: \.self) { i in
                Image(systemName: (i == "0") ? "square" : "square.fill")
                    .foregroundColor((i == "0") ? Color("primary") : Color(.systemPink))
            }
        }
    }
}

struct ClassroomDetailRowView_Previews: PreviewProvider {
    static var previews: some View {
        ClassroomDetailRowView(roomStatusString: .constant("10101"))
    }
}
