//
//  HapticModels.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/30.
//

import SwiftUI
import CoreHaptics

struct Haptic {
    static let shared = Haptic()
    let generator = UINotificationFeedbackGenerator()
    var engine: CHHapticEngine?
    init() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was some error  creating the engine:\(error.localizedDescription)")
        }
    }
    
    func simpleSuccess() {
        generator.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.success)
    }
    
    func simpleError() {
        generator.notificationOccurred(.error)
    }
    
    func complexSuccess() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        var events = [CHHapticEvent]()
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
        let event = CHHapticEvent(eventType: CHHapticEvent.EventType.hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
        events.append(event)
        do {
            let pattern = try CHHapticPattern(events: events, parameterCurves: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("失败: \(error.localizedDescription)")
        }
    }
}
