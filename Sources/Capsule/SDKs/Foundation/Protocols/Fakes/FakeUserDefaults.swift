//MIT License
//
//Copyright (c) 2020-2023 Ryan Baumbach <github@ryan.codes>
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
    
    public var capturedInitSuiteName: String?
        
    public var capturedSetIntValue: Int?
    public var capturedSetIntKey: String?
    
    public var capturedSetFloatValue: Float?
    public var capturedSetFloatKey: String?
    
    public var capturedSetDoubleValue: Double?
    public var capturedSetDoubleKey: String?
    
    public var capturedSetURLValue: URL?
    public var capturedSetURLKey: String?
    
    public var capturedSetValue: Any?
    public var capturedSetKey: String?
    
    public var capturedSetBoolValue: Bool?
    public var capturedSetBoolKey: String?
    
    public var capturedBoolKey: String?
    
    public var capturedIntKey: String?
    
    public var capturedFloatKey: String?
    
    public var capturedDoubleKey: String?

    public var capturedStringKey: String?
    
    public var capturedDataKey: String?
    
    public var capturedURLKey: String?
    
    public var capturedStringArrayKey: String?
    
    public var capturedArrayKey: String?
    
    public var capturedDictionaryKey: String?
    
    public var capturedObjectKey: String?
    
    public var capturedRemoveObjectKey: String?
    
    public var didCallResetStandardUserDefaults = false
        
    // MARK: - Stubbed properties

    public var stubbedBool = false
    
    public var stubbedInt = 99
    
    public var stubbedFloat: Float = 0.99
    
    public var stubbedDouble: Double = 0.99
    
    public var stubbedString: String? = "llaves"
    
    public var stubbedData: Data? = "data".data(using: .utf8)
    
    public var stubbedURL: URL? = URL(string: "https://cinemassacre.com")
    
    public var stubbedStringArray: [String]? = []
    
    public var stubbedArray: [Any]? = []
    
    public var stubbedDictionary: [String: Any]? = [:]
    
    public var stubbedObject: Any? = "Anything sir..."
    
    public var stubbedDictionaryRepresentation: [String: Any] = ["userdefaults": "repped"]
    
    // MARK: - Init methods
    
    public init() { }
    
    required public init?(suiteName suitename: String?) {
        capturedInitSuiteName = suitename
    }
    
    // MARK: - <UserDefaultsProtocol>
        
    public func set(_ value: Int, forKey defaultName: String) {
        capturedSetIntValue = value
        capturedSetIntKey = defaultName
    }
    
    public func set(_ value: Float, forKey defaultName: String) {
        capturedSetFloatValue = value
        capturedSetFloatKey = defaultName
    }
    
    public func set(_ value: Double, forKey defaultName: String) {
        capturedSetDoubleValue = value
        capturedSetDoubleKey = defaultName
    }
    
    public func set(_ url: URL?, forKey defaultName: String) {
        capturedSetURLValue = url
        capturedSetURLKey = defaultName
    }
    
    public func set(_ value: Any?, forKey defaultName: String) {
        capturedSetValue = value
        capturedSetKey = defaultName
    }
    
    public func set(_ value: Bool, forKey defaultName: String) {
        capturedSetBoolValue = value
        capturedSetBoolKey = defaultName
    }
    
    public func bool(forKey defaultName: String) -> Bool {
        capturedBoolKey = defaultName
        
        return stubbedBool
    }

    public func integer(forKey defaultName: String) -> Int {
        capturedIntKey = defaultName
        
        return stubbedInt
    }
    
    public func float(forKey defaultName: String) -> Float {
        capturedFloatKey = defaultName
        
        return stubbedFloat
    }
    
    public func double(forKey defaultName: String) -> Double {
        capturedDoubleKey = defaultName
        
        return stubbedDouble
    }
    
    public func string(forKey defaultName: String) -> String? {
        capturedStringKey = defaultName
        
        return stubbedString
    }
    
    public func data(forKey defaultName: String) -> Data? {
        capturedDataKey = defaultName
        
        return stubbedData
    }
    
    public func url(forKey defaultName: String) -> URL? {
        capturedURLKey = defaultName
        
        return stubbedURL
    }
    
    public func stringArray(forKey defaultName: String) -> [String]? {
        capturedStringArrayKey = defaultName
        
        return stubbedStringArray
    }
    
    public func array(forKey defaultName: String) -> [Any]? {
        capturedArrayKey = defaultName
        
        return stubbedArray
    }
    
    public func dictionary(forKey defaultName: String) -> [String: Any]? {
        capturedDictionaryKey = defaultName
        
        return stubbedDictionary
    }
    
    public func object(forKey defaultName: String) -> Any? {
        capturedObjectKey = defaultName
        
        return stubbedObject
    }
    
    public func removeObject(forKey defaultName: String) {
        capturedRemoveObjectKey = defaultName
    }
    
    public func dictionaryRepresentation() -> [String: Any] {
        return stubbedDictionaryRepresentation
    }
    
    public func resetStandardUserDefaults() {
        didCallResetStandardUserDefaults = true
    }
}
