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
        VStack(spacing: 8) {
            HStack {
                Text(user.name)
                Text(user.gender)
                Text(user.grade)
                Text(String((user.username)))
            }
            
            HStack {
                Text(user.major)
                Text(user.majorClass)
            }
            HStack {
                Text(user.campus)
                Text(user.studentType)
                // Text(user.eduLength)
            }
            
            HStack(spacing: 32) {
                Text(user.enrollDate)
                Text(user.graduateDate)
            }
        }
        .foregroundColor(.white)
        .padding()
        .background(Color(.systemPink))
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

struct UserCenterInfoView_Previews: PreviewProvider {
    static var previews: some View {
        UserCenterInfoView(user: educationInfoResponseDataObjectDemo!)
    }
}
