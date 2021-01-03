//
//  WeekSelectorView.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/12/5.
//

import SwiftUI

struct WeekSelectorView: View {
    
    enum DisplayMode: Int {
        case normal = 0
        case grid = 1
    }
    // Either display everything in a row or in a grid-like pattern
    
    @Binding var title: String
    @Binding var selectedIndex: Int
    @State var numberList: [String]
    let displayMode: DisplayMode
    @EnvironmentObject var router: ViewRouter
    
    
    var body: some View {
        HStack(spacing: 0) {
            Text(title)
                .foregroundColor(Color("primary"))
                .frame(width: title == "" ? 0 : 63)
            VStack(alignment: .leading) {
            let rowNumber = (displayMode == .grid ? (numberList.count % 7 == 0 ? numberList.count / 7 : numberList.count / 7 + 1) : 1)
            
            ForEach(1...rowNumber, id:\.self) { row in
                if displayMode == .normal {
                    ScrollView(.horizontal, showsIndicators: false){
                        SelectorRowView(displayMode: displayMode, numberList: $numberList, selectedIndex: $selectedIndex, row: row)
                            .environmentObject(router)
                    }
                } else {
                    SelectorRowView(displayMode: displayMode, numberList: $numberList, selectedIndex: $selectedIndex, row: row)
                        .environmentObject(router)
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
        Group {
            WeekSelectorView(title: .constant(""), selectedIndex: .constant(10), numberList: longWeekList, displayMode: .grid)
                .environmentObject(ViewRouter())
            WeekSelectorView(title: .constant(""), selectedIndex: .constant(10), numberList: longWeekList, displayMode: .normal)
                .environmentObject(ViewRouter())
        }
    }
}

struct SelectorRowView: View {
    let displayMode: WeekSelectorView.DisplayMode
    @Binding var numberList: [String]
    @Binding var selectedIndex: Int
    @EnvironmentObject var router: ViewRouter
    
    let row: Int
    
    var body: some View {
        HStack(spacing: 2) {
            let startNumber = (displayMode == .grid ? (row - 1) * 7 + 1 : 1)
            let endNumber = (displayMode == .grid ? (row * 7 <= numberList.count ? row * 7 : numberList.count) : numberList.count)
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
                        if router.isBlured {
                            router.hideBlurView()
                        }
                    })
            }
        }
    }
}
