//
//  ViewController.swift
//  AssignmentNotebook
//
//  Created by Bailey Carlson on 2/19/19.
//  Copyright © 2019 John Hersey High School. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    var assignments: [Assignment] = []
    var assignmentTitle: String = " "
    var assignmentDueDate: Date? = nil
    var retrievedArray: [Assignment] = []
    var eventNumber = 0
    var sentAssignment: Assignment = Assignment(title: " ", date: " ", assignmentClass: " ")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        let assignment1 = Assignment(title: "math bookwork", date: "04/16/19, 9:30", assignmentClass: "Calc 3")
        let assignment2 = Assignment(title: "read The Invisible Man", date: "03/16/19, 9:30", assignmentClass: "AP Lit")
        let assignment3 = Assignment(title: "physics problem set 9.2", date: "04/16/19, 11:59", assignmentClass: "AP Physics C")
        assignments = [assignment1, assignment2, assignment3]
        retrievedArray = assignments
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return assignments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "myCell") {
            let currentAssignmentName = assignments[indexPath.row].title
            let currentAssignmentDate = assignments[indexPath.row].date
            let currentAssignmentClass = assignments[indexPath.row].assignmentClass
            cell.textLabel?.text = "\(currentAssignmentClass): \(currentAssignmentName)"
            cell.detailTextLabel?.text = "Due: \(currentAssignmentDate)"
            return cell
        }
        else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            assignments.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        eventNumber += 1
        var decodedArray: [Assignment] = []
        if eventNumber > 1 {
            if let object = UserDefaults.standard.array(forKey: "array"){
                for (number, assignment) in object.enumerated() {
                    if let object = UserDefaults.standard.data(forKey: "\(number)"){
                        if let objectDecoded = try?JSONDecoder().decode(Assignment.self, from: object) as Assignment {
                            decodedArray.append(objectDecoded)
                            assignments = decodedArray
                        }
                    }
                }
            }
        }
        
        var retrievedAssignment: Assignment
        if let object = UserDefaults.standard.data(forKey: "newAssignment"){
            if let objectDecoded = try?JSONDecoder().decode(Assignment.self, from: object) as Assignment {
                retrievedAssignment = objectDecoded
                assignments.append(retrievedAssignment)
                tableView.reloadData()
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        var encodedArray: [Data] = []
        for (number, assignment) in assignments.enumerated() {
            if let encoded = try?JSONEncoder().encode(assignment) {
                UserDefaults.standard.set(encoded, forKey: "\(number)")
                encodedArray.append(encoded)
            }
        }
        UserDefaults.standard.set(encodedArray, forKey: "array")
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "detailsSegue" {
//            let nvc = segue.destination as! DetailsViewController
//            if let indexPath = tableView.indexPathForSelectedRow {
//                sentAssignment = assignments[indexPath.row]
//                print(sentAssignment.title)
//                print(sentAssignment.date)
//                print(sentAssignment.assignmentClass)
//                nvc.passedAssignment = sentAssignment
//            }
//        }
//    }
}
