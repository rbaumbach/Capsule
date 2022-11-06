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

public class FakeJSONDecoder<T>: JSONDecoderProtocol {
    // MARK: - Captured properties
    
    public var capturedDateDecodingStrategy: JSONDecoder.DateDecodingStrategy?
    
    public var capturedDecodeTypeAsString: String?
    public var capturedDecodeData: Data?
        
    // MARK: - Stubbed properties
    
    public var stubbedDateDecodingStrategy = JSONDecoder.DateDecodingStrategy.iso8601
    public var stubbedDecodedJSON: T?
    
    // MARK: - Exceptions
    
    public var shouldThrowDecodeException = false
    
    // MARK: - Init methods
    
    public init() { }
        
    // MARK: - <JSONDecoderProtocol>
    
    public var dateDecodingStrategy: JSONDecoder.DateDecodingStrategy {
        get {
            return stubbedDateDecodingStrategy
        }
        
        set(newDateDecodingStrategy) {
            capturedDateDecodingStrategy = newDateDecodingStrategy
        }
    }
    
    public func decode<T>(_ type: T.Type, from data: Data) throws -> T where T: Decodable {
        capturedDecodeTypeAsString = "\(T.Type.self)"
        capturedDecodeData = data
        
        if shouldThrowDecodeException {
            throw FakeGenericError.whoCares
        }
        
        if let stubbedDecodedJSON = stubbedDecodedJSON {
            return stubbedDecodedJSON as! T
        } else {
            preconditionFailure("FakeJSONDecoder.stubbedDecodedJSON property has not been set")
        }
    }
}
