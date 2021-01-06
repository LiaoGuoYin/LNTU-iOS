//
//  ExamFinishedModifier.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2021/1/6.
//

import SwiftUI

struct ExamFinishedModifier: ViewModifier {
    @State var isShowing = false
    func body(content: Content) -> some View {
        content
            .overlay(
                Image(systemName: "checkmark.seal")
                    .resizable()
                    .foregroundColor(.white)
                    .frame(width: 18, height: 18, alignment: .center)
                    .background(Color.clear)
                    .padding(5)
                    .opacity(self.isShowing ? 1 : 0)
                , alignment: .topTrailing)
    }
}

extension View {
    func examFinished(isShowing: Bool) -> some View {
        return self.modifier(ExamFinishedModifier(isShowing: isShowing))
    }
}

struct ExamFinishedModifier_Previews: PreviewProvider {
    static var previews: some View {
        CardExamPlanView(course: MockData.examPlanList[2])
            .examFinished(isShowing: true)
    }
}
