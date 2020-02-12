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
    @IBOutlet weak var lsegundos: UILabel!
    @IBOutlet weak var ltiempo: UILabel!
    @IBOutlet weak var lminutos: UILabel!
    @IBOutlet weak var lhoras: UILabel!
    
    @IBAction func empezar(_ sender: Any) {ruta = !ruta}
    
    @IBOutlet weak var mapa: MKMapView!
    
    var ruta = false
    var contando = false
    var puntos = [CLLocationCoordinate2D]()
    let loc = CLLocationManager()
    let regionEnMetros: Double = 100
  
    
    var tiempo = Timer()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        compruebaServicioLoc()
    }
    
    func posiciona(){
        
        loc.delegate = self
        mapa.delegate=self
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
            loc.startUpdatingLocation()
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
    
 var segundos = 0
 @objc func contador(){

    segundos += 1
    ltiempo.text = tiempoString(time: TimeInterval(segundos))
        
 }

}

extension ViewController: CLLocationManagerDelegate{
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let ultimaLocalizacion = locations.last else {return}
        
        let centro = CLLocationCoordinate2D(latitude: ultimaLocalizacion.coordinate.latitude, longitude: ultimaLocalizacion.coordinate.longitude)
        
        let region = MKCoordinateRegion.init(center: centro, latitudinalMeters: regionEnMetros, longitudinalMeters: regionEnMetros)
        
        
        if (ruta) {
            puntos.append(centro)
            print(centro)
            addPolyLineToMap(locations: puntos)
        
            //esto es una movida del copon el timer en si mismo es recursivo
            if (!contando){
            tiempo = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(contador), userInfo: nil, repeats: true)
                contando = !contando

            }
            

        }else{
            puntos.removeAll()
            tiempo.invalidate()
        }
        
        mapa.setRegion(region, animated: true)
        
    }
    
    func addPolyLineToMap(locations: [CLLocationCoordinate2D])
    {

        let polyline = MKPolyline(coordinates: locations, count: locations.count)
        self.mapa.addOverlay(polyline)
    }
    
}

extension ViewController:MKMapViewDelegate {
      func mapView(_ mapView: MKMapView!, rendererFor overlay: MKOverlay!) -> MKOverlayRenderer! {
        if (overlay is MKPolyline) {
            let pr = MKPolylineRenderer(overlay: overlay);
            pr.strokeColor = UIColor.red.withAlphaComponent(0.5);
            pr.lineWidth = 5;
            return pr;
        }

        return nil
    }

}

func tiempoString(time:TimeInterval) -> String {
    let horas = Int(time) / 3600
    let minutos = Int(time) / 60 % 60
    let segundos = Int(time) % 60
    return String(format:"%02d:%02d:%02d", horas, minutos, segundos)
}


