//
//  ViewController.swift
//  ListaPaisesCovid
//
//  Created by mac16 on 25/04/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tablaPaises: UITableView!
    
    //Instancia del covidManager
    var covidManager = CovidManager()
    
    //Arreglo para llenbar la tabla
    var listaPaises: [CovidDatos] = []
    var paisSeleccionado: CovidDatos?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //registrar la celda
        tablaPaises.register(UINib(nibName: "CeldaPaisTableViewCell", bundle: nil), forCellReuseIdentifier: "celda")
        
        // Delegados de la tabla
        tablaPaises.delegate = self
        tablaPaises.dataSource = self
        
        covidManager.delegado = self
        covidManager.buscarEstadisticas()
        
    }
    
    /*func buscarEstadisticas(){
            
        if let url = URL(string: urlString){
            DispatchQueue.global().async {
                if let imagenData = try? Data(contentsOf: url){
                    let imagen = UIImage(data: imagenData)
                    
                    DispatchQueue.async{
                        // actualizar imaen de la celda
                    }
                }
            }
        }
    }*/

}

//Table View

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaPaises.count
    }
    //Para agregar la celda personalizada se agrega el as! CeldaPaisTableView al crear la celda
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tablaPaises.dequeueReusableCell(withIdentifier: "celda", for: indexPath) as! CeldaPaisTableViewCell
        
        celda.nombrePaisLabel.text = listaPaises[indexPath.row].country
        celda.activosLabel.text = "Casos Activos: \(listaPaises[indexPath.row].active ?? 0)"
        celda.recuperadosLabel.text = "Recuperados: \(listaPaises[indexPath.row].recovered ?? 0)"
        
        //Mostrar la imagen de la Api
        if let urlString = listaPaises[indexPath.row].countryInfo?.flag{
            if let imagenURL = URL(string: urlString){
                DispatchQueue.global().async {
                    guard let imagenData = try? Data(contentsOf: imagenURL) else {
                        return
                    }
                    let image = UIImage(data: imagenData)
                    DispatchQueue.main.async {
                        celda.banderaPais.image = image
                    }
                    
                }
            }
        }
        //celda.imageView?.image = UIImage(systemName: "flag")
        return celda
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        paisSeleccionado = listaPaises[indexPath.row]
        performSegue(withIdentifier: "verPais", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "verPais"{
            let objetoDestino = segue.destination as! SegundaPantallaViewController
            objetoDestino.datosPais = paisSeleccionado
        }
    }
    
}

extension ViewController: covidManagerDelegado{
    func actualizar(paises: [CovidDatos]) {
        print("Numero de paises: \(paises.count)")
        listaPaises = paises
        
        //Actualizar UI desde algo en segundo plano
        DispatchQueue.main.async {
            self.tablaPaises.reloadData()
        }
    }
    
    
}
