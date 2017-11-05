//
//  Rx+Ext.swift
//  koolicar
//
//  Created by Werck Ayrton on 03/11/2017.
//  Copyright © 2017 Ayrton. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

extension ObservableType {
    func asDriverOnErrorJustComplete() -> Driver<E> {
        return asDriver { _ in
            return Driver.empty()
        }
    }

    func unwrap<T>() -> Observable<T> where E == T? {
        return filter { $0 != nil }.map { $0! }
    }

    func mapToVoid() -> Observable<Void> {
        return self.map { _ in }
    }
}
