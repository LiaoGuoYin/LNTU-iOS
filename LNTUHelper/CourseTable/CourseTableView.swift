//
//  CourseTableView.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/26.
//

import SwiftUI

struct CourseTableView: View {
    
    @ObservedObject var viewModel: CourseTableViewModel
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                WeekSelecter(selectedWeek: $viewModel.currentWeek)
                CourseTableBodyView(courseTableMatrix: $viewModel.martrix)
                    .padding(.horizontal)
                    .navigationBarTitle(Text("课表"), displayMode: .inline)
                    .navigationBarItems(trailing: refreshButton)
            }
        }
        .banner(data: $viewModel.banner, isShow: $viewModel.isShowBanner)
    }
    
    var refreshButton: some View {
        Button(action: {
            Haptic.shared.complexSuccess()
            viewModel.refreshCourseTable()
        }) {
            Text("刷新")
        }
    }
}

struct CourseTableView_Previews: PreviewProvider {
    static var previews: some View {
        return CourseTableView(viewModel: CourseTableViewModel(user: User(username: "1710030215", password: "")))
    }
}

struct WeekSelecter: View {
    @Binding var selectedWeek: Int
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 2) {
                ForEach(1..<21, id: \.self) { each in
                    Text(String(each))
                        .font(.caption)
                        .foregroundColor(.white)
                        .padding(12)
                        .frame(width: 48)
                        .background((selectedWeek == each) ? Color(.systemBlue): Color(.systemGray))
                        .cornerRadius(3.0)
                        .onTapGesture(perform: {
                            self.selectedWeek = each
                        })
                }
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
}
