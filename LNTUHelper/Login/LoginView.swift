//
//  LoginView.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/27.
//

import Foundation
import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var router: ViewRouter
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    HStack {
                        Text("学号")
                            .padding()
                            .foregroundColor(.white)
                            .background(Color("navyBlue"))
                            .cornerRadius(8)
                        
                        TextField("1710030215", text: $router.user.username)
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
                        SecureField("*", text:  $router.user.password)
                            .padding()
                            .background(Color(.systemFill))
                            .cornerRadius(8)
                    }
                    loginButton
                }
                .padding()
                .navigationBarTitle(Text("Login"), displayMode: .large)
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
            .background(Color("navyBlue"))
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
