//
//  HapticModels.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/30.
//

import SwiftUI

struct Haptic {
    
    static let shared = Haptic()
    let notification = UINotificationFeedbackGenerator()
    let impact = UIImpactFeedbackGenerator()
    let selection = UISelectionFeedbackGenerator()
    
    func tappedHaptic() {
        impact.impactOccurred()
    }
    
    func simpleSuccess() {
        notification.notificationOccurred(.success)
    }
    
    func simpleError() {
        notification.notificationOccurred(.error)
    }
    
}
