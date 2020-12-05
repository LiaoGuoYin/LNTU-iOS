//
//  LoginView.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/27.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var router: ViewRouter
    @State private var isShowingSheet = false
    
    var body: some View {
        NavigationView {
            List {
                HStack {
                    Text("学号")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color("primary"))
                        .cornerRadius(8)
                    TextField("请输入学号", text: $router.user.username)
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
                    SecureField("请输入身份证(默认密码)", text:  $router.user.password)
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
        }
        .resignKeyboardOnDragGesture()
        .banner(data: $router.banner, isShow:  $router.isShowBanner)
        .sheet(isPresented: $isShowingSheet) {
            SafariView()
                .navigationBarTitle(Text("用户协议"), displayMode: .inline)
        }
    }
    
    var loginButton: some View {
        Button(action: {
            Haptic.shared.simpleSuccess()
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
        return LoginView()
            .environmentObject(ViewRouter(user: MockData.user))
    }
}
