//
//  MyBeachesViewController.swift
//  Surf Finder
//
//  Created by Dai on 27/03/2016.
//  Copyright © 2016 daio. All rights reserved.
//

import UIKit
import RxSwift

class MyBeachesViewController: BeachLocationsViewController {

    private let disposeBag = DisposeBag()
    
    override init(beaches: [BeachLocationItemViewModel] = [], title: String = "My Beaches") {
        super.init(beaches: beaches, title: title)
        bindFavouriteChanges()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func bindFavouriteChanges() {
        for beach in beaches {
            beach.isFavourited.asObservable().doOnNext({ [unowned self] (isFav) in
                if isFav == false {
                    self.updateBeachesInTable()
                }
            }).subscribe().addDisposableTo(disposeBag)
        }
    }
    
    private func updateBeachesInTable() {
        beaches = beaches.filter({ (beachLocation) -> Bool in
            return beachLocation.isFavourited.value
        })
        self.tableView.reloadData()
    }
    
}