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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
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
            saveAssignments()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        retrieveAssignments()
        var retrievedAssignment: Assignment
        if let object = UserDefaults.standard.data(forKey: "newAssignment"){
            if let objectDecoded = try?JSONDecoder().decode(Assignment.self, from: object) as Assignment {
                if objectDecoded.title != "" {
                    retrievedAssignment = objectDecoded
                    if assignments.contains(where: { $0.title == "\(objectDecoded.title)" }) == false {
                        assignments.append(retrievedAssignment)
                    }
                }
            }
        }
        tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if assignments.count != 0 {
            saveAssignments()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailsSegue" {
            let nvc = segue.destination as! DetailsViewController
            if let indexPath = tableView.indexPathForSelectedRow {
                let sentAssignment = assignments[indexPath.row]
                print(sentAssignment.title)
                print(sentAssignment.date)
                print(sentAssignment.assignmentClass)
                nvc.passedAssignment = sentAssignment
            }
        }
    }
    func saveAssignments() {
        if let encoded = try? JSONEncoder().encode(assignments) {
            UserDefaults.standard.set(encoded, forKey: "Assignments")
        }
    }
    func retrieveAssignments() {
        if let object = UserDefaults.standard.data(forKey: "Assignments"){
            if let objectDecoded = try?JSONDecoder().decode([Assignment].self, from: object) as [Assignment] {
                assignments = objectDecoded
                tableView.reloadData()
            }
        }
    }
}
