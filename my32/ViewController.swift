//
//  ViewController.swift
//  my32
//
//  Created by James Sadlier on 05/09/2016.
//  Copyright © 2016 NoSad. All rights reserved.
//

import UIKit
import MapKit
import Mapbox

class ViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet var mapView: M32MapView!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let testCounty = M32County();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        guard let tileOverlay = overlay as? MKTileOverlay else {
            return MKOverlayRenderer()
        }
        
        return MKTileOverlayRenderer(tileOverlay: tileOverlay)
    }
    
    func tryHighlightLimerick()  {
        
    }
}

