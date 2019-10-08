//
//  CarsListingViewController.swift
//  CarsLocation
//
//  Created by Indivar Raina on 05/10/19.
//  Copyright © 2019 Indivar Raina. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CarsListingViewController: UIViewController {

    @IBOutlet weak var listingTableVIew: UITableView!
    let viewModel = CarsListingViewModel()
    let disposebag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindTableView()
        self.getCars()
    }
    
    func getCars()
    {
        self.viewModel.getCars().asObservable()
            .subscribe(onNext: { data in
                print(data)
            }).disposed(by: self.disposebag)
    }
    
    // binding table view with the car information data using rxswift and disposing it after fetching the records
    func bindTableView() {
        self.viewModel.carsData.asObservable().bind(to: self.listingTableVIew.rx.items) {
            (tableView,row, item) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "CarsListingCell") as? CarsListingCell
            cell?.setData(model: item)
            return cell!
        }.disposed(by: self.disposebag)
        
        self.listingTableVIew.rx.modelSelected(Placemarks.self) .subscribe({ (model) in
//            print(model)
            
            // push to next map controller from here
            //and send the whole viewmodel.carsdata
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "AllCarsMapsViewController") as! AllCarsMapsViewController
            //controller.carsData = self.viewModel.carsData.value
            controller.carsData = self.viewModel.carsData.value

            DispatchQueue.main.async {
                self.navigationController?.pushViewController(controller, animated: true)
            }
            
            
        }).disposed(by: self.disposebag)
    }
    
}
