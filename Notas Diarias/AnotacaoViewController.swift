//
//  AnotacaoViewController.swift
//  Notas Diarias
//
//  Created by Fabiano De Souza Pereira on 12/03/22.
//

import UIKit
import CoreData

class AnotacaoViewController: UIViewController {
   
    @IBOutlet weak var texto: UITextView!
    var context: NSManagedObjectContext!
    var anotacao: NSManagedObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.texto.becomeFirstResponder()
        
        if anotacao != nil {
            if let textoRecuperado = anotacao.value(forKey: "texto"){
                self.texto.text = String(describing: textoRecuperado)
            }
            
        }else{
            
            self.texto.text = ""
        }
        

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        
    }
    
    
    @IBAction func Salvar(_ sender: Any) {
        
        if anotacao != nil {
            atualizarAnotacao()
        }else{
            savarAnotacao()
        }
        
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func atualizarAnotacao(){
        anotacao.setValue(self.texto.text, forKey: "texto")
        anotacao.setValue(Date(), forKey: "data")
        
        do {
            try context.save()
            print("Sucesso ao atualizar a anotação.")
        } catch let erro {
            print("Erro ao atualizar anotação  \(erro.localizedDescription)")
        }
    }
    
    func savarAnotacao(){
        let anotacao = NSEntityDescription.insertNewObject(forEntityName: "Anotacao", into: context)
        anotacao.setValue(self.texto.text, forKey: "texto")
        anotacao.setValue(Date(), forKey: "data")
        
        do {
            try context.save()
            print("Sucesso ao salvar a anotação.")
        } catch let erro {
            print("Erro ao salvar anotação  \(erro.localizedDescription)")
        }
        
    }

}
