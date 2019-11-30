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

public class FakeJSONCodableWrapper: JSONCodableWrapperProtocol {
    // MARK: - Captured properties
    
    public var capturedOutputFormat: JSONCodableWrapper.OutputFormat?
    public var capturedDateFormat: JSONCodableWrapper.DateFormat?
    
    public var capturedEncodeValue: Any?
        
    public var capturedDecodeTypeAsString: String?
    public var capturedDecodeData: Data?
        
    // MARK: - Stubbed properties
    
    public var stubbedOutputFormat = JSONCodableWrapper.OutputFormat.default
    public var stubbedDateEncodingStrategy = JSONCodableWrapper.DateFormat.default
    
    public var stubbedEncodeData = "tacos".data(using: .utf8)!
    
    public var stubbedDecodedData: Any?
    
    // MARK: - Exceptions
    
    public var shouldThrowEncodeException = false
    public var shouldThrowDecodeException = false
        
    // MARK: - Init methods
    
    public init() { }
    
    // MARK: - <JSONCodableWrapperProtocol>
    
    public var outputFormat: JSONCodableWrapper.OutputFormat {
        get {
            return stubbedOutputFormat
        }
        
        set(newOutputFormat) {
            capturedOutputFormat = newOutputFormat
        }
    }
    
    public var dateFormat: JSONCodableWrapper.DateFormat {
        get {
            return stubbedDateEncodingStrategy
        }
        
        set(newDateFormat) {
            capturedDateFormat = newDateFormat
        }
    }

    public func encode<T: Codable>(_ value: T) throws -> Data {
        capturedEncodeValue = value
        
        if shouldThrowEncodeException {
            throw FakeGenericError.whoCares
        }
        
        return stubbedEncodeData
    }
    
    public func decode<T: Codable>(_ type: T.Type, from data: Data) throws -> T {
        guard let stubbedDecodedData = stubbedDecodedData as? T else {
            preconditionFailure("FakeJSONCodableWrapper.stubbedDecodedData property has not been set")
        }
        
        capturedDecodeTypeAsString = "\(T.Type.self)"
        capturedDecodeData = data

        if shouldThrowDecodeException {
            throw FakeGenericError.whoCares
        }
        
        return stubbedDecodedData
    }
}
