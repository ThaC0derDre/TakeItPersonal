//
//  QuickLookTableViewController.swift
//  TakeItPersonal
//
//  Created by Andres Gutierrez on 12/10/21.
//

import UIKit
import Lottie

class QuickLookTableViewController: UIViewController {

    var animationView: AnimationView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animationView = .init(name: "Money")
        animationView?.frame = view.bounds
        animationView?.animationSpeed = 0.7
        animationView?.play()
        view.addSubview(animationView!)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animationView?.play()
    }
    override func viewWillDisappear(_ animated: Bool) {
        animationView?.stop()
    }
    
}
