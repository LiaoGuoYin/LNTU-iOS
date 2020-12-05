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
                    NavigationLink(destination: EducationInfoView(user: viewModel.userInfo),
                                   label: { LabelView(name: "个人信息", iconName: "eyes", iconColor: Color.red) })
                } else {
                    Text("还没有登录噢")
                }
                
                NavigationLink(destination: LibraryCardView(),
                               label: { LabelView(name: "图书馆", iconName: "barcode.viewfinder", iconColor: Color.blue) })
                
                NavigationLink(destination: TodoView(),
                               label: { LabelView(name: "素拓网", iconName: "graduationcap", iconColor: Color.orange) })
                
                NavigationLink(destination: TodoView(),
                               label: { LabelView(name: "更新日志", iconName: "deskclock", iconColor: Color.green) })
                
                NavigationLink(destination: TodoView(),
                               label: { LabelView(name: "关于", iconName: "rectangle.on.rectangle", iconColor: Color("primary")) })
                
            }
            .navigationBarItems(trailing: logoutButton)
            .navigationBarTitle(Text("用户中心"), displayMode: .large)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .accentColor(Color("primary"))
        .accentColor(.blue)
    }
    
    var logoutButton: some View {
        Button(action: {
            Haptic.shared.simpleSuccess()
            router.isLogin = false
        }) {
            Text("退出")
                .padding(.vertical)
                .padding(.leading)
        }
    }
}

struct UserCenterView_Previews: PreviewProvider {
    static var previews: some View {
        return UserCenterView(viewModel: LoginViewModel(user: MockData.user))
            .environmentObject(ViewRouter(user: MockData.user, isLogin: true))
    }
}
