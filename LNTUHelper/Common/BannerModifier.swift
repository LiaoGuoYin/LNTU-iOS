//
//  BannerModifier.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/25.
//

import SwiftUI

struct BannerModifier: ViewModifier {
    
    struct Data {
        var title: String = "操作结果"
        var content: String = "初始化成功"
        var type: BannerType = .Success
    }
    
    enum BannerType {
        case Info
        case Warning
        case Success
        case Error
        
        var tintColor: Color {
            switch self {
            case .Info:
                return Color.green
            case .Success:
                return Color(red: 67/255, green: 154/255, blue: 215/255)
            case .Warning:
                return Color.yellow
            case .Error:
                return Color.red
            }
        }
    }
    
    @Binding var data: Data
    @Binding var isShow: Bool
    @State var location = CGPoint(x: 0, y: 0)
    
    func body(content: Content) -> some View {
        ZStack {
            content
            if isShow {
                VStack {
                    HStack {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(data.title)
                                .font(Font.system(size: 15, weight: Font.Weight.bold, design: Font.Design.rounded))
                            Text(data.content)
                                .font(Font.system(size: 11, weight: Font.Weight.regular, design: Font.Design.rounded))
                        }
                        Spacer()
                    }
                    .foregroundColor(Color.white)
                    .padding()
                    .background(data.type.tintColor)
                    .cornerRadius(8)
                    .shadow(radius: 6)
                    
                    Spacer()
                }
                .padding()
                .animation(.easeInOut)
                .transition(AnyTransition.move(edge: .top).combined(with: .opacity))
                .offset(y: location.y > 0 ? 0 : location.y)
                .onAppear(perform: {
                    Haptic.shared.simpleSuccess()
                    location.y = 0
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
                        withAnimation {
                            self.isShow = false
                        }
                    }
                })
                .gesture(drag)
            }
        }
    }
    
    var drag: some Gesture {
        DragGesture()
            .onChanged { action in
                location = action.location
            }
            .onEnded { action in
                if location.y < -16 {
                    isShow = false
                } else {
                    isShow = true
                }
            }
    }
}

extension View {
    func banner(data: Binding<BannerModifier.Data>, isShow: Binding<Bool>) -> some View {
        return self.modifier(BannerModifier(data: data, isShow: isShow))
    }
}

struct BannerDemoView: View {
    
    @State var isShow: Bool = true
    @State var data: BannerModifier.Data = BannerModifier.Data(title: "DEMO", content: "This is description.")
    @State var location = CGPoint(x: 0, y: 0)
    
    var body: some View {
        
        Text("Hello World!")
            .banner(data: $data, isShow: $isShow)
            .onTapGesture(perform: {
                isShow = true
            })
    }
}

struct BannerModifier_Previews: PreviewProvider {
    static var previews: some View {
        BannerDemoView()
    }
}
