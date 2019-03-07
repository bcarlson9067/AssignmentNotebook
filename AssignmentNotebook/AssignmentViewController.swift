//
//  AssignmentViewController.swift
//  AssignmentNotebook
//
//  Created by Bailey Carlson on 2/26/19.
//  Copyright © 2019 John Hersey High School. All rights reserved.
//

import UIKit

class AssignmentViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var classTextField: UITextField!
    
    var date: String = ""
    
    var newAssignment: Assignment = Assignment(title: "", date: "", assignmentClass: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func submitButtonPressed(_ sender: Any) {
        if let newAssignmentTitle = textField.text, newAssignmentTitle != "", let newAssignmentClass = classTextField.text, newAssignmentClass != "" {
            newAssignment = Assignment(title: newAssignmentTitle, date: date, assignmentClass: newAssignmentClass)
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        if let encoded = try?JSONEncoder().encode(newAssignment) {
            UserDefaults.standard.set(encoded, forKey: "newAssignment")
        }
    }
    @IBAction func datePickerChanged(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short
        date = dateFormatter.string(from: datePicker.date)
        print(date)
    }
    
}
