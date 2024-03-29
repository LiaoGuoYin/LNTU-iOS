//
//  SettingsView.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/12/8.
//

import SwiftUI

struct SettingsView: View {
    
    @ObservedObject var router = ViewRouter.router
    @ObservedObject var gradeViewModel = ViewRouter.router.gradeViewModel
    
    @State private var isShowingSheet = false
    @State private var isShowingAlert = false
    @State private var tappedUrlString = "" {
        didSet {
            isShowingSheet = true
        }
    }
    @State var isRated = false
    @State var needsEvaluation = false
    
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
            
//            Section(header: Text(notificationSectionTitle)) {
//                List {
//                    ForEach(SubscriptionItem.allCases, id: \.self) { item in
//                        MultiSelectionView(value: item, subscribedItems: (!router.isLogin ? .constant(Set()) : $router.subscribedItems), title: SubscriptionItem.description[item]!)
//                    }
//                }
//            }
            
            Section(header: Text("学期展示方式"), footer: Text("年份：以例如\"2020-秋\"的方式展示学期\n年级：以例如\"大三上\"的方式展示学期")) {
                
                Button(action: {
                    Haptic.shared.tappedHaptic()
                    gradeViewModel.semesterStyle = .year
                }, label: {
                    HStack {
                        Text("年份")
                        
                        if gradeViewModel.semesterStyle == .year {
                            Spacer()
                            Image(systemName: "checkmark.seal.fill")
                                .foregroundColor(Color("primary"))
                        }
                    }
                })
                
                Button(action: {
                    Haptic.shared.tappedHaptic()
                    router.gradeViewModel.semesterStyle = .tier
                }, label: {
                    HStack {
                        Text("年级")
                        
                        if router.gradeViewModel.semesterStyle == .tier {
                            Spacer()
                            Image(systemName: "checkmark.seal.fill")
                                .foregroundColor(Color("primary"))
                        }
                    }
                })
                
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
            //            if let notificationToken = Constants.notificationToken {
            //                APIClient.removeNotificationToken(token: notificationToken, username: Constants.currentUser.username) { (result) in
            //                    switch result {
            //                    case.failure(let error):
            //                        print("Nofication Registration To Server Error: " + error.localizedDescription)
            //                    case .success(let response):
            //                        if response.code != 200 {
            //                            print("Notification Remove From Server Responded with Code " + String(response.code) + ":" + response.message)
            //                        } else {
            //                            print("The Notification token was successfully removed from the server")
            //                        }
            //                    }
            //                }
            //            }
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

//struct MultiSelectionView: View {
//
//    var router = ViewRouter.router
//
//    var value: String
//
//    @Binding var subscribedItems: Set<String>
//
//    var isSelected: Bool {
//        subscribedItems.contains(value)
//    }
//
//    var title: String
//
//    var body: some View {
//        Button(action: {
//            if router.isLogin {
//                if isSelected {
//                    subscribedItems.remove(value)
//                } else {
//                    subscribedItems.insert(value)
//                }
//            } else {
//                router.banner.title = "请先登录"
//                router.banner.content = "请先点击下方按钮登录后再进行订阅管理"
//                router.banner.type = .Error
//            }
//        }) {
//            HStack {
//                Text(title)
//                Spacer()
//                if isSelected {
//                    Image(systemName: "checkmark.seal.fill")
//                        .foregroundColor(Color("primary"))
//                }
//            }
//        }
//    }
//}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
