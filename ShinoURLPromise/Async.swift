//
//  Async.swift
//  ShinoURLPromise
//
//  Created by shino on 2016/12/28.
//  Copyright © 2016年 shino. All rights reserved.
//

import Foundation

struct Async<T> {
    let trunk: (@escaping(T) -> Void) -> Void
    
    init(trunk: @escaping(@escaping(T) -> Void) -> Void) {
        self.trunk = trunk
    }
    
    func execute(callback: @escaping(T) -> Void) {
        self.trunk(callback)
    }
}

extension Async {
    func flatMap<U>(callback: @escaping(T) -> Async<U>) -> Async<U> {
        return Async<U> { (nextCallback: @escaping (U) -> Void) -> Void in
            self.execute { (firstResult: T) -> Void in
                let nextAsync = callback(firstResult)
                nextAsync.execute(callback: nextCallback)
            }
        }
    }
    
    static func unit(x: T) -> Async<T> {
        return Async { (callback: (T) -> Void) -> Void in
            callback(x)
        }
    }
    
    func map<U>(callback: @escaping(T) -> U) -> Async<U> {
        return self.flatMap { (result: T) -> Async<U> in
            Async<U>.unit(x: callback(result)) }
    }
}

extension URLSession {
    func dataTask(with url: URL) -> Async<Data?> {
        return Async { (callback: @escaping (Data?) -> Void) -> Void in
            URLSession.shared.dataTask(with: url) { (data: Data?, _, _) -> Void in
                callback(data)
            }.resume()
        }
    }
}
