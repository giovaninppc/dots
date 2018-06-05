//
//  SorvivorGamePageViewController.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 18/04/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit

class SorvivorGamePageViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func pressPlay(_ sender: Any) {
        self.performSegue(withIdentifier: "survivorGameSegue", sender: self)
    }
    
}
