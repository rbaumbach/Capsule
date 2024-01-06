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

public class FakeNotificationCenter: NotificationCenterProtocol {
    // MARK: - Captured properties
    
    public var capturedAddObserver: Any?
    public var capturedAddObserverSelector: Selector?
    public var capturedAddObserverName: NSNotification.Name?
    public var capturedAddObserverObject: Any?
    
    public var capturedAddObserverWithQueueName: NSNotification.Name?
    public var capturedAddObserverWithQueueObject: Any?
    public var capturedAddObserverWithQueue: OperationQueue?
    public var capturedAddObserverWithQueueBlock: ((Notification) -> Void)?
    
    public var capturedRemoveObserver: Any?
    
    public var capturedRemoveObserverWithObjectObserver: Any?
    public var capturedRemoveObserverWithObjectName: NSNotification.Name?
    public var capturedRemoveObserverWithObject: Any?
    
    public var capturedPostNotification: Notification?
    
    public var capturedPostNotificationName: NSNotification.Name?
    public var capturedPostNotificationObject: Any?
    public var capturedPostNotificationUserInfo: [AnyHashable: Any]?
        
    // MARK: - Stubbed properties
    
    public var stubbedAddObserverWithQueueObject = NSString(string: "Something that is ol' skoo")
    
    // MARK: - Init methods
    
    public init() { }
        
    // MARK: - <NotificationCenterProtocol>
    
    public func addObserver(_ observer: Any,
                            selector aSelector: Selector,
                            name aName: NSNotification.Name?,
                            object anObject: Any?) {
        capturedAddObserver = observer
        capturedAddObserverSelector = aSelector
        capturedAddObserverName = aName
        capturedAddObserverObject = anObject
    }
    
    public func addObserver(forName name: NSNotification.Name?,
                            object obj: Any?,
                            queue: OperationQueue?,
                            using block: @escaping (Notification) -> Void) -> NSObjectProtocol {
        capturedAddObserverWithQueueName = name
        capturedAddObserverWithQueueObject = obj
        capturedAddObserverWithQueue = queue
        capturedAddObserverWithQueueBlock = block
        
        return stubbedAddObserverWithQueueObject
    }
    
    public func removeObserver(_ observer: Any) {
        capturedRemoveObserver = observer
    }
    
    public func removeObserver(_ observer: Any,
                               name aName: NSNotification.Name?,
                               object anObject: Any?) {
        capturedRemoveObserverWithObjectObserver = observer
        capturedRemoveObserverWithObjectName = aName
        capturedRemoveObserverWithObject = anObject
    }
    
    public func post(_ notification: Notification) {
        capturedPostNotification = notification
    }
    
    public func post(name aName: NSNotification.Name,
                     object anObject: Any?) {
        
    }
    
    public func post(name aName: NSNotification.Name,
                     object anObject: Any?,
                     userInfo aUserInfo: [AnyHashable: Any]?) {
        capturedPostNotificationName = aName
        capturedPostNotificationObject = anObject
        capturedPostNotificationUserInfo = aUserInfo
    }
}
