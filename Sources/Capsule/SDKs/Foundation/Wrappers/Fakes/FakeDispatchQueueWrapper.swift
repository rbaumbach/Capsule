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

public class FakeDispatchQueueWrapper: DispatchQueueWrapperProtocol {
    // MARK: - Captured properties
    
    // MARK: - Main Queue
    
    public var capturedMainAsyncExecutionBlock: (() -> Void)?
    
    public var capturedMainAfterSecondsInt: Int?
    public var capturedMainAfterSecondsIntExecutionBlock: (() -> Void)?
    
    public var capturedMainAfterSecondsDouble: Double?
    public var capturedMainAfterSecondsDoubleExecutionBlock: (() -> Void)?
    
    public var capturedMainAfterWorkItemWrapperSecondsInt: Int?
    public var capturedMainAfterWorkItemWrapperSecondsIntProtocol: DispatchWorkItemWrapperProtocol?
    
    public var capturedMainAfterWorkItemWrapperSecondsDouble: Double?
    public var capturedMainAfterWorkItemWrapperSecondsDoubleProtocol: DispatchWorkItemWrapperProtocol?
    
    // MARK: - Global Queue
    
    public var capturedGlobalAsyncQOS: DispatchQoS?
    public var capturedGlobalAsyncExecutionBlock: (() -> Void)?
    
    public var capturedGlobalAsyncAfterSecondsInt: Int?
    public var capturedGlobalAsyncAfterSecondsIntQOS: DispatchQoS?
    public var capturedGlobalAsyncAfterSecondsIntExecutionBlock: (() -> Void)?
    
    public var capturedGlobalAsyncAfterSecondsDouble: Double?
    public var capturedGlobalAsyncAfterSecondsDoubleQOS: DispatchQoS?
    public var capturedGlobalAsyncAfterSecondsDoubleExecutionBlock: (() -> Void)?
    
    public var capturedGlobalAsyncAfterWorkItemWrapperSecondsInt: Int?
    public var capturedGlobalAsyncAfterWorkItemWrapperSecondsIntQOS: DispatchQoS?
    public var capturedGlobalAsyncAfterWorkItemWrapperSecondsIntProtocol: DispatchWorkItemWrapperProtocol?
    
    public var capturedGlobalAsyncAfterWorkItemWrapperSecondsDouble: Double?
    public var capturedGlobalAsyncAfterWorkItemWrapperSecondsDoubleQOS: DispatchQoS?
    public var capturedGlobalAsyncAfterWorkItemWrapperSecondsDoubleProtocol: DispatchWorkItemWrapperProtocol?
    
    // MARK: - Custom Queue
    
    public var capturedCustomAsyncFlags: DispatchWorkItemFlags?
    public var capturedCustomAsyncExecutionBlock: (() -> Void)?
    
    public var capturedCustomSyncFlags: DispatchWorkItemFlags?
    public var capturedCustomSyncExecutionBlock: (() -> Void)?
    
    // MARK: - Public properties
    
    public var shouldExecuteImmediately = false
    
    // MARK: - Init methods
    
    public init() { }
    
    // MARK: - <DispatcherProtocol>

    // MARK: - Main Queue
    
    public func mainAsync(execute: @escaping () -> Void) {
        capturedMainAsyncExecutionBlock = execute
        
        if shouldExecuteImmediately {
            execute()
        }
    }
    
    public func mainAfter(seconds: Int, execute: @escaping () -> Void) {
        capturedMainAfterSecondsInt = seconds
        capturedMainAfterSecondsIntExecutionBlock = execute
        
        if shouldExecuteImmediately {
            execute()
        }
    }
    
    public func mainAfter(seconds: Double, execute: @escaping () -> Void) {
        capturedMainAfterSecondsDouble = seconds
        capturedMainAfterSecondsDoubleExecutionBlock = execute
        
        if shouldExecuteImmediately {
            execute()
        }
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
    
    public func globalAsync(qos: DispatchQoS, execute: @escaping () -> Void) {
        capturedGlobalAsyncQOS = qos
        capturedGlobalAsyncExecutionBlock = execute
        
        if shouldExecuteImmediately {
            execute()
        }
    }
    
    public func globalAsyncAfter(seconds: Int, qos: DispatchQoS, execute: @escaping () -> Void) {
        capturedGlobalAsyncAfterSecondsInt = seconds
        capturedGlobalAsyncAfterSecondsIntQOS = qos
        capturedGlobalAsyncAfterSecondsIntExecutionBlock = execute
        
        if shouldExecuteImmediately {
            execute()
        }
    }
    
    public func globalAsyncAfter(seconds: Double, qos: DispatchQoS, execute: @escaping () -> Void) {
        capturedGlobalAsyncAfterSecondsDouble = seconds
        capturedGlobalAsyncAfterSecondsDoubleQOS = qos
        capturedGlobalAsyncAfterSecondsDoubleExecutionBlock = execute
        
        if shouldExecuteImmediately {
            execute()
        }
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
    
    // MARK: - Custom Queue
    
    public func customAsync(flags: DispatchWorkItemFlags, execute: @escaping () -> Void) {
        capturedCustomAsyncFlags = flags
        capturedCustomAsyncExecutionBlock = execute
        
        if shouldExecuteImmediately {
            execute()
        }
    }
    
    public func customSync(flags: DispatchWorkItemFlags, execute: @escaping () -> Void) {
        capturedCustomSyncFlags = flags
        capturedCustomSyncExecutionBlock = execute
        
        if shouldExecuteImmediately {
            execute()
        }
    }
}
