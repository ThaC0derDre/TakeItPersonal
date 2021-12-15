//
//  QuickLookTableViewController.swift
//  TakeItPersonal
//
//  Created by Andres Gutierrez on 12/10/21.
//

import UIKit
import Lottie

class QuickLookTableViewController: UIViewController {

    @IBOutlet weak var amountRemaining: UILabel!
    @IBOutlet weak var howMuchYouveSpent: UILabel!
    var animationView: AnimationView?
    let transferAmount = TransactionViewController().totalSumofTransactionsThisMonth
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animationView = .init(name: "Money")
        animationView?.frame = view.bounds
        animationView?.animationSpeed = 0.7
        animationView?.play()
        view.addSubview(animationView!)
        amountRemaining.text = ("Out of $250, you have \(250-transferAmount) remaining")
        howMuchYouveSpent.text = ("You've spent \(transferAmount) so far this month")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animationView?.play()
    }
    override func viewWillDisappear(_ animated: Bool) {
        animationView?.stop()
    }

    
}


/* We want to string interpolate how much balance you have remaining
 so we'll need Default Text with \(Balance remaining.)
 but BEFORE that, we'll need a var "balanceRemaining" with the sum of amount from a given array.
 The challenge is that it will have to be the sum of only one category (Month.)
 
 1. Grab sum from a specific Month's Transactions.
 
 2. Use String Interpolation to capture that in the intro's label.
 
 */

