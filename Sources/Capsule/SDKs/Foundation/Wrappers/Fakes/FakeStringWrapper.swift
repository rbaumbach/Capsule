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

open class FakeStringWrapper: Fake, StringWrapperProtocol {
    // MARK: - Captured properties
    
    public var capturedLoadStringPath: String?
    
    public var capturedLoadDataPath: String?
    public var capturedLoadDataEncoding: String.Encoding?

    // MARK: - Stubbed properties
    
    public var stubbedLoadString = "Loaded"
    
    public var stubbedLoadData = "Loaded".data(using: .utf8)
    
    // MARK: - Public properties
    
    public var shouldThrowErrowLoadingString = false
    
    public var shouldThrowErrorLoadingData = false
    
    // MARK: - Init methods
    
    public override init() { }
    
    // MARK: - <StringWrapperaProtocol>
    
    public func loadString(contentsOfFile path: String) throws -> String {
        capturedLoadStringPath = path
        
        if shouldThrowErrowLoadingString {
            throw FakeGenericError.whoCares
        }
        
        return stubbedLoadString
    }
    
    public func loadData(contentsOfFile path: String, 
                         encoding: String.Encoding) throws -> Data? {
        capturedLoadDataPath = path
        capturedLoadDataEncoding = encoding
        
        if shouldThrowErrorLoadingData {
            throw FakeGenericError.whoCares
        }
        
        return stubbedLoadData
    }
}
