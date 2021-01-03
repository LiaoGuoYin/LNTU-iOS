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
          VStack(alignment: .leading) {
            let rowNumber = (numberList.count % 7 == 0 ? numberList.count / 7 : numberList.count / 7 + 1)
            ForEach(1...rowNumber, id:\.self) { row in
              HStack(spacing: 2) {
                let startNumber = (row - 1) * 7 + 1
                let endNumber = (row * 7 <= numberList.count ? row * 7 : numberList.count)
                ForEach(startNumber...endNumber, id: \.self) { index in
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
}


struct WeekSelectorView_Previews: PreviewProvider {
    static var previews: some View {
//        let weekList = ["一", "二", "三", "四", "五", "六", "日"]
      let longWeekList = Array(1...22).map { String($0) }
        WeekSelectorView(title: .constant("第周"), selectedIndex: .constant(10), numberList: longWeekList)
    }
}
