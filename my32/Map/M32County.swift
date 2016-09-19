//
//  M32County.swift
//  my32
//
//  Created by James Sadlier on 19/09/2016.
//  Copyright © 2016 NoSad. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import Mapbox

class M32County: UIView {
    
    var boundary:MKGeodesicPolyline!
    
    override init(frame: CGRect) {
        super.init(frame: frame);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createPolyline(mapView: M32MapView) {
        let point1 = CLLocationCoordinate2DMake(-73.761105, 41.017791);
        let point2 = CLLocationCoordinate2DMake(-73.760701, 41.019348);
        let point3 = CLLocationCoordinate2DMake(-73.757201, 41.019267);
        let point4 = CLLocationCoordinate2DMake(-73.757482, 41.016375);
        let point5 = CLLocationCoordinate2DMake(-73.761105, 41.017791);
        
        var points: [CLLocationCoordinate2D]
        points = [point1, point2, point3, point4, point5]
        
        boundary = MKGeodesicPolyline(coordinates: points, count: 5);
    }

}
