//
//  my32MapView.swift
//  my32
//
//  Created by James Sadlier on 05/09/2016.
//  Copyright © 2016 NoSad. All rights reserved.
//

import Foundation
import MapKit

class my32MapView : MKMapView {
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setupTiles()
    }
    
    func setupTiles() {
        //&layers=B00FFFFFFF
        let template = "http://tile.openstreetmap.org/{z}/{x}/{y}.png"
        
        let overlay = MKTileOverlay(URLTemplate: template)
        overlay.canReplaceMapContent = true
        
        self.addOverlay(overlay, level: .AboveLabels)
    }
    
}