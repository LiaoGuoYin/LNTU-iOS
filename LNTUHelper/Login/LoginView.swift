//
//  LoginView.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/27.
//

import Foundation
import SwiftUI

struct LoginView: View {
    
    @ObservedObject var webViewModel: SwiftUIWebViewModel = SwiftUIWebViewModel(privacy: true)
    @EnvironmentObject var router: ViewRouter
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    HStack {
                        Text("学号")
                            .padding()
                            .foregroundColor(.white)
                            .background(Color("primary"))
                            .cornerRadius(8)
                        
                        TextField("请输入学号", text: $router.user.username)
                            .keyboardType(.numberPad)
                            .padding()
                            .background(Color(.systemFill))
                            .cornerRadius(8)
                    }
                    HStack {
                        Text("密码")
                            .padding()
                            .foregroundColor(.white)
                            .background(Color("primary"))
                            .cornerRadius(8)
                        SecureField("请输入身份证后六位", text:  $router.user.password)
                            .padding()
                            .background(Color(.systemFill))
                            .cornerRadius(8)
                    }
                    loginButton
                }
                .padding()
                .navigationBarTitle(Text("Login"), displayMode: .large)
                
                NavigationLink(destination:
                                SwiftUIWebView(viewModel: webViewModel)
                                .navigationBarTitle(Text("用户协议"), displayMode: .inline)) {
                    Text("查看《辽工大助手用户协议》")
                        .font(.caption)
                        .foregroundColor(Color("primary"))
                        .padding()
                }
            }
        }
        .resignKeyboardOnDragGesture()
        .banner(data: $router.banner, isShow:  $router.isShowBanner)
    }
    
    var loginButton: some View {
        Button(action: {
            Haptic.shared.complexSuccess()
            router.refreshEducationData()
        }) {
            HStack {
                Spacer()
                Text("登录")
                Spacer()
            }
            .padding()
            .foregroundColor(.white)
            .background(Color("primary"))
            .cornerRadius(8)
        }
    }
}

struct LoginView_PreViews: PreviewProvider {
    static var previews: some View {
        let user = User(username: "", password: "")
        return LoginView()
            .environmentObject(ViewRouter(user: user, isLogin: true))
    }
}
