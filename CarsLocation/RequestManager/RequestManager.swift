//
//  RequestManager.swift
//  CarsLocation
//
//  Created by Indivar Raina on 05/10/19.
//  Copyright © 2019 Indivar Raina. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa


final class RequestManager {
    
    let disposeBag = DisposeBag()
    static var sharedInstance = RequestManager()
    let reachability = Reachability()
    
    func makeGetRequest(withPath path: String, andParams params : Dictionary<String,String>?) -> Observable<Data>{
        
        if (reachability?.isReachable)! {
            
            let url = URL.init(string: path)!
            var request = URLRequest(url: url)
            request.timeoutInterval = 60
//            var headers = [String:String]()
            
//            for header in headers {
//                request.setValue(header.value, forHTTPHeaderField: header.key)
//            }
            
            let dataObservable = URLSession.shared.rx.data(request: request)
                .debug("some data is here")
            
            dataObservable.subscribe(onNext: {data in
                print(data)
            }).disposed(by: DisposeBag())
            return dataObservable
        } else {
            return Observable.error(APIErrors.noNetwork)
        }
    }
}


enum APIErrors: Error {
    case noNetwork
    case somethingWentWrong
}

