//
//  catchErrorJustComplete.swift
//  RxSwiftExt
//
//  Created by Florent Pillet on 21/05/16.
//  Copyright © 2016 RxSwift Community. All rights reserved.
//

import RxSwift
import RxCocoa

public extension Driver {
    
    func then(_ closure: @escaping @autoclosure () -> Void) -> SharedSequence<SharingStrategy, Element> {
        return map {
            closure()
            return $0
        }
    }
}

public extension ObservableType {
    
    func catchErrorJustComplete() -> Observable<Element> {
        `catch` { _ in
            Observable.empty()
        }
    }
    
    func asDriverOnErrorJustComplete() -> Driver<Element> {
        
        asDriver { error in
            Driver.empty()
        }
    }
    
    func then(_ closure: @escaping @autoclosure () throws -> Void) -> Observable<Element> {
        return map {
            try closure()
            return $0
        }
    }
}
