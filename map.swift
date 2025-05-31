import UIKit
import GoogleMaps

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //view.backgroundColor = .black // optional

       
        let camera = GMSCameraPosition.camera(
            withLatitude: 13.0827,
            longitude: 80.2707,
            zoom: 12.0
        )

        
        let mapView = GMSMapView(frame: view.bounds, camera: camera)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(mapView)

       
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 13.0827, longitude: 80.2707)
        marker.title = "Chennai"
        marker.snippet = "Tamil Nadu"
        marker.map = mapView
    }
}
