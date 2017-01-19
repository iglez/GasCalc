//
//  ViewController.swift
//  GasolineraCalc
//
//  Created by ivan gonzalez on 1/18/17.
//  Copyright © 2017 personal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tipoGasolina: UISegmentedControl!
    @IBOutlet weak var precioXLitro: UITextField!
    @IBOutlet weak var total: UITextField!
    @IBOutlet weak var ieps: UITextField!
    @IBOutlet weak var iva: UITextField!
    
    @IBOutlet weak var litrosLabel: UILabel!
    @IBOutlet weak var ivaLabel: UILabel!
    @IBOutlet weak var iepsLabel: UILabel!
    @IBOutlet weak var subTotalLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    var pagatotal: Double = 0.0
    var precioxLitro: Double = 0.0
    var porcentajeieps: Double = 0.0
    var porcentajeIVA: Double = 0.0
    var totalLitros: Double = 0.0
    var precioLitroSinIVA: Double = 0.0
    var importeIVA: Double = 0.0
    var importeIEPS: Double = 0.0
    var importeSubTotal: Double = 0.0
    var importeTotal: Double = 0.0
    
    @IBAction func onChangeTipoGasolina(_ sender: Any) {
        establecerIEPS()
    }
    
    func establecerIEPS(){
        //TODO: cargar ieps desde la "nube"
        switch tipoGasolina.selectedSegmentIndex {
        case 0:
            ieps.text = "38.00"
        case 1:
            ieps.text = "46.37"
        case 2:
            ieps.text = "31.54"
        default:
            ieps.text = "0"
        }
    }
    
    @IBAction func calcular(_ sender: Any) {
        //vargando variables
        if let tempDouble = Double(total.text!){
            pagatotal = tempDouble
        }
        
        if let tempDouble = Double(precioXLitro.text!){
            precioxLitro = tempDouble
        }
        
        if let tempDouble = Double(ieps.text!){
            porcentajeieps = tempDouble
        }
        
        if let tempDouble = Double(iva.text!){
            porcentajeIVA = tempDouble
        }
        
        //validaciones
        if (pagatotal <= 0){
            errorLabel.text = "Favor de especificar el total de pago"
            return
        }
        
        if (precioxLitro <= 0){
            errorLabel.text = "Favor de especificar el precio por litro"
            return
        }
        
        if (porcentajeieps <= 0){
            errorLabel.text = "Favor de especificar el impuesto de IEPS"
            establecerIEPS()
            return
        }
        
        if (porcentajeIVA <= 0){
            errorLabel.text = "Favor de especificar el porcentaje de IVA"
            iva.text = "16"
            return
        }
        
        if (errorLabel.text != ""){
            errorLabel.text = ""
        }
        
        //realizando calculos
        porcentajeIVA = porcentajeIVA / 100
        porcentajeieps = porcentajeieps / 100
        
        totalLitros = pagatotal / precioxLitro
        
        precioLitroSinIVA = (precioxLitro - porcentajeieps) / (1+porcentajeIVA)
        
        importeIVA = totalLitros * precioLitroSinIVA * porcentajeIVA
        
        importeIEPS = totalLitros * porcentajeieps
        
        importeSubTotal = totalLitros * precioLitroSinIVA
        
        importeTotal = importeSubTotal + importeIVA + importeIEPS
      
        //desplegando valores
        litrosLabel.text = String(format:"%.4f", totalLitros)
        ivaLabel.text = String(format:"%.4f", importeIVA)
        iepsLabel.text = String(format:"%.4f", importeIEPS)
        subTotalLabel.text = String(format:"%.4f", importeSubTotal)
        totalLabel.text = String(format:"%.2f", importeTotal)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        establecerIEPS()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

