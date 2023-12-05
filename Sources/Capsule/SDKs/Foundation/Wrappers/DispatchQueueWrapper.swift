//MIT License
//
//Copyright (c) 2020-2023 Ryan Baumbach <github@ryan.codes>
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
    func mainAsync(execute: @escaping () -> Void)
    func mainAfter(seconds: Int, execute: @escaping () -> Void)
    func mainAfter(seconds: Double, execute: @escaping () -> Void)
    func mainAfter(seconds: Int, dispatchWorkItemWrapper: DispatchWorkItemWrapperProtocol)
    func mainAfter(seconds: Double, dispatchWorkItemWrapper: DispatchWorkItemWrapperProtocol)
    
    func globalAsync(qos: DispatchQoS, execute: @escaping () -> Void)
    func globalAsyncAfter(seconds: Int, qos: DispatchQoS, execute: @escaping () -> Void)
    func globalAsyncAfter(seconds: Double, qos: DispatchQoS, execute: @escaping () -> Void)
    func globalAsyncAfter(seconds: Int, qos: DispatchQoS, dispatchWorkItemWrapper: DispatchWorkItemWrapperProtocol)
    func globalAsyncAfter(seconds: Double, qos: DispatchQoS, dispatchWorkItemWrapper: DispatchWorkItemWrapperProtocol)
    
    func customAsync(flags: DispatchWorkItemFlags, execute: @escaping () -> Void)
    func customSync(flags: DispatchWorkItemFlags, execute: @escaping () -> Void)
}

public class DispatchQueueWrapper: DispatchQueueWrapperProtocol {
    // MARK: - Private properties
    
    private let mainDispatchQueue = DispatchQueue.main
    private let customQueue: DispatchQueue
    
    // MARK: - Init methods
    
    public convenience init() {
        self.init(label: "Default", attributes: [])
    }
    
    public init(label: String, attributes: DispatchQueue.Attributes) {
        customQueue = DispatchQueue(label: label, attributes: attributes)
    }
    
    // MARK: - Public methods
    
    // MARK: - Main Queue
    
    public func mainAsync(execute: @escaping () -> Void) {
        mainDispatchQueue.async(execute: execute)
    }
    
    public func mainAfter(seconds: Int, execute: @escaping () -> Void) {
        mainDispatchQueue.asyncAfter(deadline: .now() + Double(seconds), execute: execute)
    }
    
    public func mainAfter(seconds: Double, execute: @escaping () -> Void) {
        mainDispatchQueue.asyncAfter(deadline: .now() + seconds, execute: execute)
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
    
    public func globalAsync(qos: DispatchQoS, execute: @escaping () -> Void) {
        DispatchQueue.global(qos: qos.qosClass).async(execute: execute)
    }
    
    public func globalAsyncAfter(seconds: Int, qos: DispatchQoS, execute: @escaping () -> Void) {
        DispatchQueue.global(qos: qos.qosClass).asyncAfter(deadline: .now() + Double(seconds), execute: execute)
    }
    
    public func globalAsyncAfter(seconds: Double, qos: DispatchQoS, execute: @escaping () -> Void) {
        DispatchQueue.global(qos: qos.qosClass).asyncAfter(deadline: .now() + seconds, execute: execute)
    }
    
    public func globalAsyncAfter(seconds: Int, qos: DispatchQoS, dispatchWorkItemWrapper: DispatchWorkItemWrapperProtocol) {
        let dispatchWorkItem = dispatchWorkItemWrapper.dispatchWorkItem
        
        DispatchQueue.global(qos: qos.qosClass).asyncAfter(deadline: .now() + Double(seconds), execute: dispatchWorkItem)
    }
    
    public func globalAsyncAfter(seconds: Double, qos: DispatchQoS, dispatchWorkItemWrapper: DispatchWorkItemWrapperProtocol) {
        let dispatchWorkItem = dispatchWorkItemWrapper.dispatchWorkItem
        
        DispatchQueue.global(qos: qos.qosClass).asyncAfter(deadline: .now() + seconds, execute: dispatchWorkItem)
    }
    
    // MARK: - Custom Queue
    
    public func customAsync(flags: DispatchWorkItemFlags, execute: @escaping () -> Void) {
        customQueue.async(flags: flags, execute: execute)
    }
    
    public func customSync(flags: DispatchWorkItemFlags, execute: @escaping () -> Void) {
        customQueue.sync(flags: flags, execute: execute)
    }
}
