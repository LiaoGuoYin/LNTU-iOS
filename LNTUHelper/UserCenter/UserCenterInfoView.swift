//
//  UserCenterInfoView.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/29.
//

import SwiftUI

struct UserCenterInfoView: View {
    @State var user: EducationInfoResponseData
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 8) {
                Group {
                    UserInfoRowView(key: "姓名", value: user.name)
                    UserInfoRowView(key: "英文姓名", value: user.nickname)
                    UserInfoRowView(key: "性别", value: user.gender)
                    UserInfoRowView(key: "年级", value: user.grade)
                    UserInfoRowView(key: "学生类别", value: user.studentType)
                    UserInfoRowView(key: "校区", value: user.campus)
                    UserInfoRowView(key: "院系", value: user.college)
                    UserInfoRowView(key: "专业", value: user.major)
                    UserInfoRowView(key: "班级", value: user.majorClass)
                }
                Group {
                    UserInfoRowView(key: "入校时间", value: user.enrollDate)
                    UserInfoRowView(key: "毕业时间", value: user.graduateDate)
                    UserInfoRowView(key: "学历层次", value: user.education)
                    UserInfoRowView(key: "学习形式", value: user.studyType)
                    UserInfoRowView(key: "是否在校", value: user.isInSchool)
                    UserInfoRowView(key: "是否有学籍", value: user.isInSchool)
                    UserInfoRowView(key: "是否在职", value: user.isWorking)
                }
            }
        }
        .navigationBarTitle("个人信息", displayMode: .inline)
    }
}

struct UserCenterInfoView_Previews: PreviewProvider {
    static var previews: some View {
        UserCenterInfoView(user: educationInfoResponseDataObjectDemo!)
    }
}

struct UserInfoRowView: View {
    @State var key: String
    @State var value: String
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                Divider()
                Text(key)
                    .font(.headline)
                    .fontWeight(.bold)
                Text(value)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .padding(.horizontal)
    }
}
