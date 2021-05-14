//
//  MapViewController.swift
//  iCaddy
//
//  Created by Kyle Summers on 4/20/20.
//  Copyright © 2020 Kyle Summers. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var mapView: MKMapView!
    var manager:CLLocationManager!
    var matchingItems:[MKMapItem] = []

    @IBOutlet weak var golfTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.viewDidLoad()
        
        //Core Location Stuff
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()

    }
    
    
    class func isLocationServiceEnabled() -> Bool {
        if CLLocationManager.locationServicesEnabled() {
            switch(CLLocationManager.authorizationStatus()) {
            case .notDetermined, .restricted, .denied:
                return false
            case .authorizedAlways, .authorizedWhenInUse:
                return true
            default:
                print("Something wrong with Location services")
                return false
            }
        } else {
            print("Location services are not enabled")
            return false
        }
    }
    
    //NOTE: [AnyObject] changed to [CLLocation]
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        print(locations)
        //userLocation - there is no need for casting, because we are now using CLLocation object
        let userLocation:CLLocation = locations[0]
        // MK Map View Stuff
        // THIS IS WHERE YOU LEFT OFF, TURN CORELOC DATA INTO CITY NAME AND FIND COURSES
        let lon : CLLocationDegrees = Double(round(100*userLocation.coordinate.longitude)/100)//-112.08//
        let lat : CLLocationDegrees = Double(round(100*userLocation.coordinate.latitude)/100)//33.47//
        let coordinates = CLLocationCoordinate2D( latitude: lat, longitude: lon)
        let span: MKCoordinateSpan = MKCoordinateSpan.init(latitudeDelta: 0.2, longitudeDelta: 0.2)
        let region: MKCoordinateRegion = MKCoordinateRegion.init(center: coordinates, span: span)
        self.mapView.setRegion(region, animated: true)
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "Golf"
        let span2: MKCoordinateSpan = MKCoordinateSpan.init(latitudeDelta: 0.009, longitudeDelta: 0.009)
        let region2: MKCoordinateRegion = MKCoordinateRegion.init(center: coordinates, span: span)

        request.region = region2
        let search = MKLocalSearch(request: request)
          
        search.start { response, _ in
          guard let response = response else {
              return
          }
              print( response.mapItems )
            self.matchingItems = response.mapItems
            self.golfTable.reloadData()
              
            for i in 0...(self.matchingItems.count - 1)
              {
                let placemark = self.matchingItems[i].placemark
                let ani = MKPointAnnotation()
                ani.coordinate = placemark.location!.coordinate
                ani.title = placemark.name
                //ani.subtitle = placemark.subtitle
                self.mapView.addAnnotation(ani)
                      
              }
             
          }
        // self.mapView.setRegion(region, animated: true)

        
        
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("count \(matchingItems.count)")
        return matchingItems.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0;//Choose your custom row height
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let searchResult = matchingItems[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "golfCell", for: indexPath) as! GolfCourseTableViewCell
        cell.layer.borderWidth = 1.0
        cell.courseTitle.text = searchResult.name
        if let s = searchResult.placemark.thoroughfare{
            if let s1 = searchResult.placemark.subThoroughfare{
                cell.courseAddress.text = "\(s1) \(s)"
            }
        }
        
        return cell
    }
    
    // delete table entry
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return false
    }
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell.EditingStyle { return UITableViewCell.EditingStyle.delete }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
      // delete the data from the fruit table,  Do this first, then use method 1 or method 2
        //myCityList.removeCityObject(item: indexPath.row)
        
        //Method 1
        self.golfTable.beginUpdates()
        self.golfTable.deleteRows(at: [indexPath], with: .automatic)
        self.golfTable.endUpdates()
        
        //Method 2
          //self.fruitTable.reloadData()
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let selectedIndex: IndexPath = self.golfTable.indexPath(for: sender as! UITableViewCell)!
        let course = matchingItems[selectedIndex.row]
        if(segue.identifier == "webView"){
            if let viewController: WebViewController = segue.destination as? WebViewController {
                viewController.selectedCourse = course.name;
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
