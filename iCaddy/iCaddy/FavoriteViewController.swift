//
//  FavoriteViewController.swift
//  iCaddy
//
//  Created by Kyle Summers on 4/21/20.
//  Copyright © 2020 Kyle Summers. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var m:Model?
    @IBOutlet weak var names: UITextField!
    @IBOutlet weak var namei: UITextField!
    @IBOutlet weak var ratingi: UITextField!
    @IBOutlet weak var ratingl: UILabel!
    @IBOutlet weak var namel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        m = Model(context: managedObjectContext)

        // Do any additional setup after loading the view.
    }
    

    @IBAction func add(_ sender: Any) {
        m?.SaveContext(name: namei.text!, rating: Double(ratingi.text!) as! Double)

    }
    
    
    @IBAction func clear(_ sender: Any) {
        m?.clearData()

    }
    
    
    @IBAction func find(_ sender: Any) {
        let rec = m?.findRecord(name: self.names.text!)
        if  let recRecieved = rec {
            if let x = recRecieved.value(forKey: "rating") as? Double{
                ratingl.text = "\(x)"

            }
                namel.text = recRecieved.value(forKey: "name") as? String
                
                //status.text = "Matches found: \(results.count)"
            } else {
                ratingl.text = "No Match"
                namel.text = "No Match"

            }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
