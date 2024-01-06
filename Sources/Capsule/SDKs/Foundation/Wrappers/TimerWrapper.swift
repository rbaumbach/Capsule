//MIT License
//
//Copyright (c) 2020-2024 Ryan Baumbach <github@ryan.codes>
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in all
//copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//SOFTWARE.

import Foundation

public protocol TimerWrapperProtocol {
    func scheduledTimer(seconds: Double, shouldRepeat: Bool, onTimerFiring: @escaping (Timer) -> Void)
}

public class TimerWrapper: TimerWrapperProtocol {
    // MARK: - Private properties
    
    private var timer: Timer?
    
    private var onTimerFiring: ((Timer) -> Void)?
    
    // MARK: - Init methods
    
    public init() { }
    
    // MARK: - Public methods
    
    public func scheduledTimer(seconds: Double, shouldRepeat: Bool, onTimerFiring: @escaping (Timer) -> Void) {
        self.onTimerFiring = onTimerFiring
        
        timer = Timer.scheduledTimer(timeInterval: seconds,
                                     target: self,
                                     selector: #selector(timerDidFire(sender:)),
                                     userInfo: nil,
                                     repeats: shouldRepeat)
    }
    
    public func invalidate() {
        timer?.invalidate()
    }
    
    // MARK: - Private methods
    
    @objc
    private func timerDidFire(sender: Timer) {
        onTimerFiring?(sender)
    }
}
