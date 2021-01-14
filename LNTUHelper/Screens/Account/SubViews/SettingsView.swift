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
    @State private var tappedUrlString = "" {
        didSet {
            isShowingSheet = true
        }
    }
    var notificationSectionTitle: String {
        !router.isLogin ? "通知推送管理（请先登录）" : "通知推送管理"
    }
    
    var body: some View {
        Form {
            Section(header: Text("实验功能")) {
                Toggle(isOn: $router.isOffline) {
                    LabelView(name: "懒加载模式", iconName: "airplane")
                }
            }
            
            Section(header: Text(notificationSectionTitle)) {
                List {
                    ForEach(SubscriptionItem.allCases, id: \.self) { item in
                        MultiSelectionView(value: item.rawValue, subscribedItems: (!router.isLogin ? .constant(Set()) : $router.subscribedItems), title: SubscriptionItem.description[item]!)
                    }
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
            if let notificationToken = Constants.notificationToken {
                APIClient.removeNotificationToken(token: notificationToken, username: Constants.currentUser.username) { (result) in
                    switch result {
                    case.failure(let error):
                        print("Nofication Registration To Server Error: " + error.localizedDescription)
                    case .success(let response):
                        if response.code != 200 {
                            print("Notification Remove From Server Responded with Code " + String(response.code) + ":" + response.message)
                        } else {
                            print("The Notification token was successfully removed from the server")
                        }
                    }
                }
            }
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

struct MultiSelectionView: View {
    
    var router = ViewRouter.router
    
    var value: String
    
    @Binding var subscribedItems: Set<String>
    
    var isSelected: Bool {
        subscribedItems.contains(value)
    }
    
    var title: String
    
    var body: some View {
        HStack {
            Text(title)
            
            Spacer()
            
            if isSelected {
                Image(systemName: "checkmark")
                    .foregroundColor(Color("primary"))
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            if router.isLogin {
                if isSelected {
                    subscribedItems.remove(value)
                } else {
                    subscribedItems.insert(value)
                }
            } else {
                router.banner.title = "请先登录"
                router.banner.content = "请先点击下方按钮登录后再进行订阅管理"
                router.banner.type = .Error
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
