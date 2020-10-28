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
                    destination: Text("TODO"),
                    label: {
                        HStack {
                            Image(systemName: "eyes")
                                .font(.system(size: 40))
                                .foregroundColor(Color.black)
                            
                            Spacer()
                            
                            VStack(alignment: .leading) {
                                Text("廖国胤")
                                Text("工商管理学院")
                            }
                            .foregroundColor(Color.white)
                        }
                        .padding(20)
                        .background(Color("navyBlue"))
                    }
                )
                .padding(.bottom, 10)
                .cornerRadius(12)
                .padding()
                
                ForEach(1..<5, id: \.self) { _ in
                    HStack {
                        Rectangle()
                            .foregroundColor(Color(.systemYellow))
                            .frame(width: UIScreen.main.bounds.width / 2 - 25, height: UIScreen.main.bounds.width / 2 - 25)
                            .cornerRadius(12)
                        Spacer()
                        Rectangle()
                            .foregroundColor(Color("navyBlue"))
                            .frame(width: UIScreen.main.bounds.width / 2 - 25, height: UIScreen.main.bounds.width / 2 - 25)
                            .cornerRadius(12)
                    }
                    .padding()
                }
            }
            .navigationBarTitle(Text("用户中心"), displayMode: .large)
            .navigationBarItems(trailing: logoutButton)
        }
    }
    
    var logoutButton: some View {
        Button(action: {
            router.isLogin = false
        }) {
            Text("Logout")
        }
    }
}

struct UserCenterView_Previews: PreviewProvider {
    static var previews: some View {
        UserCenterView()
    }
}
