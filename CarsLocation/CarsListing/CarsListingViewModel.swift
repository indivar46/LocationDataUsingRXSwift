//
//  CarsListingViewModel.swift
//  CarsLocation
//
//  Created by Indivar Raina on 05/10/19.
//  Copyright © 2019 Indivar Raina. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa


class CarsListingViewModel {
    
    var carsData = Variable<[Placemarks]>([])
    let disposeBag = DisposeBag()
    
    func getCars() -> Observable<[String : Any]> {
        return Observable.create{observer in
            RequestManager.sharedInstance.makeGetRequest(withPath: "https://s3-us-west-2.amazonaws.com/wunderbucket/locations.json", andParams: nil)
                .asObservable()
                .observeOn(MainScheduler.instance)
                .subscribe(onNext: { responseData in
                    do {
                        let modelObject = try JSONDecoder().decode(CarsListing.self, from: responseData)
                        
                        
                        if let placeMarks = modelObject.placemarks {
                            self.carsData.value = placeMarks
                        }
                        
                        observer.onNext(["gotKycData" : true])
                        observer.on(.completed)
                        
                    }
                    catch {
                        observer.onError(APIErrors.somethingWentWrong)
                        observer.on(.completed)
                    }
                },onError: { error in
                    observer.onError(APIErrors.somethingWentWrong)
                    observer.on(.completed)
                })
                .disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }
}
