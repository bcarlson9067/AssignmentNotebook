//
//  DetailsViewController.swift
//  AssignmentNotebook
//
//  Created by Bailey Carlson on 2/27/19.
//  Copyright © 2019 John Hersey High School. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var classLabel: UILabel!
    var passedAssignment: Assignment!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = passedAssignment.title
        dateLabel.text = passedAssignment.date
        classLabel.text = passedAssignment.assignmentClass
    }
}
