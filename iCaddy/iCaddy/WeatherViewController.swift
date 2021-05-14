//
//  WeatherViewController.swift
//  iCaddy
//
//  Created by Kyle Summers on 4/21/20.
//  Copyright © 2020 Kyle Summers. All rights reserved.
//

import UIKit
import CoreLocation
class WeatherViewController: UIViewController {

    @IBOutlet weak var weatherReadings: UILabel!
    @IBOutlet weak var weathIcon: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        weathIcon.image = UIImage(named: "weather.png")
        
        
        var locManager = CLLocationManager()
        locManager.requestWhenInUseAuthorization()
        var currentLocation: CLLocation!

        if
           CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
           CLLocationManager.authorizationStatus() ==  .authorizedAlways
        {
            currentLocation = locManager.location
        }
        print("\(currentLocation.coordinate.longitude)")
        print("\(currentLocation.coordinate.latitude)")
        // Do any additional setup after loading the view.
        
        DispatchQueue.main.async(execute: {
            var soutput:String = ""
            var urlAsString:String = ""
            if let lat:Double = currentLocation.coordinate.latitude{
                if let lon:Double = currentLocation.coordinate.longitude{
                    urlAsString = "http://api.geonames.org/findNearByWeatherJSON?formatted=true&lat=\(lat)&lng=\(lon)&username=kysums&style=full"
                }
            }
            
            let url = URL(string: urlAsString)!
            let urlSession = URLSession.shared
            
            
            let jsonQuery = urlSession.dataTask(with: url, completionHandler: { data, response, error -> Void in
                if (error != nil) {
                    print(error!.localizedDescription)
                }
                var err: NSError?
                let jsonResult = (try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)) as! NSDictionary
                if (err != nil) {
                    print("JSON Error \(err!.localizedDescription)")
                }
                let w:NSDictionary = jsonResult["weatherObservation"] as! NSDictionary
                //print(w["clouds"])
                if let x0 = w["clouds"]{
                    soutput.append("\(x0) and a temperature of ")
                }
                if let x1 = w["temperature"]{
                    soutput.append("\(x1) degrees Celsius, with a humidity of ")
                }
                if let x2 = w["humidity"]{
                    soutput.append("\(x2)")
                }
                /*
               let setOne:NSArray = jsonResult["earthquakes"] as! NSObject
                //print(setOne);
                
                let p = (setOne.count) as Int

                for i in 0..<p{
                    let y = setOne[i] as? [String: AnyObject]
                    soutput.append("\nEarthquake \(i) --> ")
                    if let dt = y?["datetime"]{
                        //print(dt)
                        if let mg = y?["magnitude"]{
                            //print(mg)
                            soutput.append("Datetime: \(dt) with Magnitude: \(mg)")
                        }
                    }
                }
                 */
            DispatchQueue.main.async(execute: {
                print(soutput)
                self.weatherReadings.numberOfLines = 0
                self.weatherReadings.text = soutput
                })

            })
                    //print(soutput)
                    //print("test")
                    //self.output.text = soutput
            jsonQuery.resume()
            })
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
