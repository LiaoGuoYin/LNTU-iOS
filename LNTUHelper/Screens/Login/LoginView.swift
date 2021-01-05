//
//  LoginView.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/27.
//

import SwiftUI

struct LoginView: View {
    
    @ObservedObject var router = ViewRouter.router
    @ObservedObject var viewModel: LoginViewModel
    @State private var isShowingSheet = false
    @State var user: User
    
    var body: some View {
        NavigationView {
            List {
                HStack {
                    Text("学号")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color("primary"))
                        .cornerRadius(8)
                    TextField("请输入学号", text: $user.username)
                        .padding()
                        .keyboardType(.numberPad)
                        .background(Color(.systemFill))
                        .cornerRadius(8)
                }
                
                HStack {
                    Text("密码")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color("primary"))
                        .cornerRadius(8)
                    SecureField("请输入身份证(默认密码)", text: $user.password)
                        .padding()
                        .background(Color(.systemFill))
                        .cornerRadius(8)
                }
                
                loginButton
                
                HStack(spacing: 0) {
                    Spacer()
                    Image(systemName: "doc.plaintext")
                    Text("查看《辽工大助手用户协议》")
                        .font(.subheadline)
                        .padding()
                    Spacer()
                }
                .foregroundColor(Color("primary"))
                .onTapGesture {
                    self.isShowingSheet = true
                }
            }
            .navigationBarTitle(Text("Login"), displayMode: .large)
            .navigationBarItems(leading: cancelItemButton, trailing: loginItemButton)
        }
        .banner(data: $router.banner, isShow: $router.isShowBanner)
        .sheet(isPresented: $isShowingSheet) {
            SafariView()
                .navigationBarTitle(Text("用户协议"), displayMode: .inline)
        }
        .onDisappear(perform: {
            router.isShowLoginView = false
        })
    }
    
    var loginButton: some View {
        Button(action: {
            Haptic.shared.tappedHaptic()
            self.login()
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
    
    var cancelItemButton: some View {
        Button(action: {
            Haptic.shared.tappedHaptic()
            router.isShowLoginView = false
        }) {
            Text("取消")
        }
    }
    
    var loginItemButton: some View {
        Button(action: {
            Haptic.shared.tappedHaptic()
            self.login()
        }) {
            Text("登录")
        }
    }
    
    func login() {
        Constants.currentUser = user
        viewModel.login { (isSuccess) in
            router.isShowLoginView = isSuccess ? false : true
            router.banner = viewModel.banner
        }
    }
}

extension LoginView {
    init(viewModel: LoginViewModel) {
        let user = UserDefaults.standard.loadLocalUser()
        self.init(viewModel: viewModel, user: user)
    }
}
struct LoginView_PreViews: PreviewProvider {
    static var previews: some View {
        return LoginView(viewModel: LoginViewModel())
    }
}
