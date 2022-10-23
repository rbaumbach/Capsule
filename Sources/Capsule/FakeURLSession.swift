//MIT License
//
//Copyright (c) 2020-2022 Ryan Baumbach <github@ryan.codes>
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
    
    public var capturedInitConfiguration: URLSessionConfiguration
    
    public var capturedURL: URL?
    public var capturedCompletionHandler: ((Data?, URLResponse?, Error?) -> Void)?
    
    // MARK: - Stubbed properties
            
    public var stubbedDataTask = URLSession.shared.dataTask(with: URL(string: "https://8jnYY7-nope-not-working-jj009.codes")!)
    
    // MARK: - <URLSessionProtocol>
    
    public required init(configuration: URLSessionConfiguration) {
        capturedInitConfiguration = configuration
    }
    
    public func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        capturedURL = url
        capturedCompletionHandler = completionHandler
        
        return stubbedDataTask
    }
}
