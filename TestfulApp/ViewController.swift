//
//  ViewController.swift
//  TestfulApp
//
//  Created by Nick Melnick on 8/28/17.
//  Copyright © 2017 Nick Melnick. All rights reserved.
//

import UIKit
import RxSwift
import NSObject_Rx

class ViewController: UIViewController {

    let transitionManager = TransitionManager()
    
    @IBOutlet var loaderImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let animation = ["loader1", "loader2", "loader3", "loader4", "loader5", "loader6"].flatMap{ UIImage(named:$0) }
        loaderImageView.animationImages = animation
        loaderImageView.animationRepeatCount = 0
        loaderImageView.animationDuration = 1
        loaderImageView.startAnimating()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Observable.just(true).delay(1, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] (_) in
                self?.loaderImageView.stopAnimating()
                self?.loaderImageView.image = #imageLiteral(resourceName: "loader1")
                self?.performSegue(withIdentifier: "showChats", sender: nil)
            })
            .addDisposableTo(rx_disposeBag)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showChats" {
            let nc = segue.destination as? UINavigationController
            let coordinator = ChatsCoordinator(navigationController: nc)
            coordinator.start()
            
            nc?.transitioningDelegate = transitionManager
            
//            let scalesegue = segue as! ScaleSegue
//            scalesegue.viewController = nc
        }
    }
    

}

