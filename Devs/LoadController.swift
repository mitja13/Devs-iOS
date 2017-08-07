//
//  Created by Mitja Semolic on 31/07/2017.
//  Copyright © 2017 Mitja Semolic. All rights reserved.
//

import UIKit

class LoadController: UIViewController {

// MARK: - Properties

    let languages = ["JavaScript", "Java", "Python", "Ruby", "PHP", "C++", "C#", "C", "Go", "Objective C", "Scala", "Swift", "Haskell", "HTML", "CSS", "R", "VimL", "Shell", "Perl", "Rust", "CoffeeScript", "TypeScript", "TeX", "Emacs Lisp", "Lua", "Clojure", "Matlab", "Arduino", "Erlang", "Visual Basic"]
    
    var selectedLanuage = "JavaScript"
    var searchString: String?
    
// MARK: - IBOutlet
    
    @IBOutlet weak var viewListButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var languagePicker: UIPickerView!
    
// MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        
        #if BLUE
        view.backgroundColor = UIColor.blue
        #endif
        
        languagePicker.delegate = self
        languagePicker.dataSource = self
        viewListButton.layer.cornerRadius = 8
        viewListButton.layer.borderWidth = 1
        viewListButton.layer.borderColor = viewListButton.tintColor.cgColor
        self.title = "Language"
        self.navigationItem.titleView = UIView()
        
        loadDevelopersCount()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
// MARK: - IBAction
    
    @IBAction func viewListPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "ShowList", sender: nil)
    }
    
// MARK: - Load
    
    func loadDevelopersCount() {
        activityIndicator.startAnimating()
        
        searchString = "language:\(selectedLanuage) sort:followers"
        let query = SearchUsersQuery(searchString: searchString!)
        
        apollo.fetch(query: query) { result, error in
            self.activityIndicator.stopAnimating()
            
            if let error = error {
                print("error: fatching github query, \(error.localizedDescription)")
                return
            }
            
            guard let data = result?.data else { return }
            let totalDevelopers = formatNumber(from: data.search.userCount)
            
            self.totalLabel.text = "\(totalDevelopers) developers"
            self.totalLabel.isHidden = false
            self.viewListButton.isHidden = false
        }
    }
}

// MARK: - UIPickerView

extension LoadController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return languages.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return languages[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedLanuage = languages[row]
        
        loadDevelopersCount()
    }
}

// MARK: - Navigation

extension LoadController {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowList" {
            let listController = segue.destination as! ListController
            listController.searchString = self.searchString
            listController.title = selectedLanuage
        }
    }
}

