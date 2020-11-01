//
//  UserCenterView.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/28.
//

import SwiftUI

struct UserCenterView: View {
    
    @EnvironmentObject var router: ViewRouter
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                NavigationLink(
                    destination: UserCenterInfoView(user: router.loginViewModel.userInfo),
                    label: {
                        HStack {
                            Image(systemName: "eyes")
                                .font(.system(size: 40))
                                .foregroundColor(Color.black)
                            Spacer()
                            VStack(alignment: .leading) {
                                Text(router.loginViewModel.userInfo.name)
                                Text(router.loginViewModel.userInfo.chiefCollege)
                            }
                            .foregroundColor(Color.white)
                        }
                        .padding(20)
                        .background(Color("primary"))
                    }
                )
                .padding(.bottom, 10)
                .cornerRadius(12)
                .padding()
                
                logoutButton
                
                //                ForEach(1..<5, id: \.self) { _ in
                //                    HStack {
                //                        Rectangle()
                //                            .foregroundColor(Color(.systemYellow))
                //                            .frame(width: UIScreen.main.bounds.width / 2 - 25, height: UIScreen.main.bounds.width / 2 - 25)
                //                            .cornerRadius(12)
                //                        Spacer()
                //                        Rectangle()
                //                            .foregroundColor(Color("navyBlue"))
                //                            .frame(width: UIScreen.main.bounds.width / 2 - 25, height: UIScreen.main.bounds.width / 2 - 25)
                //                            .cornerRadius(12)
                //                    }
                //                    .padding()
                //                }
            }
            .shadow(radius: 5)
            .navigationBarTitle(Text("用户中心"), displayMode: .large)
            .accentColor(Color("primary"))
        }
    }
    
    var logoutButton: some View {
        Button(action: {
            Haptic.shared.complexSuccess()
            router.isLogin = false
        }) {
            Text("Logout")
        }
    }
}

struct UserCenterView_Previews: PreviewProvider {
    static var previews: some View {
        let user = User(username: "17100301010", password: "*")
        return UserCenterView()
            .environmentObject(ViewRouter(user: user, isLogin: false))
    }
}
