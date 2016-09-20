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

class ViewController: UIViewController, MKMapViewDelegate, MGLMapViewDelegate {
    
    @IBOutlet weak var showLimerick: UIButton!
    @IBOutlet var mapView: M32MapView!
    
    
    var limerick:MGLMultiPolygon!
    var polygonShapes:NSMutableArray!
    var polygonLines:NSMutableArray!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        drawPolyline()
        mapView.delegate = self
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
    
    @IBAction func highlightLimerick(_ sender: AnyObject) {
        for polyShapeIndex in 0...(self.polygonShapes.count-1)
        {
            let polyShape:MGLPolygon = self.polygonShapes.object(at:polyShapeIndex) as! MGLPolygon
            polyShape.title = "Limerick"
            polyShape.subtitle = "yt"
            
            print(polyShape)
            print(self.mapView)
            self.mapView.addAnnotation(polyShape)
        }
        
        var coordinates: [CLLocationCoordinate2D] = []
        let first = CLLocationCoordinate2DMake( 52.6680, 8.6305)
        let last = CLLocationCoordinate2DMake( 51.8969, 8.4863)
        
        coordinates.append(first)
        coordinates.append(last)

//        let line:MGLPolyline = MGLPolyline(coordinates: &coordinates, count: 2);
//        line.title = "Limerick"
//        line.subtitle = "Cork"
//        self.mapView.addAnnotation(line)
//        for polygonLinesIndex in 0...(self.polygonLines.count-1)
//        {
//            let polyShape:MGLPolyline = self.polygonLines.object(at:polygonLinesIndex) as! MGLPolyline
//            polyShape.title = "lk"
//            polyShape.subtitle = "yt"
//            print(polyShape)
//            print(self.mapView)
//            self.mapView.addAnnotation(polyShape)
//        }
    //    for poly as !MGLPolygon in self.limerick
      //      self.mapView.add(poly)
        
        //self.mapView.addAnnotation(self.limerick)
    }
    
    func drawPolyline() {
        // Parsing GeoJSON can be CPU intensive, do it on a background thread
        //DispatchQueue.global().async {
            // Get the path for example.geojson in the app's bundle //"counties"
            let jsonPath = Bundle.main.path(forResource: "Limerick", ofType: "geojson")
            let jsonData = NSData(contentsOfFile: jsonPath!)
             
            do {
                // Load and serialize the GeoJSON into a dictionary filled with properly-typed objects
                if let jsonDict = try JSONSerialization.jsonObject(with: jsonData! as Data, options: []) as? NSDictionary {
                    
                    // Load the `features` array for iteration
                    if let features = jsonDict["features"] as? NSArray {
                        for feature in features {
                            if let feature = feature as? NSDictionary {
                                if let geometry = feature["geometry"] as? NSDictionary {
                                    print(geometry["type"])
                                    
                                    if geometry["type"] as? String == "MultiPolygon" {
                                        // Create an array to hold the formatted coordinates for our line
                                        var coordinates: [CLLocationCoordinate2D] = []
                                        self.polygonShapes = []
                                        self.polygonLines = []
                                        if let polygons = geometry["coordinates"] as? NSArray {
                                            let polygons = polygons.firstObject as! NSArray
                                            for polyIndex in 0...(polygons.count-1)
                                            {
                                                print(polyIndex);
                                                print( polygons.object(at:polyIndex) );
                                                let location:NSArray = polygons.object(at:polyIndex) as! NSArray
                                                
                                                for pointIndex in 0...(location.count-1)
                                                {
                                                    let point:NSArray = location.object(at: pointIndex) as! NSArray
                                                    let coordinate = CLLocationCoordinate2DMake( point[1] as! Double, point[0] as! Double)
                                                    coordinates.append(coordinate)
                                                }
                                                let polygonLine = MGLPolyline(coordinates: &coordinates, count: UInt(coordinates.count));
                                                
                                                self.polygonLines.add(polygonLine)
                                                
                                                let polygonShape = MGLPolygon(coordinates: &coordinates, count: UInt(coordinates.count), interiorPolygons: nil);
                                                self.polygonShapes.add(polygonShape)
                                            }
                                        }
                                        
                                        //self.limerick = MGLMultiPolygon(polygons: polygonShapes)
                                        //self.limerick.title = "Limerick"
                                        //self.limerick.subtitle = "Yurt!"
                                        //print(self.limerick)
                                       // let line = MGLPolyline(coordinates: &coordinates, count: UInt(coordinates.count))
                                        
                                        // Optionally set the title of the polyline, which can be used for:
                                        //  - Callout view
                                        //  - Object identification
                                        //line.title = "Crema to Council Crest"
                                        
                                        
                                        
                                        // Add the annotation on the main thread
                                        DispatchQueue.main.async {
                                            //do{
                                                // Unowned reference to self to prevent retain cycle
                                                //[unowned self] in
                                            
                                            //}
                                            //catch
                                            //{
                                              //  print("Error adding annotation")
                                           // }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            catch
            {
                print("GeoJSON parsing failed")
            }
       // }
    }
    
    func mapView(_ mapView: MGLMapView, alphaForShapeAnnotation annotation: MGLShape) -> CGFloat {
        // Set the alpha for all shape annotations to 1 (full opacity)
        return 1
    }
    
    func mapView(_ mapView: MGLMapView, lineWidthForPolylineAnnotation annotation: MGLPolyline) -> CGFloat {
        // Set the line width for polyline annotations
        return 2.0
    }
    
    func mapView(_ mapView: MGLMapView, strokeColorForShapeAnnotation annotation: MGLShape) -> UIColor {
        // Give our polyline a unique color by checking for its `title` property
        if (annotation.title == "Limerick" && annotation is MGLPolygon) {
            
            return UIColor(red: 145/255, green:171/255, blue:61/255, alpha:1)
        }
        else
        {
            return UIColor.red
        }
    }
    
    private func mapview(mapView: MGLMapView, fillColorForShapeAnnotation annotation: MGLShape) -> UIColor {
        // Give our polyline a unique color by checking for its `title` property
        if (annotation.title == "Limerick" && annotation is MGLPolygon) {
            
            return UIColor(red: 145/255, green:171/255, blue:61/255, alpha:1)
        }
        else
        {
            return UIColor.red
        }
    }

    
}

