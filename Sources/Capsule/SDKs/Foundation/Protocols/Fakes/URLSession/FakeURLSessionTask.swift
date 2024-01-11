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

open class FakeURLSessionTask: URLSessionTaskProtocol, Equatable {
    // MARK: - Captured properties
    
    public var didCallResume = false
    public var didCallCancel = false
    public var didCallSuspend = false
    
    public var capturedPriority: Float?
    
    public var capturedTaskDescription: String?
    
    // MARK: - Stubbed properties
    
    public var stubbedState: URLSessionTask.State = .running
    
    public var stubbedProgress: Progress = Progress()
    
    public var stubbedPriority: Float = 0.99
    
    public var stubbedCurrentURLRequest = URLRequest(url: URL(string: "https://bert-99-jv9.sss.party")!)
    public var stubbedOriginalURLRequest = URLRequest(url: URL(string: "https://ernie-99-jv9.sss.party")!)
    
    public var stubbedResponse: URLResponse? = URLResponse()
    
    public var stubbedTaskDescription = "task-#99"
    public var stubbedTaskIdentifier = 99
    
    public var stubbedError: Error? = FakeGenericError.whoCares
    
    // MARK: - Public properties
    
    // Note: This is an easy way to conform to Equatable
    
    public let uniqueID = UUID().uuidString
    
    // MARK: - Init methods
    
    public init() { }
    
    // MARK: - <URLSessionTaskProtocol>
    
    public var state: URLSessionTask.State {
        return stubbedState
    }
    
    public var progress: Progress {
        return stubbedProgress
    }

    public var priority: Float {
        get {
            return stubbedPriority
        }
        
        set {
            capturedPriority = newValue
        }
    }
    
    public var currentRequest: URLRequest? {
        return stubbedCurrentURLRequest
    }
    
    public var originalRequest: URLRequest? {
        return stubbedOriginalURLRequest
    }
    
    public var response: URLResponse? {
        return stubbedResponse
    }
    
    public var taskDescription: String? {
        get {
            return stubbedTaskDescription
        }
        
        set {
            capturedTaskDescription = newValue
        }
    }
    
    public var taskIdentifier: Int {
        return stubbedTaskIdentifier
    }
    
    public var error: Error? {
        return stubbedError
    }
    
    public func resume() {
        didCallResume = true
    }
    
    public func cancel() {
        didCallCancel = true
    }
    
    public func suspend() {
        didCallSuspend = true
    }
    
    // MARK: - <Equatable>
    
    public static func == (lhs: FakeURLSessionTask, rhs: FakeURLSessionTask) -> Bool {
        return lhs.uniqueID == rhs.uniqueID
    }
}
