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

public class FakeDispatchWorkItemWrapperBuilder: DispatchWorkItemWrapperBuilderProtocol {
    // MARK: - Captured properties
    
    public var capturedBuildQOS: DispatchQoS?
    public var capturedBuildWork: (() -> Void)?
    
    // MARK: - Stubbed properties
        
    public var shouldUseDispatchWorkItemWrappersArray = false
    public var currentDispatchWorkItemWrapperIndex = 0
    
    public var stubbedDispatchWorkItemWrappersArray: [FakeDispatchWorkItemWrapper] = {
        let fakeDispatchWorkItemWrappers = Array(0...4).map { number -> FakeDispatchWorkItemWrapper in
            let fakeDispatchWorkItemWrapper = FakeDispatchWorkItemWrapper()
            fakeDispatchWorkItemWrapper.id = number

            return fakeDispatchWorkItemWrapper
        }
        
        return fakeDispatchWorkItemWrappers
    }()
    
    // MARK: - Init methods
    
    public init() { }
    
    // MARK: - <DispatchWorkItemBuilderProtocol>
    
    public func build(qos: DispatchQoS = .unspecified, work: @escaping () -> Void) -> DispatchWorkItemWrapperProtocol {
        capturedBuildQOS = qos
        capturedBuildWork = work
        
        if !shouldUseDispatchWorkItemWrappersArray {
            return stubbedDispatchWorkItemWrappersArray[0]
        }
        
        let fakeDispatchWorkItemWrapper = stubbedDispatchWorkItemWrappersArray[currentDispatchWorkItemWrapperIndex]
        
        // Note: The index just wraps around back to the beginning
        
        let nextIndex = currentDispatchWorkItemWrapperIndex + 1
        currentDispatchWorkItemWrapperIndex = nextIndex % stubbedDispatchWorkItemWrappersArray.count
        
        return fakeDispatchWorkItemWrapper
    }
}
