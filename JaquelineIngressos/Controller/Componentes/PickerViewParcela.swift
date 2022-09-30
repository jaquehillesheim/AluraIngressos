//
//  PickerViewParcela.swift
//  JaquelineIngressos
//
//  Created by Jaqueline Hillesheim on 30/09/22.
//

import UIKit

protocol PickerViewNumeroDeParcela {
    func pickerViewParcelaSelecionada(parcela:String)
}

class PickerViewParcela: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var delegate:PickerViewNumeroDeParcela?
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 12
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row+1)x"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if delegate != nil {
            delegate?.pickerViewParcelaSelecionada(parcela: "\(row+1)")
        }
    }
    

}
