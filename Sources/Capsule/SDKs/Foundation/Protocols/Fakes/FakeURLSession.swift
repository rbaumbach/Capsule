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

public class FakeURLSession: URLSessionProtocol {
    // MARK: - Captured properties
    
    public var capturedInitConfiguration: URLSessionConfiguration?
    
    public var capturedDataTaskURL: URL?
    public var capturedDataTaskCompletionHandler: ((Data?, URLResponse?, Error?) -> Void)?
    
    public var capturedDataTaskURLRequest: URLRequest?
    public var capturedDataTaskURLRequestCompletionHandler: ((Data?, URLResponse?, Error?) -> Void)?
    
    // MARK: - Stubbed properties
    
    // Note: Unfortunately there isn't away to "init()" an instance of a URLSessionDataTask or it's parent
    // URLSessionTask without creating a deprecation warning. Unfortunately using URLSession.shared.dataTask()
    // does some real networking even if the URL is fake as shown below.
            
    public var stubbedDataTask = URLSession.shared.dataTask(with: URL(string: "https://8jnYY7-nope-not-working-jj009.codes")!)
    public var stubbedDataTaskData: Data? = "simon".data(using: .utf8)
    public var stubbedDataTaskURLResponse: URLResponse? = URLResponse()
    public var stubbedDataTaskURLError: Error? = FakeGenericError.whoCares
    
    public var stubbedDataTaskWithURLRequest = FakeURLSessionDataTask()
    public var stubbedDataTaskWithURLRequestData: Data? = "simon".data(using: .utf8)
    public var stubbedDataTaskWithURLRequestURLResponse: URLResponse? = URLResponse()
    public var stubbedDataTaskWithURLRequestURLError: Error? = FakeGenericError.whoCares
    
    // MARK: - Public properties
    
    public var shouldExecuteCompletionHandlersImmediately = false
    
    // MARK: - Init methods
    
    public init() { }
    
    // MARK: - <URLSessionProtocol>
    
    public required init(configuration: URLSessionConfiguration) {
        capturedInitConfiguration = configuration
    }
    
#if swift(>=5.5)
    public func dataTask(with url: URL,
                         completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        capturedDataTaskURL = url
        capturedDataTaskCompletionHandler = completionHandler
        
        if shouldExecuteCompletionHandlersImmediately {
            completionHandler(stubbedDataTaskData, stubbedDataTaskURLResponse, stubbedDataTaskURLError)
        }
        
        return stubbedDataTask
    }
    
    public func dataTask(with request: URLRequest,
                         completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        capturedDataTaskURLRequest = request
        capturedDataTaskURLRequestCompletionHandler = completionHandler
        
        if shouldExecuteCompletionHandlersImmediately {
            completionHandler(stubbedDataTaskWithURLRequestData, stubbedDataTaskWithURLRequestURLResponse, stubbedDataTaskWithURLRequestURLError)
        }
        
        return stubbedDataTaskWithURLRequest
    }
#else
    public func dataTask(with url: URL,
                         completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        capturedURL = url
        capturedCompletionHandler = completionHandler
        
        if shouldExecuteCompletionHandlersImmediately {
            completionHandler(stubbedDataTaskData, stubbedDataTaskURLResponse, stubbedDataTaskURLError)
        }
        
        return stubbedDataTask
    }
    
    public func dataTask(with request: URLRequest,
                         completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        capturedDataTaskURLRequest = request
        capturedDataTaskURLRequestCompletionHandler = completionHandler
        
        if shouldExecuteCompletionHandlersImmediately {
            completionHandler(stubbedDataTaskWithURLRequestData, stubbedDataTaskWithURLRequestURLResponse, stubbedDataTaskWithURLRequestURLError)
        }
        
        return stubbedDataTaskWithURLRequest
    }
#endif
}
