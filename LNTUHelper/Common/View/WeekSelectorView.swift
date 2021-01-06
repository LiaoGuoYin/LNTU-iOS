//
//  WeekSelectorView.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/12/5.
//

import SwiftUI

struct WeekSelectorView: View {
    
    // DisplayMode: To specify the way to display everything in a row or in a grid-like pattern. When everything is displayed in a grid-like pattern (i.e. ".grid" is the chosen), the number of elements should be explicitly specified as the associated value to the ".grid" enum case
    
    enum DisplayMode {
        case normal
        case grid(Int)
        
        func getAssociatedValue() -> Int {
            switch self {
            case .normal:
                return -1
            case .grid(let numberOfItemsPerRow):
                return numberOfItemsPerRow
            }
        }
    }
    
    @Binding var title: String
    @Binding var selectedIndex: Int
    @State var numberList: [String]
    let displayMode: DisplayMode
    @ObservedObject var router = ViewRouter.router
    
    
    var body: some View {
        HStack(spacing: 0) {
            Text(title)
                .foregroundColor(Color("primary"))
                .frame(width: title == "" ? 0 : 63)
            VStack(alignment: .leading) {
                let numberOfItemsPerRow = displayMode.getAssociatedValue()
                
                let rowNumber = (numberOfItemsPerRow != -1 ?
                                    (numberList.count % numberOfItemsPerRow == 0 ?
                                        numberList.count / numberOfItemsPerRow:
                                        numberList.count / numberOfItemsPerRow + 1):
                                1)
            
            ForEach(1...rowNumber, id:\.self) { row in
                if numberOfItemsPerRow == -1 {
                    ScrollView(.horizontal, showsIndicators: false){
                        SelectorRowView(numberOfElementsPerRow: numberOfItemsPerRow,
                                        numberList: $numberList,
                                        selectedIndex: $selectedIndex,
                                        row: row)
                    }
                } else {
                    SelectorRowView(numberOfElementsPerRow: numberOfItemsPerRow,
                                    numberList: $numberList,
                                    selectedIndex: $selectedIndex,
                                    row: row)
                }
            }
          }
        }
    }
}

struct SelectorRowView: View {
    let numberOfElementsPerRow: Int
    @Binding var numberList: [String]
    @Binding var selectedIndex: Int
    @ObservedObject var router = ViewRouter.router
    
    let row: Int
    
    var body: some View {
        HStack(spacing: 2) {
            let startNumber = (numberOfElementsPerRow != -1 ?
                                (row - 1) * numberOfElementsPerRow + 1 :
                                1)
            let endNumber = (numberOfElementsPerRow != -1 ?
                                (row * numberOfElementsPerRow <= numberList.count ?
                                    row * numberOfElementsPerRow :
                                    numberList.count) :
                            numberList.count)
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

struct WeekSelectorView_Previews: PreviewProvider {
    static var previews: some View {
//        let weekList = ["一", "二", "三", "四", "五", "六", "日"]
      let longWeekList = Array(1...22).map { String($0) }
        Group {
            WeekSelectorView(title: .constant(""), selectedIndex: .constant(10), numberList: longWeekList, displayMode: .grid(7))
            WeekSelectorView(title: .constant(""), selectedIndex: .constant(10), numberList: longWeekList, displayMode: .normal)
        }
    }
}
