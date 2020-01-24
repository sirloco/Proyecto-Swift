//
//  ViewController.swift
//  Agotador
//
//  Created by  on 17/01/2020.
//  Copyright © 2020 relar. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var mapa: MKMapView!
    
    let loc = CLLocationManager()
    let regionEnMetros: Double = 10000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        compruebaServicioLoc()
    }
    
    func posiciona(){
        
        loc.delegate = self
        loc.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    //Comprueba si el servicio de localización está activado
    func compruebaServicioLoc(){
        
        if CLLocationManager.locationServicesEnabled(){
            posiciona()
            estadoPermisos()
        } else {
            //está desactivado puedo avisar pa que lo active aqui
        }
    }
    
    func centraPosicionUsuario(){
        if let localizacion = loc.location?.coordinate{
            let region = MKCoordinateRegion.init(center: localizacion, latitudinalMeters: regionEnMetros, longitudinalMeters: regionEnMetros)
            mapa.setRegion(region, animated: true)
        }
    }
    
    func estadoPermisos(){
        
        switch CLLocationManager.authorizationStatus() {
        
        //la aplicacion tiene permiso para usar la localizacion mientras se usa
        case .authorizedWhenInUse:
            mapa.showsUserLocation = true
            centraPosicionUsuario()
            break
            
        case .denied:
            //la aplicacion no tiene permisos
            break
            
        case .notDetermined:
            loc.requestWhenInUseAuthorization()//pide estado
            break
            
        case .restricted:
            //los padres seguro que le han bloqueado la aplcacion
            break
            
        case .authorizedAlways:
            //tiene permisos aunque no esté abierta
            break
            
        }
    }
    

}

extension ViewController: CLLocationManagerDelegate{
    
    func loc(_ gestiona: CLLocationManager, seMueve:[CLLocation]){
        
        //codigo de la localizacion
        
    }
    
    func loc(_ gestiona: CLLocationManager, estado: CLAuthorizationStatus){
        
        // estado
    }
}

