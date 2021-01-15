//
//  SettingsView.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/12/8.
//

import SwiftUI

struct SettingsView: View {
    
    @ObservedObject var router = ViewRouter.router
    @State private var isShowingSheet = false
    @State private var isShowingAlert = false
    @State private var tappedUrlString = "" {
        didSet {
            isShowingSheet = true
        }
    }
    
    var body: some View {
        Form {
            
            Section(header: Text("实验功能")) {
                Button(action: {
                    Haptic.shared.tappedHaptic()
                    self.isShowingAlert = true
                }) {
                    HStack {
                        Text("离线模式")
                        Spacer()
                        if router.isOffline {
                            Image(systemName: "checkmark.seal.fill")
                                .foregroundColor(Color("primary"))
                        }
                    }
                }
            }
            
            Section(header: Text("关于项目")) {
                if #available(iOS 14.0, *) {
                    ForEach(SettingData.AboutProjectList, id: \.urlString) { each in
                        Link(destination: URL(string: each.urlString)!) {
                            LabelView(name: each.name, iconName: each.iconName)
                        }
                    }
                    .foregroundColor(Color("primary"))
                } else {
                    ForEach(SettingData.AboutProjectList, id: \.urlString) { each in
                        LabelView(name: each.name, iconName: each.iconName)
                            .onTapGesture {
                                self.tappedUrlString = each.urlString
                            }
                    }
                    .foregroundColor(Color("primary"))
                }
            }
            
            Section(header: Text("联系我们")) {
                if #available(iOS 14.0, *) {
                    ForEach(SettingData.ContactUsList, id: \.urlString) { each in
                        Link(destination: URL(string: each.urlString)!) {
                            ImageLabelView(name: each.name, iconImage: Image(each.iconName))
                        }
                    }
                    .foregroundColor(Color("primary"))
                } else {
                    ForEach(SettingData.ContactUsList, id: \.urlString) { each in
                        ImageLabelView(name: each.name, iconImage: Image(each.iconName))
                            .onTapGesture {
                                self.tappedUrlString = each.urlString
                            }
                    }
                    .foregroundColor(Color("primary"))
                }
            }
            
            Section {
                if router.isLogin {
                    logoutButton
                } else {
                    loginButton
                }
            }
            
        }
        .navigationBarTitle(Text("更多"), displayMode: .inline)
        .sheet(isPresented: $isShowingSheet) {
            SafariView(urlString: tappedUrlString)
        }
        .alert(isPresented: $isShowingAlert, content: {
            Alert(title: Text("模式说明"),
                  message: Text("离线模式：教务在线爆炸后仍能查看以往数据\n正常模式：实时从教务在线获取最新数据"),
                  primaryButton: Alert.Button.default(Text("正常模式"), action: {
                    self.router.isOffline = false
                  }),
                  secondaryButton: Alert.Button.default(Text("离线模式"), action: {
                    self.router.isOffline = true
                  }))
        })
    }
    
    var loginButton: some View {
        Button(action: {
            router.isShowLoginView = true
        }) {
            HStack {
                Spacer()
                Text("登录")
                Spacer()
            }
            .foregroundColor(Color("primary"))
        }
    }
    
    var logoutButton: some View {
        Button(action: {
            Haptic.shared.tappedHaptic()
            Constants.currentUser.password = ""
            Constants.isLogin = false
            router.banner.type = .Warning
            router.banner.title = "退出登录成功，已清除用户密码"
            router.banner.content = "Success"
        }) {
            HStack {
                Spacer()
                Text("退出登录")
                Spacer()
            }
            .foregroundColor(Color(.systemPink))
        }
    }
}


struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
