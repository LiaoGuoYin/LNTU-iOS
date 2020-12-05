//
//  SectionLabelView.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/29.
//

import SwiftUI

struct SectionLabelView: View {
    
    var name: String
    var systemName: String
    
    var body: some View {
        HStack {
            Image(systemName: systemName)
            Text(name)
        }
        .font(.system(.headline, design: .monospaced))
        .foregroundColor(Color(.systemPink))
    }
}


struct SectionLabelView_Previews: PreviewProvider {
    static var previews: some View {
        SectionLabelView(name: "DEMO", systemName: "number.square.fill")
    }
}
