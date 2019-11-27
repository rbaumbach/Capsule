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
    
    // MARK: - Main Queue
    
    public var capturedMainAsyncCompletionHandler: (() -> Void)?
    
    public var capturedMainAfterSecondsInt: Int?
    public var capturedMainAfterSecondsIntCompletionHandler: (() -> Void)?
    
    public var capturedMainAfterSecondsDouble: Double?
    public var capturedMainAfterSecondsDoubleCompletionHandler: (() -> Void)?
    
    public var capturedMainAfterWorkItemWrapperSecondsInt: Int?
    public var capturedMainAfterWorkItemWrapperSecondsIntProtocol: DispatchWorkItemWrapperProtocol?
    
    public var capturedMainAfterWorkItemWrapperSecondsDouble: Double?
    public var capturedMainAfterWorkItemWrapperSecondsDoubleProtocol: DispatchWorkItemWrapperProtocol?
    
    // MARK: - Global Queue
    
    public var capturedGlobalAsyncQOS: DispatchQoS?
    public var capturedGlobalAsyncCompletionHandler: (() -> Void)?
    
    public var capturedGlobalAsyncAfterSecondsInt: Int?
    public var capturedGlobalAsyncAfterSecondsIntQOS: DispatchQoS?
    public var capturedGlobalAsyncAfterSecondsIntCompletionHandler: (() -> Void)?
    
    public var capturedGlobalAsyncAfterSecondsDouble: Double?
    public var capturedGlobalAsyncAfterSecondsDoubleQOS: DispatchQoS?
    public var capturedGlobalAsyncAfterSecondsDoubleCompletionHandler: (() -> Void)?
    
    public var capturedGlobalAsyncAfterWorkItemWrapperSecondsInt: Int?
    public var capturedGlobalAsyncAfterWorkItemWrapperSecondsIntQOS: DispatchQoS?
    public var capturedGlobalAsyncAfterWorkItemWrapperSecondsIntProtocol: DispatchWorkItemWrapperProtocol?
    
    public var capturedGlobalAsyncAfterWorkItemWrapperSecondsDouble: Double?
    public var capturedGlobalAsyncAfterWorkItemWrapperSecondsDoubleQOS: DispatchQoS?
    public var capturedGlobalAsyncAfterWorkItemWrapperSecondsDoubleProtocol: DispatchWorkItemWrapperProtocol?
    
    // MARK: - Init methods
    
    public init() { }
    
    // MARK: - <DispatcherProtocol>
    
    // MARK: - Main Queue
    
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
    
    public func mainAfter(seconds: Int, dispatchWorkItemWrapper: DispatchWorkItemWrapperProtocol) {
        capturedMainAfterWorkItemWrapperSecondsInt = seconds
        capturedMainAfterWorkItemWrapperSecondsIntProtocol = dispatchWorkItemWrapper
    }
    
    public func mainAfter(seconds: Double, dispatchWorkItemWrapper: DispatchWorkItemWrapperProtocol) {
        capturedMainAfterWorkItemWrapperSecondsDouble = seconds
        capturedMainAfterWorkItemWrapperSecondsDoubleProtocol = dispatchWorkItemWrapper
    }
    
    // MARK: - Global Queue
    
    public func globalAsync(qos: DispatchQoS, completionHandler: @escaping () -> Void) {
        capturedGlobalAsyncQOS = qos
        capturedGlobalAsyncCompletionHandler = completionHandler
    }
    
    public func globalAsyncAfter(seconds: Int, qos: DispatchQoS, completionHandler: @escaping () -> Void) {
        capturedGlobalAsyncAfterSecondsInt = seconds
        capturedGlobalAsyncAfterSecondsIntQOS = qos
        capturedGlobalAsyncAfterSecondsIntCompletionHandler = completionHandler
    }
    
    public func globalAsyncAfter(seconds: Double, qos: DispatchQoS, completionHandler: @escaping () -> Void) {
        capturedGlobalAsyncAfterSecondsDouble = seconds
        capturedGlobalAsyncAfterSecondsDoubleQOS = qos
        capturedGlobalAsyncAfterSecondsDoubleCompletionHandler = completionHandler
    }
    
    public func globalAsyncAfter(seconds: Int, qos: DispatchQoS, dispatchWorkItemWrapper: DispatchWorkItemWrapperProtocol) {
        capturedGlobalAsyncAfterWorkItemWrapperSecondsInt = seconds
        capturedGlobalAsyncAfterWorkItemWrapperSecondsIntQOS = qos
        capturedGlobalAsyncAfterWorkItemWrapperSecondsIntProtocol = dispatchWorkItemWrapper
    }
    
    public func globalAsyncAfter(seconds: Double, qos: DispatchQoS, dispatchWorkItemWrapper: DispatchWorkItemWrapperProtocol) {
        capturedGlobalAsyncAfterWorkItemWrapperSecondsDouble = seconds
        capturedGlobalAsyncAfterWorkItemWrapperSecondsDoubleQOS = qos
        capturedGlobalAsyncAfterWorkItemWrapperSecondsDoubleProtocol = dispatchWorkItemWrapper
    }
}
