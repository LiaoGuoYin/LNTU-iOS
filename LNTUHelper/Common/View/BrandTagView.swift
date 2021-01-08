//
//  BrandTagView.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2021/1/6.
//

import SwiftUI

struct BrandTagView: View {
    var content: String
    var body: some View {
        Text(content)
            .font(.caption)
            .foregroundColor(.white)
            .padding(8)
            .background(Color.secondary.opacity(0.3))
            .cornerRadius(8)
            .lineLimit(1)
    }
}

extension BrandTagView {
    init(_ content: String) {
        self.init(content: content)
    }
}

struct BrandTagView_Previews: PreviewProvider {
    static var previews: some View {
        BrandTagView(content: "测试标签")
    }
}
