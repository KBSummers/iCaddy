//
//  WebViewController.swift
//  iCaddy
//
//  Created by Kyle Summers on 4/21/20.
//  Copyright © 2020 Kyle Summers. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {
    var selectedCourse:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        let scheme = "https"
         let host = "www.google.com"
         let path = "/search"
         let queryItem = URLQueryItem(name: "q", value: selectedCourse)
         
         
         var urlComponents = URLComponents()
         urlComponents.scheme = scheme
         urlComponents.host = host
         urlComponents.path = path
         urlComponents.queryItems = [queryItem]
         
        // let url = NSURL(string: urlComponents.url )!
         UIApplication.shared.openURL(urlComponents.url!)

         // Do any additional setup after loading the view.

        // Do any additional setup after loading the view.
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
