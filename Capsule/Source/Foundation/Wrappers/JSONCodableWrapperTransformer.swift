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

class JSONCodableWrapperTransformer {
    // MARK: - Internal Static methods
    
    func transform(_ outputFormat: JSONCodableWrapper.OutputFormat) -> JSONEncoder.OutputFormatting {
        switch outputFormat {
        case .pretty:
            return .prettyPrinted

        case .default:
            return []
        }
    }
    
    func transform(_ ouputFormat: JSONEncoder.OutputFormatting) -> JSONCodableWrapper.OutputFormat {
        if ouputFormat == .prettyPrinted {
            return .pretty
        } else {
            return .default
        }
    }
    
    // Note: The current default for JSONEncoder/Decoder.DateEncodingStratgy is .deferredToDate

    func transform(_ dateFormat: JSONCodableWrapper.DateFormat) -> JSONEncoder.DateEncodingStrategy {
        switch dateFormat {
        case .iso8601:
            return .iso8601

        case .default:
            return .deferredToDate
        }
    }
    
    func transform(_ dateFormat: JSONCodableWrapper.DateFormat) -> JSONDecoder.DateDecodingStrategy {
        switch dateFormat {
        case .iso8601:
            return .iso8601

        case .default:
            return .deferredToDate
        }
    }
    
    func transform(_ dateFormat: JSONEncoder.DateEncodingStrategy) -> JSONCodableWrapper.DateFormat {
        switch dateFormat {
        case .iso8601:
            return .iso8601
            
        case .deferredToDate:
            return .default
            
        case .secondsSince1970:
            return .default
            
        case .millisecondsSince1970:
            return .default
            
        case .formatted:
            return .default
            
        case .custom:
            return .default
            
        @unknown default:
            return .default
        }
    }
}
