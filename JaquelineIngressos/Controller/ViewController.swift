//
//  ViewController.swift
//  JaqueIngressos
//
//  Created by Jaqueline Hillesheim on 27/09/22.
//

import UIKit
import CPF_CNPJ_Validator
class ViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var imagemBanner: UIImageView!
    
    @IBOutlet var textFieds: [UITextField]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagemBanner.layer.cornerRadius = 10
        self.imagemBanner.layer.masksToBounds = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func botaoComprar(_ sender: UIButton) {
        let textFildsEstaoPreenchidos = ValidaFormulario().verificaTextFieldsPreenchidos(textFields: textFieds)
        
        if textFildsEstaoPreenchidos {
            let alerta = ValidaFormulario().exibeNotificacaoDePreenchimentoDosTextFields(titulo: "Parabéns", mensagem: "Compra realizada com sucesso")
            present(alerta, animated: true, completion: nil)
        }
        else {
            let alerta = ValidaFormulario().exibeNotificacaoDePreenchimentoDosTextFields(titulo: "Atenção", mensagem: "Preencha corretamente todos os campos")
            present(alerta, animated: true, completion: nil)
        }
    }
}

