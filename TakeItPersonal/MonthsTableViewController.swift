//
//  MonthsTableViewController.swift
//  TakeItPersonal
//
//  Created by Andres Gutierrez on 12/10/21.
//

import UIKit
import RealmSwift
class MonthsTableViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var datesArray: Results<Months>?
    
    var textField = UITextField()
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    load()
    }
    //MARK: - TableView DataSource Methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let label = datesArray?[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: "MonthsCell", for: indexPath)
        cell.textLabel?.text = label?.dates ?? "No Months Added yet"
        
        return cell
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datesArray?.count ?? 1
    }
    
    //MARK: - Add New Dates

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add Month", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { action in
            let newDate = Months()
            newDate.dates = self.textField.text!
            self.save(date: newDate)
          // print("THISSSSS is the output : \(self.textField.text)")
            self.load()
        }
        
        alert.addAction(action)
        alert.addTextField { alertTextField in
            
            alertTextField.placeholder = "Add New Month"
            
            
            
            let toolBar = UIToolbar()
            toolBar.sizeToFit()
            
            let barButton = UIBarButtonItem(barButtonSystemItem: .done, target: self,
                                            action: #selector (self.doneSelectingDate))
            toolBar.setItems([barButton], animated: true)
            
            alertTextField.inputAccessoryView = toolBar
           alertTextField.inputView = self.datePicker
            self.datePicker.preferredDatePickerStyle = .wheels
            self.datePicker.datePickerMode = .date
            self.textField = alertTextField
            
        }
        present(alert, animated: true, completion: nil)
        
        
        
    }

    //MARK: - Functions
    func save(date: Months){
    do{
        try realm.write(){
        realm.add(date)
        }
    }catch{
        print("Error saving Category: \(error)")
    }
        tableView.reloadData()
    }
    
    func load(){
        
        datesArray = realm.objects(Months.self)
        
        tableView.reloadData()
    }
    
    
    
    @objc func doneSelectingDate(){
        //date formatter
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        textField.text = formatter.string(from: datePicker.date)
       self.view.endEditing(true)
   }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToLedger", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TransactionTableViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedMonth = datesArray?[indexPath.row]
        }
    }
    
}
