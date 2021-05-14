//
//  ViewController.swift
//  iCaddy
//
//  Created by Kyle Summers on 4/20/20.
//  Copyright © 2020 Kyle Summers. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var homeImage: UIImageView!
    @IBOutlet weak var cad: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        homeImage.image = UIImage(named: "app3.jpg")
        cad.image = UIImage(named: "cad.png")
        // Do any additional setup after loading the view.
    }


}

