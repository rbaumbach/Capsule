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

// Note: This is an easier way to package both JSONEncoder and JSONDecoder
// functionality into one convienece class.  Use the JSONEncoder and JSONDecoder
// protocol extensions if you need specific ligher functionality instead.

public protocol JSONCodableWrapperProtocol {
    var outputFormat: JSONCodableWrapper.OutputFormat { get set }
    var dateFormat: JSONCodableWrapper.DateFormat { get set }
    
    func encode<T: Codable>(_ value: T) throws -> Data
    func decode<T: Codable>(_ type: T.Type, from data: Data) throws -> T
}

public class JSONCodableWrapper: JSONCodableWrapperProtocol {
    // MARK: - Public enums
    
    public enum OutputFormat {
        case `default`
        case pretty
    }
    
    public enum DateFormat {
        case `default`
        case iso8601
    }
    
    // MARK: - Private properties
    
    private var jsonEncoder = JSONEncoder()
    private var jsonDecoder = JSONDecoder()
    
    // MARK: - Public properties
    
    public var outputFormat: OutputFormat {
        get {
            return OutputFormat(rawValue: jsonEncoder.outputFormatting)!
        }
        
        set(newOutputFormatting) {
            jsonEncoder.outputFormatting = newOutputFormatting.rawValue
        }
    }
    
    public var dateFormat: DateFormat {
        get {
            return DateFormat(rawValue: (jsonEncoder.dateEncodingStrategy, jsonDecoder.dateDecodingStrategy))!
        }
        
        set(newDateFormat) {
            let rawDateFormat = newDateFormat.rawValue
            
            jsonEncoder.dateEncodingStrategy = rawDateFormat.jsonEncoderDateFormat
            jsonDecoder.dateDecodingStrategy = rawDateFormat.jsonDecoderDateFormat
        }
    }
    
    // MARK: - Init methods
    
    public init() { }
    
    public func encode<T: Codable>(_ value: T) throws -> Data {
        return try jsonEncoder.encode(value)
    }
    
    public func decode<T: Codable>(_ type: T.Type, from data: Data) throws -> T {
        return try jsonDecoder.decode(type, from: data)
    }
}
