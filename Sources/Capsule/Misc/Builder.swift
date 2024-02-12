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

// MARK: - Generic Builder

public protocol Builder {
    associatedtype BuildType: Initializable
    
    func build() -> BuildType
}

public class BuilderEngine<BuildType: Initializable>: Builder {
    // MARK: - Init methods
    
    public init() { }
    
    // MARK: - Public methods
    
    public func build() -> BuildType {
        return BuildType()
    }
}

// MARK: - Lovely Type Erasure /s

// MARK: - AnyBuilder

public class AnyBuilder<BuildType: Initializable>: Builder {
    // MARK: - Private properties
    
    private let box: AnyBuilderBase<BuildType>
    
    // MARK: - Init methods
    
    public init() {
        box = AnyBuilderBox(BuilderEngine())
    }
    
    public init<T: Builder>(_ concrete: T) where T.BuildType == BuildType {
        box = AnyBuilderBox(concrete)
    }
    
    // MARK: - Public methods

    public func build() -> BuildType {
        return box.build()
    }
}

// MARK: - Private AnyBuilderBase

private class AnyBuilderBase<BuildType: Initializable>: Builder {
    // MARK: - Abstract methods
    
    func build() -> BuildType {
        fatalError("build() method must be overridden")
    }
}

// MARK: - Private AnyBuilderBox

private class AnyBuilderBox<T: Builder>: AnyBuilderBase<T.BuildType> {
    var concrete: T

    init(_ concrete: T) {
        self.concrete = concrete
    }

    override func build() -> BuildType {
        return concrete.build()
    }
}
