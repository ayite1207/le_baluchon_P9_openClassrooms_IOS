//
//  LanguagesTableViewController.swift
//  LeBaluchon
//
//  Created by ayite on 24/11/2020.
//

import UIKit

class LanguagesTableViewController: UITableViewController {
    
    //  MARK:- propriété
    
    var languages :  Languages?
  
    var delegate : DisplayViewControllerDelegate?
    
    @IBOutlet weak var languageLabel: UILabel!
    
    //  MARK:- cycle life
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return languages?.data.languages.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "languagesCell", for: indexPath)
        
        if let language = languages?.data.languages[indexPath.row].name {
            cell.textLabel?.text = language
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        guard let name = languages?.data.languages[indexPath.row].name, let language = languages?.data.languages[indexPath.row].language else { return}
            
            self.delegate?.languageRecovery(name : name, language: language )
                    dismiss(animated: true, completion: nil)
                
    }
}

protocol DisplayViewControllerDelegate : NSObjectProtocol{
    func languageRecovery(name: String, language : String)
}
