//
//  GroupedListKeysHorizontalScrollView.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/12/13.
//

import SwiftUI

struct GroupedListKeysHorizontalScrollView: View {
    
    @Binding var keys: [String]
    @Binding var selectedIndex: Int
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(0..<keys.count, id: \.self) { index in
                    Text(keys[index])
                        .foregroundColor(.white)
                        .padding(12)
                        .background(selectedIndex == index ? Color("primary") : Color("primary").opacity(0.3))
                        .cornerRadius(6)
                        .onTapGesture {
                            Haptic.shared.tappedHaptic()
                            self.selectedIndex = index
                        }
                }
            }
        }
        .padding(.horizontal)
    }
}

struct GroupedListKeysHorizontalScrollView_Previews: PreviewProvider {
    static var previews: some View {
        let keys = ["2020", "2019", "2018"]
        return GroupedListKeysHorizontalScrollView(keys: .constant(keys), selectedIndex: .constant(0))
    }
}
