//
//  MultiDevicePreviewModifier.swift
//  LNTUHelper
//
//  Created by Jingbin Yu on 2021/1/9.
//

import SwiftUI

struct MultiDevicePreviewModifier: ViewModifier {
    
    @State var deviceNames:[String]
    
    func body(content: Content) -> some View {
        Group {
            ForEach(deviceNames, id: \.self) { device in
                content
                    .previewDevice(PreviewDevice(rawValue: device))
                    .previewLayout(.sizeThatFits)
                    .previewDisplayName(device)
            }
        }
    }
}

extension View {
    func multiDevicePreview(deviceNames: [String]) -> some View {
        self.modifier(MultiDevicePreviewModifier(deviceNames: deviceNames))
    }
}

struct MultiDevicePreviewModifier_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello World")
            .multiDevicePreview(deviceNames: ["iPhone 8"])
    }
}
