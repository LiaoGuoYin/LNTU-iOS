//
//  EducationInfoView.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/29.
//

import SwiftUI

struct EducationInfoView: View {
    
    @State var user: EducationInfoResponseData
    
    var body: some View {
        List {
            Group {
                InfoRowView(key: "姓名", value: user.name)
                InfoRowView(key: "英文姓名", value: user.nickname)
                InfoRowView(key: "性别", value: user.gender)
                InfoRowView(key: "年级", value: user.grade)
                InfoRowView(key: "学生类别", value: user.studentType)
                InfoRowView(key: "校区", value: user.campus)
                InfoRowView(key: "院系", value: user.college)
                InfoRowView(key: "专业", value: user.major)
                InfoRowView(key: "班级", value: user.majorClass)
            }
//            Group {
//            InfoRowView(key: "入校时间", value: user.enrollDate)
//            InfoRowView(key: "毕业时间", value: user.graduateDate)
//                InfoRowView(key: "学历层次", value: user.education)
//                InfoRowView(key: "学习形式", value: user.studyType)
//                InfoRowView(key: "是否在校", value: user.isInSchool)
//                InfoRowView(key: "是否有学籍", value: user.isInSchool)
//                InfoRowView(key: "是否在职", value: user.isWorking)
//            }
        }
        .navigationBarTitle("个人信息", displayMode: .large)
    }
}

struct UserCenterInfoView_Previews: PreviewProvider {
    static var previews: some View {
        EducationInfoView(user: MockData.educationInfo)
    }
}

