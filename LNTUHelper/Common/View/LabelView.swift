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

struct ImageLabelView: View {
    
    var name: String
    var iconImage: Image
    var iconColor = Color("primary")
    
    var body: some View {
        HStack(spacing: 15) {
            iconImage
                .resizable()
                .foregroundColor(iconColor)
                .frame(width: 20.5, height: 20.5)
                .cornerRadius(20)
            Text(name)
        }
        .padding(.leading, 5)
    }
}


struct LabelView_Previews: PreviewProvider {
    static var previews: some View {
        LabelView(name: "个人信息", iconName: "at")
        ImageLabelView(name: "测试", iconImage: Image("LiaoGuoYin"))
    }
}
