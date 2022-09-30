//
//  ViewController.swift
//  JaqueIngressos
//
//  Created by Jaqueline Hillesheim on 27/09/22.
// @IBOutlet var textFieds: [UITextField]!

import UIKit
import SwiftCurrency


class ViewController: UIViewController, PickerViemMesSelecionado, PickerViewAnoSelecionado, PickerViewNumeroDeParcela {
    
    
    // MARK: Outlets
    
    @IBOutlet weak var imagemBanner: UIImageView!
    @IBOutlet var textFields: [UITextField]!
    @IBOutlet weak var scrollViewPrincipal: UIScrollView!
    @IBOutlet weak var labelValorDasParcelas: UILabel!
    
    var pickerViewMes = PickerViewMes()
    var pickerViemAno = PickerViewAno()
    var pickerViemParcela = PickerViewParcela()
    
    var valorDoIngresso:Double = 199.00
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagemBanner.layer.cornerRadius = 10
        self.imagemBanner.layer.masksToBounds = true
        pickerViewMes.delegate = self
        pickerViemAno.delegate = self
        pickerViemParcela.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(aumentaScrollView(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    // buscado para preencher automatico o bairro e o endereco so botando cep
    func buscaTextField(tipoDeTextField:TiposDeTextField, completion:(_ textFieldSolicitado:UITextField) -> Void) {
        for textField in textFields {
            if let textFieldAtual = TiposDeTextField(rawValue: textField.tag) {
                if textFieldAtual == tipoDeTextField {
                    completion(textField)
                }
            }
        }
    }
    
    @objc func aumentaScrollView(notification:Notification) {
        self.scrollViewPrincipal.contentSize = CGSize(width: self.scrollViewPrincipal.frame.width, height: self.scrollViewPrincipal.frame.height + 350)
        
    }
    
    // MARK: - PickerViewDelegate
    
    func mesSelecionado(mes: String) {
        self.buscaTextField(tipoDeTextField: .mesDeVencimento) { (textFileldMes) in
            textFileldMes.text = mes
        }
    }
    func anoSelecionado(ano: String) {
        self.buscaTextField(tipoDeTextField: .anoDeVencimento) { (texFieldAno) in
            texFieldAno.text = ano
        }
    }
    
    func pickerViewParcelaSelecionada(parcela: String) {
        self.buscaTextField(tipoDeTextField: .parcela) { (textFieldPArcela) in
            textFieldPArcela.text = "\(parcela)x"
            let calculoDaParcela = valorDoIngresso/Double(parcela)!
            
            let formatNumber = String(format: "%.2f", calculoDaParcela)
            self.labelValorDasParcelas.text = "\(parcela)x R$ \(formatNumber) (ou R$199,00 á vista)"
        }
    }
    

    
    
    @IBAction func botaoComprar(_ sender: UIButton) {
        let textFieldsEstaoPreenchidos = ValidaFormulario().verificaTextFieldsPreenchidos(textFields: textFields)
        let textFieldsEstaoValidos = ValidaFormulario().verificaTextFieldsValidos(listaDeTextFields: textFields)
        
        if textFieldsEstaoPreenchidos && textFieldsEstaoValidos {
            present(ValidaFormulario().exibeNotificacaoDeCompraRealizada(), animated: true, completion: nil)
        }
        else {
            present(ValidaFormulario().exibeNotificacaoDePreenchimentoDosTextFields(), animated: true, completion: nil )
        }
    }
    
    // Requisicao do cep e validado os campor do bairro e endereco
    @IBAction func textFieldCepAlterouValor(_ sender: UITextField) {
        guard let cep = sender.text else { return }
        LocalizacaoConsultaAPI().consultaViaCepAPI(cep: cep, sucesso: { (Localizacao) in
            self.buscaTextField(tipoDeTextField: .endereco, completion: { (textFieldEndereco) in
                textFieldEndereco.text = Localizacao.logradouro
            })
            self.buscaTextField(tipoDeTextField: .bairro, completion: { (textFieldBairro) in
                textFieldBairro.text = Localizacao.bairro
            })
        }) { (error) in
            print(error)
        }
    }
    
    @IBAction func texFieldMesEntrouEmFoco(_ sender: UITextField) {
        let pickerView = UIPickerView()
        pickerView.delegate = pickerViewMes
        pickerView.dataSource = pickerViewMes
        sender.inputView = pickerView
    }
    
    
    @IBAction func textFieldAnoEntrouEmFoco(_ sender: UITextField) {
        let pickerViem = UIPickerView()
        pickerViem.delegate = pickerViemAno
        pickerViem.dataSource = pickerViemAno
        sender.inputView = pickerViem
        
    }
    
    @IBAction func textFieldParcelas(_ sender: UITextField) {
        let pickerView = UIPickerView()
        pickerView.delegate = pickerViemParcela
        pickerView.dataSource = pickerViemParcela
        sender.inputView = pickerView
    }
    
    @IBAction func TextFielCodigoDeSeguranca(_ sender: UITextField) {
        guard let texto = sender.text else { return }
        if texto.count > 3 {
            let codigo = texto.suffix(3)
            self.buscaTextField(tipoDeTextField: .codigoDeSeguranca, completion: {(textFieldCodigoSeguranca) in
                textFieldCodigoSeguranca.text = String(codigo)
            })
        }
        else {
            self.buscaTextField(tipoDeTextField: .codigoDeSeguranca, completion: { (textFieldCodigoSeguranca) in
                textFieldCodigoSeguranca.text = texto
            })
        }
        
        
    }
}
