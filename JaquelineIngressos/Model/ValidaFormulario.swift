//
//  ValidaFormulario.swift
//  JaqueIngressos
//
//  Created by Jaqueline Hillesheim on 27/09/22.
//

import UIKit

enum TiposDeTextField: Int {
    case nomeCompleto = 1
    case email = 2
    case cpf = 3
    case cep = 4
    case endereco = 5
    case bairro = 6
    case numeroDoCartao = 7
    case mesDeVencimento = 8
    case anoDeVencimento = 9
    case codigoDeSeguranca = 10
    
}

class ValidaFormulario: NSObject {
    
    func verificaTextFieldsPreenchidos(textFields:Array<UITextField>) -> Bool {
        var texTextFieldsEstaoPreenchidos = true
        
    
        for textField in textFields {
            if textField.text == "" {
                texTextFieldsEstaoPreenchidos = false
            }
            else {
                texTextFieldsEstaoPreenchidos = true
            }
        }
        return texTextFieldsEstaoPreenchidos
    }
    
    func exibeNotificacaoDePreenchimentoDosTextFields(titulo:String, mensagem:String) -> UIAlertController {
        let notificacao = UIAlertController(title: titulo, message: mensagem, preferredStyle: .alert)
        let botao = UIAlertAction(title: "OK", style: .default, handler: nil)
        notificacao.addAction(botao)
        
        return notificacao
    }
}
