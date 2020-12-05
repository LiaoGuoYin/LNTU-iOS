//
//  UserCenterView.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/28.
//

import SwiftUI

struct UserCenterView: View {
    
    @EnvironmentObject var router: ViewRouter
    @ObservedObject var viewModel: LoginViewModel
    
    var body: some View {
        NavigationView {
            List {
                if router.isLogin {
                    NavigationLink(
                        destination: UserCenterInfoView(user: viewModel.userInfo),
                        label: {
                            VStack(alignment: .leading, spacing: 16) {
                                Text(viewModel.userInfo.name)
                                Text(viewModel.userInfo.chiefCollege)
                            }
                        }
                    )
                } else {
                    Text("还没有登录噢")
                }
                
                NavigationLink(
                    destination: LibraryCardView(),
                    label: {
                        Text("图书馆卡")
                    }
                )
                
                if #available(iOS 14.0, *) {
                    Label("admin", systemImage: "doc.text.below.ecg")
                } else {
                    Text("admin")
                }
            }
            .navigationBarItems(trailing: logoutButton)
            .navigationBarTitle(Text("用户中心"), displayMode: .large)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .accentColor(Color("primary"))
    }
    
    var logoutButton: some View {
        Button(action: {
            Haptic.shared.simpleSuccess()
            router.isLogin = false
        }) {
            Text("退出")
                .padding()
        }
    }
}

struct UserCenterView_Previews: PreviewProvider {
    static var previews: some View {
        return UserCenterView(viewModel: LoginViewModel(user: MockData.user))
            .environmentObject(ViewRouter(user: MockData.user, isLogin: true))
    }
}
