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

public protocol StringWrapperProtocol {
    func loadString(contentsOfFile path: String) throws -> String
    func loadData(contentsOfFile path: String,
                  encoding: String.Encoding) throws -> Data?
}

public class StringWrapper: StringWrapperProtocol {
    // MARK: - Init methods
    
    public init() { }
    
    // MARK: - Public methods
    
    public func loadString(contentsOfFile path: String) throws -> String {
        return try String(contentsOfFile: path)
    }
    
    public func loadData(contentsOfFile path: String,
                         encoding: String.Encoding) throws -> Data? {
        return try loadString(contentsOfFile: path).data(using: encoding)
    }
}
