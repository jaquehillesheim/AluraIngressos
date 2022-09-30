//
//  ValidaFormulario.swift
//  JaqueIngressos
//
//  Created by Jaqueline Hillesheim on 27/09/22.
//// 01967336008

import UIKit
import CPF_CNPJ_Validator
import CreditCardValidator
import CreditCardValidator

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
    case parcela = 11
    
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
    
        // Criando o dicionario vereficando validacao do CPF usando biblioteca externa
    func verificaTextFieldsValidos(listaDeTextFields:Array<UITextField>) -> Bool {
        var dicionarioDeTextFields:Dictionary<TiposDeTextField, UITextField> = [:]
        
        for textField in listaDeTextFields {
            if let tiposTextField = TiposDeTextField(rawValue: textField.tag) {
                dicionarioDeTextFields[tiposTextField] = textField
            }
        }
        //"\(numeroDoCartao.text!)"
        guard let cpf = dicionarioDeTextFields[.cpf], BooleanValidator().validate(cpf: cpf.text!) else { return false }
        guard let email = dicionarioDeTextFields[.email], self.verifivaEmail(email: email.text!) else {return false}
        
        guard let numeroDoCartao = dicionarioDeTextFields[.numeroDoCartao], CreditCardValidator(numeroDoCartao.text!).isValid else { return false }
        
        return true
        
    }
        // validacao do fortado do email - utilizando RegEx
    func verifivaEmail(email:String) -> Bool {
        let emailRegEx = "(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"+"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"+"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"+"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"+"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"+"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"+"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        
        
        let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
        
        return emailTest.evaluate(with: email)

    }
    
    func exibeNotificacaoDePreenchimentoDosTextFields() -> UIAlertController {
        let notificacao = UIAlertController(title: "Atenção", message: "Preencha corretamente os campos", preferredStyle: .alert)
        let botao = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        notificacao.addAction(botao)
        
        return notificacao
    }
    
    func exibeNotificacaoDeCompraRealizada() -> UIAlertController {
        let notificacao = UIAlertController(title: "Parabens", message: "Compra realizada com sucesso", preferredStyle: .alert)
        let botao = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        notificacao.addAction(botao)
        
        return notificacao
    }
}
