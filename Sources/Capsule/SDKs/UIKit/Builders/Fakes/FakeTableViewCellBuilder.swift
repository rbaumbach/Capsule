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

import UIKit

public class FakeTableViewCellBuilder: TableViewCellBuilderProtocol {
    // MARK: - Captured properties
    
    public var capturedBuildName: String?
    
    // MARK: - Stubbed properties
    
    public var stubbedTableViewCell = UITableViewCell()
    
    // MARK: - Init methods
    
    public init() { }
    
    // MARK: - <TableViewCellBuilderProtocol>
    
    public func build<T: UITableViewCell>(name: String) -> T {
        guard let tableViewCell = stubbedTableViewCell as? T else {
            preconditionFailure("FakeTableViewCellBuilder.stubbedTableViewCell property has not been set properly")
        }
        
        capturedBuildName = name
        
        return tableViewCell
    }
}
