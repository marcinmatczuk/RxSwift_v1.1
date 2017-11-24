//: Please build the scheme 'RxSwiftPlayground' first
import RxSwift

example(of: "just, of, from") {
    // 1
    let one = 1
    let two = 2
    let three = 3
    
    // 2
    let observable: Observable<Int> = Observable<Int>.just(one)
    let observable2 = Observable.of(one, two, three)
    let observable3 = Observable.of([one, two, three])
    let observable4 = Observable.from([one, two, three])
    
    observable4.subscribe { event in
        if let element = event.element {
            print(element)
        }
    }
}


example(of: "empty") {
    let observable = Observable<Void>.empty()
    
    observable
        .subscribe(
            // 1
            onNext: { element in print(element)
                
        },
            onCompleted: {
                print("Completed")
    }
    )
}

example(of: "never") {
    let observable = Observable<Any>.never()
    
    observable
        .subscribe(
            // 1
            onNext: { element in print(element)
                
        },
            onCompleted: {
                print("Completed")
        }
    )
}
