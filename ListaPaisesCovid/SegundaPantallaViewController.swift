//
//  SegundaPantallaViewController.swift
//  ListaPaisesCovid
//
//  Created by mac16 on 28/04/22.
//

import UIKit

class SegundaPantallaViewController: UIViewController {
    @IBOutlet weak var imageFlag: UIImageView!
    @IBOutlet weak var nombrePais: UILabel!
    @IBOutlet weak var numMuertes: UILabel!
    @IBOutlet weak var muertesHoy: UILabel!
    @IBOutlet weak var casosTotales: UILabel!
    @IBOutlet weak var casosActivos: UILabel!
    @IBOutlet weak var casosCriticos: UILabel!
    @IBOutlet weak var casosHoy: UILabel!
    @IBOutlet weak var recuperados: UILabel!
    
    var datosPais: CovidDatos?
    override func viewDidLoad() {
        super.viewDidLoad()
        nombrePais.text = (datosPais?.country) ??  "Nombre Pais"
        numMuertes.text = "Muertes totales: \(datosPais?.deaths! ?? 0)"
        muertesHoy.text = "Muertes de hoy: \(datosPais?.todayDeaths! ?? 0)"
        casosTotales.text = "Casos totales: \(datosPais?.cases! ?? 0)"
        casosActivos.text = "Casos activos: \(datosPais?.active! ?? 0)"
        casosCriticos.text = "Casos crìticos: \(datosPais?.critical! ?? 0)"
        casosHoy.text = "Casos de hoy: \(datosPais?.todayCases! ?? 0)"
        recuperados.text = "Recuperados: \(datosPais?.recovered! ?? 0)"
        // Do any additional setup after loading the view.
        
        if let urlString = datosPais?.countryInfo?.flag{
            if let imagenURL = URL(string: urlString){
                DispatchQueue.global().async {
                    guard let imagenData = try? Data(contentsOf: imagenURL) else {
                        return
                    }
                    let image = UIImage(data: imagenData)
                    DispatchQueue.main.async {
                        self.imageFlag.image = image
                    }
                    
                }
            }
        }
    }
    

}
