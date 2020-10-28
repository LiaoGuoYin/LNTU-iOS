//
//  LoginView.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/27.
//

import Foundation
import SwiftUI

struct LoginView: View {
    
    @ObservedObject var viewModel: LoginViewModel
    @EnvironmentObject var router: ViewRouter
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 10) {
                    HStack {
                        Text("学号")
                            .padding()
                            .foregroundColor(.white)
                            .background(Color("navyBlue"))
                            .cornerRadius(8)
                        
                        TextField("1710030215", text: $viewModel.user.username)
                            .keyboardType(.numberPad)
                            .padding()
                            .background(Color(.systemFill))
                            .cornerRadius(8)
                    }
                    HStack {
                        Text("密码")
                            .padding()
                            .foregroundColor(.white)
                            .background(Color("navyBlue"))
                            .cornerRadius(8)
                        SecureField("*", text: $viewModel.user.password)
                            .padding()
                            .background(Color(.systemFill))
                            .cornerRadius(8)
                    }
                }
                .navigationBarTitle(Text("Login"), displayMode: .large)
                loginButton
            }
            .padding()
        }
        .resignKeyboardOnDragGesture()
        .banner(data: $viewModel.banner, isShow: $viewModel.isShowBanner)
    }
    
    var loginButton: some View {
        Button(action: {
            viewModel.login {
                if $0 {
                    router.user = viewModel.user
                    router.isLogin = true
                } else {
                    router.banner = viewModel.banner
                    router.isLogin = false
                }
            }
        }) {
            HStack {
                Spacer()
                Text("登录")
                Spacer()
            }
            .padding()
            .foregroundColor(.white)
            .background(Color("navyBlue"))
            .cornerRadius(8)
        }
    }
    
}

struct LoginView_PreViews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: LoginViewModel(user: User(username: "1710030215", password: "*")))
    }
}
