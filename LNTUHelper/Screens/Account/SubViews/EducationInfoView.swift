//
//  EducationInfoView.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/29.
//

import SwiftUI

struct EducationInfoView: View {
    
    @ObservedObject var router = ViewRouter.router
    @ObservedObject var viewModel: LoginViewModel
    
    var body: some View {
        List {
            Group {
                InfoRowView(key: "姓名", value: $viewModel.userInfo.name)
                InfoRowView(key: "英文姓名", value: $viewModel.userInfo.nickname)
                InfoRowView(key: "性别", value: $viewModel.userInfo.gender)
                InfoRowView(key: "年级", value: $viewModel.userInfo.grade)
                InfoRowView(key: "学生类别", value: $viewModel.userInfo.studentType)
                InfoRowView(key: "校区", value: $viewModel.userInfo.campus)
                InfoRowView(key: "院系", value: $viewModel.userInfo.college)
                InfoRowView(key: "专业", value: $viewModel.userInfo.major)
                InfoRowView(key: "班级", value: $viewModel.userInfo.majorClass)
            }
            Group {
                InfoRowView(key: "入校时间", value: $viewModel.userInfo.enrollDate)
                InfoRowView(key: "毕业时间", value: $viewModel.userInfo.graduateDate)
                InfoRowView(key: "学历层次", value: $viewModel.userInfo.education)
                InfoRowView(key: "学习形式", value: $viewModel.userInfo.studyType)
                InfoRowView(key: "是否在校", value: $viewModel.userInfo.isInSchool)
                InfoRowView(key: "是否有学籍", value: $viewModel.userInfo.isInSchool)
                InfoRowView(key: "是否在职", value: $viewModel.userInfo.isWorking)
            }
        }
        .navigationBarTitle("个人信息", displayMode: .large)
        .navigationBarItems(trailing: refreshButton)
        .onAppear {
            login()
            Haptic.shared.tappedHaptic()
            if !Constants.isLogin { router.isShowLoginView = true }
        }
    }
    
    var refreshButton: some View {
        Button(action: {
            Haptic.shared.tappedHaptic()
            self.login()
        }) {
            Text("刷新")
        }
    }
    
    func login() {
        viewModel.login { (isSuccess) in
            router.isShowLoginView = isSuccess ? false : true
            router.banner = viewModel.banner
        }
    }
}

struct UserCenterInfoView_Previews: PreviewProvider {
    static var previews: some View {
        EducationInfoView(viewModel: LoginViewModel())
    }
}

