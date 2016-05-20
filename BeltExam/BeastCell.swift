//
//  BeastCell.swift
//  BeltExam
//
//  Created by Michael Arbogast on 5/20/16.
//  Copyright © 2016 Michael Arbogast. All rights reserved.
//

import UIKit

class BeastCell: UITableViewCell {
    var originalView: CellTodoDelegate?
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBAction func beastButtonPressed(sender: UIButton) {
        originalView!.setComplete(self)
    }
}
