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
    
    @State private var isTeacherEvaluationRequestProcessing = false
    @State private var isShowingTeacherEvaluationAlert = false
    
    @State private var teacherEvaluationAlertContent = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("教务在线")) {
                    NavigationLink(
                        destination: EducationInfoView(viewModel: router.loginViewModel),
                        label: {
                            if #available(iOS 14.0, *) {
                                LabelView(name: "个人信息", iconName: "at.circle", iconColor: Color(#colorLiteral(red: 0, green: 0.5628422499, blue: 0.3188166618, alpha: 1)))
                            } else {
                                LabelView(name: "个人信息", iconName: "eyeglasses", iconColor: Color(#colorLiteral(red: 0, green: 0.5628422499, blue: 0.3188166618, alpha: 1)))
                            }
                        })
                    
                    NavigationLink(
                        destination: ExamPlanView(viewModel: ExamPlanViewModel()),
                        label: { LabelView(name: "考试安排", iconName: "number.square", iconColor: Color(.systemRed)) })
                    
                    HStack {
                        Button(action: {
                            isTeacherEvaluationRequestProcessing = true
                            self.viewModel.checkForEvaluation { (isSucceeded) in
                                if isSucceeded {
                                    let teacherEvaluationAlertTitle = (self.viewModel.needsTeacherEvaluation ? "即将评教的科目如下：" : "已完成以下评教：")
                                    
                                    teacherEvaluationAlertContent.append(teacherEvaluationAlertTitle)
                                    
                                    for data in self.viewModel.teacherEvaluationData {
                                        teacherEvaluationAlertContent.append("\n\(data.name) - \(data.teacher)")
                                    }
                                    
                                    isShowingTeacherEvaluationAlert = true
                                } else {
                                    router.banner.title = "无法进行评教"
                                    router.banner.content = "抱歉，尝试进行评教时发生错误，请稍后再试"
                                    router.banner.type = .Error
                                }
                            }
                        }) {
                            let teacherEvaluationButtonTitle = (!router.isLogin) ? "一键评教（请先登录）" : "一键评教"
                            LabelView(name: teacherEvaluationButtonTitle, iconName: "hand.thumbsup.fill", iconColor: Color(.systemBlue))
                                .foregroundColor(Color(.systemBlue).opacity(0.8))
                        }
                        .disabled(isTeacherEvaluationRequestProcessing || !router.isLogin)
                        .alert(isPresented: $isShowingTeacherEvaluationAlert, content: {
                            if self.viewModel.needsTeacherEvaluation {
                                return Alert(title: Text("即将对以下项目进行评教"),
                                             message: Text(teacherEvaluationAlertContent),
                                             primaryButton: Alert.Button.default(Text("取消评教"), action: {
                                                isTeacherEvaluationRequestProcessing = false
                                                teacherEvaluationAlertContent = ""
                                             }),
                                             secondaryButton: Alert.Button.default(Text("一键评教"), action: {
                                                self.viewModel.beginEvaluation { _ in
                                                    isTeacherEvaluationRequestProcessing = false
                                                }
                                                teacherEvaluationAlertContent = ""
                                             })
                                )
                            } else {
                                return Alert(title: Text("你已经评教完啦"),
                                             message: Text(teacherEvaluationAlertContent),
                                             dismissButton: .cancel({
                                                teacherEvaluationAlertContent = ""
                                                isTeacherEvaluationRequestProcessing = false
                                             }))
                            }
                        })
                        
                        Spacer()
                        ActivityIndicator(isAnimating: $isTeacherEvaluationRequestProcessing, style: .medium)
                    }
                }
                
                Section(header: Text("其他系统")) {
                    NavigationLink(
                        destination: LibraryCardView(),
                        label: { LabelView(name: "图书馆", iconName: "barcode.viewfinder", iconColor: Color.blue) })
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
        .banner(data: $viewModel.banner, isShow: $viewModel.isShowBanner)
    }
}

struct UserCenterView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView(viewModel: LoginViewModel())
    }
}
