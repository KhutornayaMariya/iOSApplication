//
//  PostViewController.swift
//  Navigation
//
//  Created by Mariia Khutornaia on 20.04.2022.
//

import UIKit
import MapKit
import CoreLocation

class PostViewController: UIViewController {

    private var locationManager: CLLocationManager!
    private var routePolyline: MKOverlay!

    private lazy var mapView: MKMapView = {
        let view = MKMapView()

        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        if #available(iOS 16.0, *) {
            view.preferredConfiguration = MKHybridMapConfiguration(elevationStyle: .flat)
        } else {
            // Fallback on earlier versions
        }

        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        setUpLocationManager()
        setUpPins()
    }

    private func setUp() {
        view.backgroundColor = .white
        setUpNavigationBar()

        view.addSubview(mapView)

        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func setUpNavigationBar() {
        let infoButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "info"),
            style: UIBarButtonItem.Style.plain,
            target: self,
            action: #selector(openInfoButtomSheet)
        )
        navigationItem.rightBarButtonItem = infoButtonItem
    }

    private func setUpLocationManager() {
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager = locationManager
    }

    private func setUpPins() {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: 55.73, longitude: 37.61)
        annotation.title = "My pin"
        mapView.addAnnotation(annotation)
    }

    private func addDirections(coordinate: CLLocationCoordinate2D) {
        if let routePolyline = routePolyline {
            self.mapView.removeOverlay(routePolyline)
        }

        let request = MKDirections.Request()
        request.transportType = .automobile

        let sourcePlacemark = MKPlacemark(coordinate: coordinate)
        request.source = MKMapItem(placemark: sourcePlacemark)
        print(mapView.userLocation.coordinate)

        let destinationPlacemark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 59.9, longitude: 30.3))
        request.destination = MKMapItem(placemark: destinationPlacemark)

        let direction = MKDirections(request: request)

        direction.calculate { [weak self] response, error in
            guard let self = self else { return }

            guard let response = response else {
                if let error = error {
                    print(error)
                }
                return
            }

            guard let route = response.routes.first else { return }

            self.routePolyline = route.polyline
            self.mapView.addOverlay(self.routePolyline, level: .aboveRoads)

            let rect = route.polyline.boundingMapRect
            self.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
        }
    }
    
    @objc
    private func openInfoButtomSheet() {
        present(InfoViewController(), animated: true, completion: nil)
    }
}

extension PostViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            print("notDetermined")
            manager.requestWhenInUseAuthorization()

        case .restricted:
            print("restricted")
            break

        case .denied:
            print("deined")
            break

        case .authorizedAlways, .authorizedWhenInUse:
            print("authorized")
            manager.requestLocation()
            mapView.showsUserLocation = true
            mapView.showsCompass = true
            mapView.showsScale = true
            manager.startUpdatingLocation()

        @unknown default:
            fatalError()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }

        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
        addDirections(coordinate: location.coordinate)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

extension PostViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let render = MKPolylineRenderer(overlay: overlay)
        render.strokeColor = .systemBlue
        render.lineWidth = 4.0
        return render
    }
}
