//
//  SectionTextAndImage.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/29.
//

import SwiftUI

struct SectionTextAndImage: View {
    var name: String
    var image: String
    var body: some View {
        HStack {
            Image(systemName: image)
            Text(name)
        }
        .font(.system(.headline, design: .monospaced))
        .foregroundColor(Color(.systemPink))
    }
}


struct CommonViews_Previews: PreviewProvider {
    static var previews: some View {
        SectionTextAndImage(name: "DEMO", image: "number.square.fill")
    }
}
