//
//  MapController.swift
//  MapMultiLanguage
//
//  Created by iOS Dev on 16/11/2561 BE.
//  Copyright © 2561 iOS Dev. All rights reserved.
//

import UIKit
import MapKit

class MapController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var centerLatLabel: UILabel!
    
    @IBOutlet weak var centerLongLabel: UILabel!
    
    @IBOutlet weak var userLatLabel: UILabel!
    
    @IBOutlet weak var userLongLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let trackingButton = MKUserTrackingButton(mapView: self.mapView)
        
        // Need this to allow auto layout (If true all constrains that we add just won't matter
        trackingButton.translatesAutoresizingMaskIntoConstraints = false
        self.mapView.addSubview(trackingButton)
        self.mapView.addConstraints([
            trackingButton.bottomAnchor.constraint(equalTo: self.mapView.bottomAnchor, constant: 0),
            trackingButton.rightAnchor.constraint(equalTo: self.mapView.rightAnchor, constant: 0)])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let auth = CLLocationManager.authorizationStatus()
        
        switch auth {
        case .denied, .notDetermined, .restricted : // for any case that can't get location
            let alert = UIAlertController(title: "Cannot access location", message: "Please allow", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            break
        default:
            break
        }
    }
    
    @IBAction func followUserSwitchValueChange(_ sender: UISwitch) {
        // sender is Switch in UI
        if (sender.isOn) {
            self.mapView.userTrackingMode = .follow
        }
        else {
            self.mapView.userTrackingMode = .none
        }
    }
    
    @IBAction func dropPinButtonTouch() {
        let ann = MKPointAnnotation()
        ann.coordinate = mapView.centerCoordinate
        ann.title = "Here"
        ann.subtitle = "Detail is .."
        self.mapView.addAnnotation(ann)
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

extension MapController: MKMapViewDelegate { // you can just extend in normal way but this will look more clean
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        self.userLatLabel.text = "\(userLocation.coordinate.latitude)"
        self.userLongLabel.text = "\(userLocation.coordinate.longitude)"
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        self.centerLatLabel.text = "\(mapView.centerCoordinate.latitude)"
        self.centerLongLabel.text = "\(mapView.centerCoordinate.longitude)"
    }
}

extension MapController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let searchTxt = searchBar.text
        let req = MKLocalSearch.Request()
        req.naturalLanguageQuery = searchTxt
        req.region = self.mapView.region
        let search = MKLocalSearch(request: req)
        search.start { (response:MKLocalSearch.Response?, error:Error?)
            in
            self.searchCompletionHandler(response: response, err: error)
        }
    }
    
    func searchCompletionHandler(response:MKLocalSearch.Response?, err:Error?) {
        guard let res = response else {
            print(err ?? "-")
            return;
        }
        
        let ann = MKPointAnnotation()
        ann.coordinate = res.mapItems[0].placemark.coordinate
        ann.title = res.mapItems[0].name
        ann.subtitle = res.mapItems[0].phoneNumber
        self.mapView.addAnnotation(ann)
    }
}
