//
//  LabelView.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/12/5.
//

import SwiftUI


struct LabelView: View {
    
    var name: String
    var iconName: String
    var iconColor = Color("primary")
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: iconName)
                .foregroundColor(iconColor)
                .frame(width: 20.5, height: 20.5)
            Text(name)
        }
        .padding(.leading, 5)
    }
}


struct LabelView_Previews: PreviewProvider {
    static var previews: some View {
        LabelView(name: "测试标签", iconName: "trash.slash.fill")
    }
}
