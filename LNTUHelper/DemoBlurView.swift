//
//  DemoBlurView.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2021/1/3.
//

import SwiftUI

struct DemoBlurView: View {
    @State var isBlur = false
    var body: some View {
        ZStack {
            Text("Tap me to blur")
                .foregroundColor(.green)
                .onLongPressGesture {
                    isBlur.toggle()
                }
            
            Text("Hello, World!")
                .offset(y: 100)
                .blur(radius: 10, opaque: isBlur)
        }
    }
}

struct DemoBlurView_Previews: PreviewProvider {
    static var previews: some View {
        DemoBlurView()
    }
}
