//
//  HapticModels.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/30.
//

import SwiftUI
import CoreHaptics
import AVFoundation

struct Haptic {
    static var shared = Haptic()
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
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.success)
        buttonAudioPlayer(sound: "clicked", type: "wav")
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
            print("Failed to play: \(error.localizedDescription)")
        }
        buttonAudioPlayer(sound: "clicked", type: "wav")
    }
}

var audioPlayer: AVAudioPlayer?

func buttonAudioPlayer(sound: String, type: String) {
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
        } catch {
            print("error in loading sound resourses")
        }
    }
}