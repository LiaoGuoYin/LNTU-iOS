//
//  WeekSelectorView.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/12/5.
//

import SwiftUI

struct WeekSelectorView: View {
    @Binding var selectedWeek: Int
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 2) {
                ForEach(1..<23, id: \.self) { each in
                    Text(String(each))
                        .font(.caption)
                        .foregroundColor(.white)
                        .padding(12)
                        .frame(width: 48)
                        .background((selectedWeek == each) ? Color("primary") : Color("primary").opacity(0.4))
                        .cornerRadius(3.0)
                        .onTapGesture(perform: {
                            self.selectedWeek = each
                        })
                }
            }
        }
    }
}


struct WeekSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        WeekSelectorView(selectedWeek: .constant(3))
    }
}