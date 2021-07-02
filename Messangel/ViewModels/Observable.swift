//
//  Observable.swift
//  Messangel
//
//  Created by Saad on 6/9/21.
//

//import Foundation
import Combine

@dynamicMemberLookup
final class Observable<Value>: ObservableObject {
    @Published var value: Value
    private var cancellable: AnyCancellable?

    init<T: Publisher>(
        value: Value,
        publisher: T
    ) where T.Output == Value, T.Failure == Never {
        self.value = value
        self.cancellable = publisher.assign(to: \.value, on: self)
    }

    subscript<T>(dynamicMember keyPath: KeyPath<Value, T>) -> T {
        value[keyPath: keyPath]
    }
}

extension CurrentValueSubject where Failure == Never {
    func asObservable() -> Observable<Output> {
        Observable(value: value, publisher: self)
    }
}
