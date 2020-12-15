//
//  QualityActivityCardView.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/12/10.
//

import SwiftUI

struct QualityActivityCardView: View {
    
    @State var qualityActivityResponseData: QualityActivityResponseData
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(qualityActivityResponseData.name)
                .foregroundColor(Color.white)
                .font(.headline)
            
            HStack(alignment: .top) {
                Text(qualityActivityResponseData.activityDate)
                Text(qualityActivityResponseData.responsibility)
            }
            
            HStack(alignment: .top) {
                Text(qualityActivityResponseData.loggingDateTime)
                Text(qualityActivityResponseData.status)
            }
            
            Text(qualityActivityResponseData.comment ?? "")
                .foregroundColor(Color(.systemTeal))
            
            HStack(alignment: .top) {
                Text(qualityActivityResponseData.semester)
                Spacer()
                Text("\(qualityActivityResponseData.type) \(qualityActivityResponseData.id)")
            }
        }
        .foregroundColor(Color.white.opacity(0.8))
        .padding()
        .background(Color("primary"))
        .cornerRadius(15)
    }
}

struct QualityActivityCardView_Previews: PreviewProvider {
    static var previews: some View {
        QualityActivityCardView(qualityActivityResponseData: MockData.qualityActivityList[0])
    }
}
