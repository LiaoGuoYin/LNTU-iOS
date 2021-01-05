//
//  AccountView.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/28.
//

import SwiftUI

struct AccountView: View {
    
    @ObservedObject var router = ViewRouter.router
    @ObservedObject var viewModel: LoginViewModel
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("教务在线")) {
                    NavigationLink(
                        destination: EducationInfoView(viewModel: router.loginViewModel),
                        label: {
                            if #available(iOS 14.0, *) {
                                LabelView(name: "个人信息", iconName: "at.circle", iconColor: Color("primary"))
                            } else {
                                LabelView(name: "个人信息", iconName: "eyeglasses", iconColor: Color("primary"))
                            }
                        })
                    
                    NavigationLink(
                        destination: ExamPlanView(viewModel: ExamPlanViewModel()),
                        label: { LabelView(name: "考试安排", iconName: "number.square", iconColor: Color(.systemRed)) })
                }
                
                Section(header: Text("其他系统")) {
                    NavigationLink(
                        destination: LibraryCardView(),
                        label: { LabelView(name: "图书馆", iconName: "barcode.viewfinder", iconColor: Color.blue) })

//                    NavigationLink(
//                        destination: QualityActivityView(viewModel: viewModel.qualityViewModel),
//                        label: { LabelView(name: "素拓网", iconName: "rosette", iconColor: Color.pink) })

                    //                    NavigationLink(
                    //                        destination: TodoView(),
                    //                        label: { LabelView(name: "其他链接", iconName: "link", iconColor: Color.yellow) })
                }
                
                NavigationLink(
                    destination: SettingsView(),
                    label: { LabelView(name: "更多", iconName: "gear", iconColor: Color("primary")) })
            }
            .navigationBarTitle(Text(TabBarItemEnum.account.rawValue), displayMode: .large)
        }
        .onAppear(perform: {
            Haptic.shared.tappedHaptic()
        })
    }
}

struct UserCenterView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView(viewModel: LoginViewModel())
    }
}
