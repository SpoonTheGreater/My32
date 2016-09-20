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
    

}
