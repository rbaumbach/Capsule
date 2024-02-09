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

open class FakeURLSessionDelegate: NSObject, URLSessionDelegate {
    // MARK: - Captured properties
    
    public var capturedURLSession: URLSession?
    public var capturedURLSessionDidBecomeInvalidError: Error?
    
    public var capturedURLSessionWithCompletionHandlerURLSession: URLSession?
    public var capturedURLSessionWithCompletionHandlerChallenge: URLAuthenticationChallenge?
    public var capturedURLSessionWithCompletionHandlerCompletionHandler: ((URLSession.AuthChallengeDisposition, URLCredential?) -> Void)?
    
    public var capturedURLSessionDidFinishEventsBackgoundURLSession: URLSession?
    
    // MARK: - Stubbed properties
    
    public var stubbedAuthChallengeDisposition: URLSession.AuthChallengeDisposition = .cancelAuthenticationChallenge
    public var stubbedURLCredential = URLCredential()
    
    // MARK: - Public methods
    
    public var shouldExecuteCompletionHandlersImmediately = false
    
    // MARK: - <URLSessionDelegate>
    
    public func urlSession(_ session: URLSession,
                           didBecomeInvalidWithError error: Error?) {
        capturedURLSession = session
        capturedURLSessionDidBecomeInvalidError = error
    }

    public func urlSession(_ session: URLSession,
                           didReceive challenge: URLAuthenticationChallenge,
                           completionHandler: @escaping @Sendable (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        capturedURLSessionWithCompletionHandlerURLSession = session
        capturedURLSessionWithCompletionHandlerChallenge = challenge
        capturedURLSessionWithCompletionHandlerCompletionHandler = completionHandler
        
        if shouldExecuteCompletionHandlersImmediately {
            completionHandler(stubbedAuthChallengeDisposition, stubbedURLCredential)
        }
    }

    public func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
        capturedURLSessionDidFinishEventsBackgoundURLSession = session
    }
}
