//
//  ResumableTimer.swift
//  MusicCodebase
//
//  Created by Андрей Ясюкевич on 7.09.22.
//

import Foundation

public class ResumableTimer: NSObject {

    private var timer: Timer? = Timer()
    private var callback: () -> Void

    private var startTime: TimeInterval?
    private var elapsedTime: TimeInterval?

    // MARK: Init
    init(interval: Double, isRepeatable: Bool, callback: @escaping () -> Void) {
        self.interval = interval
        self.isRepeatable = isRepeatable
        self.callback = callback
    }

    // MARK: API
    var isRepeatable: Bool = false
    var interval: Double = 0.0

    func isPaused() -> Bool {
        guard let timer = timer else { return false }
        return !timer.isValid
    }

    func start() {
        runTimer(interval: interval)
    }

    public func pause() {
        elapsedTime = Date.timeIntervalSinceReferenceDate - (startTime ?? 0.0)
        timer?.invalidate()
    }

    public func resume() {
        interval -= elapsedTime ?? 0.0
        runTimer(interval: interval)
    }

    func invalidate() {
        timer?.invalidate()
    }

    func reset() {
        startTime = Date.timeIntervalSinceReferenceDate
        runTimer(interval: interval)
    }

    // MARK: Private
    private func runTimer(interval: Double) {
        startTime = Date.timeIntervalSinceReferenceDate

        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: isRepeatable) { timer in
            self.callback()
        }
    }
}
