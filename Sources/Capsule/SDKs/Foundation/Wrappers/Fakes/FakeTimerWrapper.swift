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

open class FakeTimerWrapper: Fake, TimerWrapperProtocol {
    // MARK: - Captured properties
    
    public var capturedScheduledTimerSeconds: Double?
    public var capturedScheduledTimerShouldRepeat: Bool?
    public var capturedScheduledTimerOnTimerFiring: ((Timer) -> Void)?
    
    // MARK: - Stubbed properties
    
    public var stubbedScheduledTimer = Timer()
    
    // MARK: - Public properties
    
    public var shouldExecuteOnTimerFiringImmediately = false
    
    // MARK: - Init methods
    
    public override init() { }
    
    // MARK: - <TimerWrapperProtocol>
    
    public func scheduledTimer(seconds: Double,
                               shouldRepeat: Bool,
                               onTimerFiring: @escaping @Sendable (Timer) -> Void) {
        capturedScheduledTimerSeconds = seconds
        capturedScheduledTimerShouldRepeat = shouldRepeat
        capturedScheduledTimerOnTimerFiring = onTimerFiring
        
        if shouldExecuteOnTimerFiringImmediately {
            onTimerFiring(stubbedScheduledTimer)
        }
    }
}
