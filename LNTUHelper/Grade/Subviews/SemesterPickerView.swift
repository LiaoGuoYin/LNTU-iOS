//
//  SemesterPickerView.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/29.
//

import SwiftUI

struct SemesterPickerView: View {
    var terms = ["大一", "大二", "大三", "大四"]
    var semeters = ["秋季(上)", "春季(下)"]
    @State var selectedTerm = 0
    @State var selectedSemeter = 0
    var body: some View {
        VStack {
            Picker("年度", selection: $selectedTerm) {
                ForEach(terms.indices) {
                    Text(terms[$0])
                }
            }
            Picker("学期", selection: $selectedSemeter) {
                ForEach(semeters.indices) {
                    Text(semeters[$0])
                    // .onTapGesture { hapticFeedback.impactOccurred()}
                }
            }
        }
        .pickerStyle(SegmentedPickerStyle())
    }
}

struct SemesterPickerView_Previews: PreviewProvider {
    static var previews: some View {
        SemesterPickerView()
    }
}
