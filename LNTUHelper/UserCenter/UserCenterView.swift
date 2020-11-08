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
            ScrollView(showsIndicators: false) {
                if router.isLogin {
                    NavigationLink(
                        destination: UserCenterInfoView(user: viewModel.userInfo),
                        label: {
                            HStack {
                                Image(systemName: "person.crop.rectangle")
                                    .font(.system(size: 40))
                                    .foregroundColor(Color.white)
                                Spacer()
                                VStack(alignment: .leading) {
                                    Text(viewModel.userInfo.name)
                                    Text(viewModel.userInfo.chiefCollege)
                                }
                                .foregroundColor(Color.white)
                            }
                            .padding(20)
                            .background(Color("primary"))
                        }
                    )
                    .cornerRadius(12)
                } else {
                    EmptyView()
                }
                
                LibraryCardView()
                
                logoutButton
            }
            .padding()
            .navigationBarTitle(Text("用户中心"), displayMode: .large)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .accentColor(Color("primary"))
    }
    
    var logoutButton: some View {
        Button(action: {
            Haptic.shared.complexSuccess()
            router.isLogin = false
        }) {
            HStack {
                Spacer()
                Text("Logout")
                Spacer()
            }
            .foregroundColor(.white)
            .padding()
            .background(Color("primary"))
            .cornerRadius(8)
        }
    }
}

struct UserCenterView_Previews: PreviewProvider {
    static var previews: some View {
        let user = User(username: "17100301010", password: "*")
        return UserCenterView(viewModel: LoginViewModel(user: user))
            .environmentObject(ViewRouter(user: user, isLogin: true))
    }
}
