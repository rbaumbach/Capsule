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

public class FakeJSONEncoder: JSONEncoderProtocol {
    // MARK: - Captured properties
    
    public var capturedOutputFormatting: JSONEncoder.OutputFormatting?
    public var capturedDateEncodingStrategy: JSONEncoder.DateEncodingStrategy?
    public var capturedEncodeValue: Any?
        
    // MARK: - Stubbed properties
    
    public var stubbedOutputFormatting = JSONEncoder.OutputFormatting.prettyPrinted
    public var stubbedDateEncodingStrategy = JSONEncoder.DateEncodingStrategy.iso8601
    
    public var stubbedEncodeData = "tacos".data(using: .utf8)!
    
    // MARK: - Init methods
    
    public init() { }
        
    // MARK: - <JSONEncoderProtocol>
    
    public var outputFormatting: JSONEncoder.OutputFormatting {
        get {
            return stubbedOutputFormatting
        }
        
        set(newOutputFormatting) {
            capturedOutputFormatting = newOutputFormatting
        }
    }
    
    public var dateEncodingStrategy: JSONEncoder.DateEncodingStrategy {
        get {
            return stubbedDateEncodingStrategy
        }
        
        set(newDateEncodingStrategy) {
            capturedDateEncodingStrategy = newDateEncodingStrategy
        }
    }
    
    public func encode<T>(_ value: T) throws -> Data where T: Encodable {
        capturedEncodeValue = value
        
        return stubbedEncodeData
    }
}
