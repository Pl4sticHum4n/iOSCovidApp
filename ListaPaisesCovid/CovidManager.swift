//
//  CovidManager.swift
//  ListaPaisesCovid
//
//  Created by mac16 on 25/04/22.
//

import Foundation

protocol covidManagerDelegado {
    func actualizar(paises: [CovidDatos])
}

struct CovidManager {
    var delegado: covidManagerDelegado?
    
    func buscarEstadisticas(){
        let urlString = "https://corona.lmao.ninja/v3/covid-19/countries"
        
        if let url = URL(string: urlString){
            let sesion = URLSession(configuration: .default)
            
            let tarea = sesion.dataTask(with: url) { (datos, respuesta, error) in
                if error != nil {
                    print("Error al buscar informacion: \(error?.localizedDescription)")
                }
                if let datosSeguros = datos{
                    print("Datos Seguros")
                    print(datosSeguros)
                    if let listaPaises = self.parsearJSON(datosCovid: datosSeguros){
                        // Independientemente del delegado, se manda la lista de paises para su libre uso
                        delegado?.actualizar(paises: listaPaises)
                        //print("Paises: \(listaPaises)")
                    }
                }
            }
            tarea.resume()
        }
    }
    func parsearJSON(datosCovid: Data) -> [CovidDatos]? {
        let decodificador = JSONDecoder()
        do{
            let datosDecodificados: [CovidDatos] = try decodificador.decode([CovidDatos].self, from: datosCovid)
            
            //Arrayt de paises del tipo CovidDatos
            let paises: [CovidDatos] = datosDecodificados
            return paises
        }catch{
            print("Error en JSON: \(error.localizedDescription)")
            return nil
        }
    }
}
