import Foundation
import RxSwift

class SimpleRx {
    var bag = DisposeBag()
}

//MARK: Variables
extension SimpleRx {
    static var shared = SimpleRx()

    func variable() {
        print("~~~~~~Variable~~~~~~")
        let someInfo = Variable("some value")
        print("someInfo.value: \(someInfo.value)")

        someInfo.value = "something new"
        print("someInfo.value: \(someInfo.value)")

        // Variable wil never receive onError and onComplete events
        someInfo.asObservable().subscribe(onNext: { newValue in
            print("value has changed: \(newValue)")
        }, onDisposed: {
            // optional cleanup block
        }).disposed(by: bag)
        someInfo.value = "changed again"
    }
}

//MARK: Subjects
extension SimpleRx {
    func subjects() {
        let behaviorSubject = BehaviorSubject(value: 24)
        let disposable = behaviorSubject.subscribe(onNext: { newValue in
            print("BehaviorSubject subscription: \(newValue)")
        }, onError: { error in
            print("Error: \(error.localizedDescription)")
        }, onCompleted: {
            print("completed")
        }) {
            print("disposed")
        }

        behaviorSubject.onNext(34)
        behaviorSubject.onNext(48)
        behaviorSubject.onNext(48) // dupplicates

//        // 1 on error
//        let customError = CustomError.forcedError
//        behaviorSubject.onError(customError) // also trigger the dispose event
//        behaviorSubject.onNext(109) // Will never show

//        // 2 on complete
//        behaviorSubject.onCompleted() // also trigger the dispose event
//        behaviorSubject.onNext(1111) // Will never show

//        // 3 on dispose
//        disposable.dispose()

        // 4 can bind observables to subjects
        let numbers = Observable.from([1, 2, 3, 4, 5, 6, 7])
        numbers.subscribe(onNext: { number in
            print("Observable subscription: \(number)")
        }).disposed(by: bag)
        numbers.bind(to: behaviorSubject).disposed(by: bag)
    }
}

//MARK: Basic observables
extension SimpleRx {
    func basicObservables() {
        let observable = Observable<String>.create { observer in
            // The closure is called for every subscriber - by default
            print("~~ Observable logic being triggered ~~")


            // Do work on a background thread
            DispatchQueue.global().async {
                Thread.sleep(forTimeInterval: 1)
                observer.onNext("some value 23")
                observer.onCompleted()
            }
            return Disposables.create {
                // do something
                // network clean
                // fileio release
                //Clean up
//                connection.close()
//                database.closeImportantSomething()
//                cache.clear()
            }
        }

        observable.subscribe(onNext: { someString in
            print("new value: \(someString)")
        }).disposed(by: bag)

        let observer = observable.subscribe(onNext: { someString in
            print("Another Subscriber: \(someString)")
        })
        observer.disposed(by: bag)
    }
}
