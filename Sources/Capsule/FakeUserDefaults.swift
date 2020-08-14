//MIT License
//
//Copyright (c) 2020 Ryan Baumbach <github@ryan.codes>
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

public class FakeUserDefaults: UserDefaultsProtocol {
    // MARK: - Captured properties
    
    public var capturedSetValue: Any?
    public var capturedSetKey: String?
    public var capturedSetBoolKey: String?
    public var capturedSetBoolValue: Bool?
    
    public var capturedStringKey: String?
    public var capturedBoolKey: String?
    
    // MARK: - Stubbed properties

    public var stubbedString = "llaves"
    public var stubbedBool = false
    
    // MARK: - Init methods
    
    public init() { }
    
    // MARK: - <UserDefaultsProtocol>
    
    public func set(_ value: Any?, forKey defaultName: String) {
        capturedSetValue = value
        capturedSetKey = defaultName
    }
    
    public func set(_ value: Bool, forKey defaultName: String) {
        capturedSetBoolKey = defaultName
        capturedSetBoolValue = value
    }
    
    public func string(forKey defaultName: String) -> String? {
        capturedStringKey = defaultName
        
        return stubbedString
    }
    
    public func bool(forKey defaultName: String) -> Bool {
        capturedBoolKey = defaultName
        
        return stubbedBool
    }
}
