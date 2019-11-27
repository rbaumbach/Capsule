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

public protocol DispatchQueueWrapperProtocol {
    func mainAsync(completionHandler: @escaping () -> Void)
    func mainAfter(seconds: Int, completionHandler: @escaping () -> Void)
    func mainAfter(seconds: Double, completionHandler: @escaping () -> Void)
    func mainAfter(seconds: Int, dispatchWorkItemWrapper: DispatchWorkItemWrapperProtocol)
    func mainAfter(seconds: Double, dispatchWorkItemWrapper: DispatchWorkItemWrapperProtocol)
    
    func globalAsync(qos: DispatchQoS, completionHandler: @escaping () -> Void)
    func globalAsyncAfter(seconds: Int, qos: DispatchQoS, completionHandler: @escaping () -> Void)
    func globalAsyncAfter(seconds: Double, qos: DispatchQoS, completionHandler: @escaping () -> Void)
    func globalAsyncAfter(seconds: Int, qos: DispatchQoS, dispatchWorkItemWrapper: DispatchWorkItemWrapperProtocol)
    func globalAsyncAfter(seconds: Double, qos: DispatchQoS, dispatchWorkItemWrapper: DispatchWorkItemWrapperProtocol)
}

public class DispatchQueueWrapper: DispatchQueueWrapperProtocol {
    // MARK: - Private properties
    
    private let mainDispatchQueue = DispatchQueue.main
    
    // MARK: - Init methods
    
    public init() { }
    
    // MARK: - Public methods
    
    // MARK: - Main Queue
    
    public func mainAsync(completionHandler: @escaping () -> Void) {
        mainDispatchQueue.async(execute: completionHandler)
    }
    
    public func mainAfter(seconds: Int, completionHandler: @escaping () -> Void) {
        mainDispatchQueue.asyncAfter(deadline: .now() + Double(seconds), execute: completionHandler)
    }
    
    public func mainAfter(seconds: Double, completionHandler: @escaping () -> Void) {
        mainDispatchQueue.asyncAfter(deadline: .now() + seconds, execute: completionHandler)
    }
    
    public func mainAfter(seconds: Int, dispatchWorkItemWrapper: DispatchWorkItemWrapperProtocol) {
        let dispatchWorkItem = dispatchWorkItemWrapper.dispatchWorkItem
        
        mainDispatchQueue.asyncAfter(deadline: .now() + Double(seconds), execute: dispatchWorkItem)
    }
    
    public func mainAfter(seconds: Double, dispatchWorkItemWrapper: DispatchWorkItemWrapperProtocol) {
        let dispatchWorkItem = dispatchWorkItemWrapper.dispatchWorkItem
        
        mainDispatchQueue.asyncAfter(deadline: .now() + seconds, execute: dispatchWorkItem)
    }
    
    // MARK: - Global Queue
    
    public func globalAsync(qos: DispatchQoS, completionHandler: @escaping () -> Void) {
        DispatchQueue.global(qos: qos.qosClass).async(execute: completionHandler)
    }
    
    public func globalAsyncAfter(seconds: Int, qos: DispatchQoS, completionHandler: @escaping () -> Void) {
        DispatchQueue.global(qos: qos.qosClass).asyncAfter(deadline: .now() + Double(seconds), execute: completionHandler)
    }
    
    public func globalAsyncAfter(seconds: Double, qos: DispatchQoS, completionHandler: @escaping () -> Void) {
        DispatchQueue.global(qos: qos.qosClass).asyncAfter(deadline: .now() + seconds, execute: completionHandler)
    }
    
    public func globalAsyncAfter(seconds: Int, qos: DispatchQoS, dispatchWorkItemWrapper: DispatchWorkItemWrapperProtocol) {
        let dispatchWorkItem = dispatchWorkItemWrapper.dispatchWorkItem
        
        DispatchQueue.global(qos: qos.qosClass).asyncAfter(deadline: .now() + Double(seconds), execute: dispatchWorkItem)
    }
    
    public func globalAsyncAfter(seconds: Double, qos: DispatchQoS, dispatchWorkItemWrapper: DispatchWorkItemWrapperProtocol) {
        let dispatchWorkItem = dispatchWorkItemWrapper.dispatchWorkItem
        
        DispatchQueue.global(qos: qos.qosClass).asyncAfter(deadline: .now() + seconds, execute: dispatchWorkItem)
    }
}
