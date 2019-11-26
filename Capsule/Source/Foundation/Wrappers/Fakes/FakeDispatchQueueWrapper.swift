//MIT License
//
//Copyright (c) 2019 Ryan Baumbach <github@ryan.codes>
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

public class FakeDispatchQueueWrapper: DispatchQueueWrapperProtocol {
    // MARK: - Captured properties
    
    public var capturedMainAsyncCompletionHandler: (() -> Void)?
    
    public var capturedMainAfterSecondsInt: Int?
    public var capturedMainAfterSecondsIntCompletionHandler: (() -> Void)?
    
    public var capturedMainAfterSecondsDouble: Double?
    public var capturedMainAfterSecondsDoubleCompletionHandler: (() -> Void)?
    
    public var capturedAsyncQOS: DispatchQoS?
    public var capturedAsyncQOSCompletionHandler: (() -> Void)?
    
    public var capturedMainAfterWorkItemWrapperSecondsInt: Int?
    public var capturedMainAfterWorkItemWrapperProtocol: DispatchWorkItemWrapperProtocol?
    
    public var capturedAsyncAfterSecondsDouble: Double?
    public var capturedAsyncAfterQOS: DispatchQoS?
    public var capturedAsyncAfterDispatchWorkItemWrapper: DispatchWorkItemWrapperProtocol?
    
    // MARK: - Init methods
    
    public init() { }
    
    // MARK: - <DispatcherProtocol>
    
    public func mainAsync(completionHandler: @escaping () -> Void) {
        capturedMainAsyncCompletionHandler = completionHandler
    }
    
    public func mainAfter(seconds: Int, completionHandler: @escaping () -> Void) {
        capturedMainAfterSecondsInt = seconds
        capturedMainAfterSecondsIntCompletionHandler = completionHandler
    }
    
    public func mainAfter(seconds: Double, completionHandler: @escaping () -> Void) {
        capturedMainAfterSecondsDouble = seconds
        capturedMainAfterSecondsDoubleCompletionHandler = completionHandler
    }
    
    public func async(qos: DispatchQoS, completionHandler: @escaping () -> Void) {
        capturedAsyncQOS = qos
        capturedAsyncQOSCompletionHandler = completionHandler
    }
    
    public func mainAfter(seconds: Int, dispatchWorkItemWrapper: DispatchWorkItemWrapperProtocol) {
        capturedMainAfterWorkItemWrapperSecondsInt = seconds
        capturedMainAfterWorkItemWrapperProtocol = dispatchWorkItemWrapper
    }
    
    public func asyncAfter(seconds: Double, qos: DispatchQoS, dispatchWorkItemWrapper: DispatchWorkItemWrapperProtocol) {
        capturedAsyncAfterSecondsDouble = seconds
        capturedAsyncAfterQOS = qos
        capturedAsyncAfterDispatchWorkItemWrapper = dispatchWorkItemWrapper
    }
}
