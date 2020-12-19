//
//  WeekSelectorView.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/12/5.
//

import SwiftUI

struct WeekSelectorView: View {
    
    @Binding var title: String
    @Binding var selectedIndex: Int
    @State var numberList: [String]
    
    var body: some View {
        HStack(spacing: 0) {
            Text(title)
                .foregroundColor(Color("primary"))
                .frame(width: title == "" ? 0 : 63)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 2) {
                    ForEach(1...numberList.count, id: \.self) { index in
                        Text(String(numberList[index - 1]))
                            .font(.caption)
                            .foregroundColor(.white)
                            .padding(11)
                            .frame(width: 38, height: 30)
                            .background((selectedIndex == index) ? Color("primary") : Color("primary").opacity(0.4))
                            .cornerRadius(3.0)
                            .onTapGesture(perform: {
                                Haptic.shared.tappedHaptic()
                                self.selectedIndex = index
                            })
                    }
                }
            }
        }
    }
}


struct WeekSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        let weekList = ["一", "二", "三", "四", "五", "六", "日"]
        WeekSelectorView(title: .constant("星期天"), selectedIndex: .constant(2), numberList: weekList)
    }
}
