//
//  AccountView.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/28.
//

import SwiftUI

struct AccountView: View {
    
    @EnvironmentObject var router: ViewRouter
    @ObservedObject var viewModel: LoginViewModel
    
    var body: some View {
        Form {
            Section(header: Text("教务在线")) {
                NavigationLink(
                    destination: EducationInfoView(user: router.loginViewModel.userInfo),
                    label: {
                        if #available(iOS 14.0, *) {
                            LabelView(name: "个人信息", iconName: "at.circle", iconColor: Color("primary"))
                        } else {
                            LabelView(name: "个人信息", iconName: "eyeglasses", iconColor: Color("primary"))
                        }
                    })
                
                NavigationLink(
                    destination: ExamPlanView(viewModel: ExamPlanViewModel(user: router.user)),
                    label: { LabelView(name: "考试安排", iconName: "number.square", iconColor: Color(.systemRed)) })
            }
            
            Section(header: Text("其他系统")) {
                NavigationLink(
                    destination: LibraryCardView(),
                    label: { LabelView(name: "图书馆", iconName: "barcode.viewfinder", iconColor: Color.blue) })
                
                NavigationLink(
                    destination: QualityActivityView(viewModel: QualityActivityViewModel()),
                    label: { LabelView(name: "素拓网", iconName: "rosette", iconColor: Color.pink) })
                
                NavigationLink(
                    destination: TodoView(),
                    label: { LabelView(name: "其他链接", iconName: "link", iconColor: Color.yellow) })
            }
            
            NavigationLink(
                destination: SettingsView().environmentObject(router),
                label: { LabelView(name: "更多", iconName: "gear", iconColor: Color("primary")) })
        }
        .accentColor(Color("primary"))
        .onAppear(perform: {
            Haptic.shared.tappedHaptic()
        })
        .banner(data: $viewModel.banner, isShow: $viewModel.isShowBanner)
    }
}

struct UserCenterView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView(viewModel: LoginViewModel(user: MockData.user))
            .environmentObject(ViewRouter(user: MockData.user))
    }
}
