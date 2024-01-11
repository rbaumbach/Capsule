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

open class Fake: Equatable {
    // MARK: - Readonly properties
    
    // Note: This is lazy so that the UUID 'generator' won't execute unless it is used.
    // This allows this property to be available without affecting performance on all fakes
    // that subclass this fake.
    
    public lazy private(set) var id: String = {
        return UUID().uuidString
    }()
    
    // MARK: - Init methods
    
    public init() { }
    
    // MARK: - <Equatable>
    
    // Note: For ease of determining equality, the simpliest check is using uuid (id)
    
    public static func == (lhs: Fake, rhs: Fake) -> Bool {
        return lhs.id == rhs.id
    }
}
