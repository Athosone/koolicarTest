//
//  PresenterType.swift
//  koolicar
//
//  Created by Werck Ayrton on 03/11/2017.
//  Copyright © 2017 Ayrton. All rights reserved.
//

import Foundation

protocol PresenterType {
    associatedtype Input
    associatedtype Output

    func transform(input: Input) -> Output
}
