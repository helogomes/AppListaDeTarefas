//
//  ViewController.swift
//  ListaDeTarefas
//
//  Created by user218997 on 5/18/22.
//

import UIKit

class TableViewController: UITableViewController {
    
    var tarefas = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tarefas = UserDefaults.standard.stringArray(forKey: "tarefas") ?? []
        
    }

    @IBAction func tapAddButton(_ sender: Any) {
        
        let alert = UIAlertController(title: "Nova tarefa", message: "Insira uma nova tarefa", preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: { tfield in
            tfield.placeholder = "Insira aqui..."
            
        })
        
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Pronto", style: .default, handler: { _ in
            
            if let tfield = alert.textFields?.first{
                if let text = tfield.text, !text.isEmpty{
                    self.tarefas.append(text)
                    
                    self.tableView.insertRows(at: [IndexPath(row: self.tarefas.count - 1, section: 0)], with: .automatic)
                    
                    UserDefaults.standard.set(self.tarefas, forKey: "tarefas")
                }
            }
            
        }))
        
        present(alert, animated: true, completion: nil)
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tarefas.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = tarefas[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let cell = tableView.cellForRow(at: indexPath) else {return}
        
        if cell.accessoryType == .none
        {
        cell.accessoryType = .checkmark
        }else {
            cell.accessoryType  = .none
        }
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let contextualAction = UIContextualAction(style: .destructive, title: "Apagar") { (action ,view ,true) in
            
            self.tarefas.remove(at: indexPath.row)
            
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            
            UserDefaults.standard.set(self.tarefas, forKey: "tarefas")
        }
        
        let actions = UISwipeActionsConfiguration(actions: [contextualAction])
        
        return actions
        
    }
}

	
