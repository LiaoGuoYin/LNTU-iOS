//
//  SettingsView.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/12/8.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var router: ViewRouter
    @State private var isShowingSheet = false
    @State private var tappedUrlString = "" {
        didSet {
            isShowingSheet = true
        }
    }
    
    var body: some View {
        Form {
            Section(header: Text("实验功能")) {
                Toggle(isOn: $router.isOffline) {
                    LabelView(name: "懒加载模式", iconName: "airplane")
                }
            }
            
            Section(header: Text("关于项目")) {
                if #available(iOS 14.0, *) {
                    ForEach(SettingData.AboutItemList, id: \.urlString) { each in
                        Link(destination: URL(string: each.urlString)!) {
                            LabelView(name: each.name, iconName: each.iconName)
                        }
                    }
                } else {
                    ForEach(SettingData.AboutItemList, id: \.urlString) { each in
                        LabelView(name: each.name, iconName: each.iconName)
                            .onTapGesture {
                                self.tappedUrlString = each.urlString
                            }
                    }
                }
            }
            .foregroundColor(Color("primary"))
            
            Section {
                logoutButton
            }
        }
        .navigationBarTitle(Text("更多"), displayMode: .inline)
        .sheet(isPresented: $isShowingSheet) {
            SafariView(urlString: tappedUrlString)
        }
    }
    var logoutButton: some View {
        Button(action: {
            Haptic.shared.tappedHaptic()
            self.router.isLogin = false
        }) {
            HStack {
                Spacer()
                Text("退出登录")
                    .foregroundColor(Color(.systemPink))
                Spacer()
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(ViewRouter(user: MockData.user))
    }
}
