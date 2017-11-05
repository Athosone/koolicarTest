//
//  LocalDataSource.swift
//  kooliInMemPlatform
//
//  Created by Werck Ayrton on 03/11/2017.
//  Copyright © 2017 Ayrton. All rights reserved.
//

import Foundation
import RxSwift
import kooliDomain

protocol DataSourceProtocol {
    func fetchData() -> Observable<[Vehicle]>
}

class FileLoader: DataSourceProtocol {
    enum FileLoaderError: Error {
        case fileNotFound, malFormedJson
    }

    private let bundle: Bundle

    let fileName = "kooli"

    init(bundle: Bundle = Bundle(for: FileLoader.self)) {
        self.bundle = bundle
    }
    func loadJsonWith(name: String) throws -> Data {
        guard let pathUrl = bundle.url(forResource: name, withExtension: "json") else {
            throw FileLoaderError.fileNotFound
        }

        do {
            let data = try Data(contentsOf: pathUrl)
            return data
        } catch {
            print("Failed to load json with file name: \(name)")
            throw error
        }
    }

    func fetchData() -> Observable<[Vehicle]> {
        return Observable.create { [unowned self] o in
            do {
                let data = try self.loadJsonWith(name: self.fileName)
                let vehiclesDecoded = try JSONDecoder().decode([String: [Vehicle]].self, from: data)
                if let vehicles = vehiclesDecoded["vehicles"] {
                    o.onNext(vehicles)
                    o.onCompleted()
                } else {
                    o.onError(FileLoaderError.malFormedJson)
                }
            } catch {
                o.onError(error)
            }
            return Disposables.create()
        }
    }
}
