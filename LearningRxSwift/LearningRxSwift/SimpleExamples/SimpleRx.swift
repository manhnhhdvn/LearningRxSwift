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
        
        observable.asObservable().subscribe(onNext: { someString in
            print("ZZZZ: \(someString)")
        }).disposed(by: bag)

        let observer = observable.subscribe(onNext: { someString in
            print("Another Subscriber: \(someString)")
        })
        observer.disposed(by: bag)
    }
}

extension SimpleRx {
    func myTest() {
//        let disposeBag = DisposeBag()
//
//        Observable<Int>.of(1, 2, 3, 4, 5, 6, 7)
//            .map { element in
//                element * 10
//            }
//            .subscribe(onNext: { element in
//                print(element)
//            })
//            .disposed(by: disposeBag)
        
        
//        struct Student {
//            var name: String
//            var score: Variable<Int>
//        }
//
//        let disposeBag = DisposeBag()
//
//        let studentA = Student(name: "Mr.A", score: Variable(5))
//        let studentB = Student(name: "Mr.B", score: Variable(10))
//        let studentC = Student(name: "Mr.C", score: Variable(15))
//
//        let sourceObservable = Observable.of(studentA, studentB, studentC)
//
//        sourceObservable
//            .flatMap { element in
//                return element.score.asObservable()
//            }
//            .subscribe(onNext: { score in
//                print("Student's score \(score)")
//            })
//            .disposed(by: disposeBag)
//
//        studentA.score.value = 25
//        studentB.score.value = 30
//        studentC.score.value = 35
        
        
//        let disposeBag = DisposeBag()
//
//        let observable = Observable.of(2, 3, 4, 5, 6 ,7)
//        observable.startWith(10)
//            .subscribe { event in
//                print(event)
//            }
//            .disposed(by: disposeBag)
        
        
//        let disposeBag = DisposeBag()
//
//        let one = Observable.of(1, 2, 3)
//        let two = Observable.of(4, 5, 6)
//        let three = Observable.of(7, 8, 9)
//
//        let observable = Observable.concat([one, two, three])
//        observable
//            .subscribe { event in
//                print(event)
//            }
//            .disposed(by: disposeBag)
//
//        one.concat(two).concat(three)
//            .subscribe { event in
//                print(event)
//            }
//            .disposed(by: disposeBag)
//
//        Observable.just(1).concat(one)
//            .subscribe { event in
//                print(event)
//            }
//            .disposed(by: disposeBag)

        
//        let disposeBag = DisposeBag()
//
//        let firstObservable = PublishSubject<String>()
//        let secondObservable = PublishSubject<String>()
//
//        Observable.merge(firstObservable, secondObservable)
//            .subscribe { element in
//                print(element)
//            }
//            .disposed(by: disposeBag)
//
//        firstObservable.onNext("firstObservable 1")
//        secondObservable.onNext("secondObservable 1")
//        secondObservable.onNext("secondObservable 2")
//        secondObservable.onNext("secondObservable 3")
//        firstObservable.onNext("firstObservable 2")
//        secondObservable.onNext("secondObservable 4")
        
        
//        let disposeBag = DisposeBag()
//
//        let one = Observable.of(1, 2, 3)
//        let two = Observable.of(4, 5, 6)
//
//        let observable = Observable
//            .combineLatest(one, two) { e1, e2 -> (Int, Int) in
//                return (e1, e2)
//        }
//        observable
//            .subscribe { event in
//                print("event: \(event)")
//            }
//            .disposed(by: disposeBag)
        
        
//        func divideNumber(_ a: Int, _ b: Int) -> Single<Int> {
//            return Single.create { single in
//                if b == 0 {
//                    single(.error(NSError()))
//                } else {
//                    single(.success(a / b))
//                }
//                return Disposables.create()
//            }
//        }
//        // Subscriber
//        let disposeBag = DisposeBag()
//        divideNumber(10, 0)
//            .subscribe { element  in
//                switch element {
//                case .success(let result):
//                    print("result: \(result)")
//                case .error(let error):
//                    print("error")
//                }
//            }
//            .disposed(by: disposeBag)
    }
}
