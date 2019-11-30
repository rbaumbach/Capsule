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

extension JSONCodableWrapper.OutputFormat: RawRepresentable {
    // MARK: - Type aliases
    
    public typealias JSONEncoderOutputFormat = JSONEncoder.OutputFormatting
    
    // MARK: - <RawRepresentable>
    
    public typealias RawValue = JSONEncoderOutputFormat

    public var rawValue: JSONEncoderOutputFormat {
        switch self {
        case .pretty:
            return .prettyPrinted
            
        default:
            return []
        }
    }
    
    public init?(rawValue: JSONEncoder.OutputFormatting) {
        if rawValue == .prettyPrinted {
            self = .pretty
        } else {
            self = .default
        }
    }
}

extension JSONCodableWrapper.DateFormat: RawRepresentable {
    // MARK: - Type aliases
    
    public typealias JSONEncoderDateFormat = JSONEncoder.DateEncodingStrategy
    public typealias JSONDecoderDateFormat = JSONDecoder.DateDecodingStrategy
    
    // MARK: - <RawRepresentable>

    public typealias RawValue = (jsonEncoderDateFormat: JSONEncoderDateFormat, jsonDecoderDateFormat: JSONDecoderDateFormat)
    
    public var rawValue: (jsonEncoderDateFormat: JSONEncoderDateFormat, jsonDecoderDateFormat: JSONDecoderDateFormat) {
        switch self {
        case .iso8601:
            return (.iso8601, .iso8601)
        default:
            return (.deferredToDate, .deferredToDate)
        }
    }
    
    public init?(rawValue: (jsonEncoderDateFormat: JSONEncoderDateFormat, jsonDecoderDateFormat: JSONDecoderDateFormat)) {
        switch rawValue.jsonEncoderDateFormat {
        case .iso8601:
            self = .iso8601
            
        default:
            self = .default
        }
    }
}
