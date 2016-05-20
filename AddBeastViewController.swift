//
//  AddBeastViewController.swift
//  BeltExam
//
//  Created by Michael Arbogast on 5/20/16.
//  Copyright © 2016 Michael Arbogast. All rights reserved.
//

import UIKit

class AddBeastViewController: UIViewController {
    
    var delegate: CellTodoDelegate?
    var beastToEdit: Beast?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(delegate)
        if beastToEdit != nil {
            textFieldOutlet.text = beastToEdit!.name
            navBar.title = "Edit Beast"
        }
    }
    
    @IBOutlet weak var textFieldOutlet: UITextField!
    
    @IBOutlet weak var navBar: UINavigationItem!
    
    @IBAction func cancelButtonPressed(sender: UIBarButtonItem) {
        delegate?.cancelDelegateFunction()
    }
    
    @IBAction func doneButtonPressed(sender: UIBarButtonItem) {
        print(textFieldOutlet.text)
        if textFieldOutlet.text?.characters.count > 1 {
            if beastToEdit == nil {
                delegate?.doneDelegateFunction(textFieldOutlet.text!)
            } else {
                beastToEdit!.name = textFieldOutlet.text!
                delegate?.editDelegateFunction(self, beast: beastToEdit!)
            }
        } else {
            delegate?.cancelDelegateFunction()
        }
    }
    
    
    
    
    
    
    
    
    
}


