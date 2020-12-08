//
//  SettingsView.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/12/8.
//

import SwiftUI

struct SettingsView: View {
    
    @Binding var isOffline: Bool
    
    var body: some View {
        Form {
            Toggle(isOn: $isOffline) {
                LabelView(name: "懒加载模式", iconName: "airplane")
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(isOffline: .constant(true))
    }
}
