//
//  CellTodoDelegate.swift
//  BeltExam
//
//  Created by Michael Arbogast on 5/20/16.
//  Copyright © 2016 Michael Arbogast. All rights reserved.
//

import Foundation

protocol CellTodoDelegate: class {
    func setComplete(thisCell: BeastCell)
    func cancelDelegateFunction()
    func doneDelegateFunction(name: String)
    func editDelegateFunction(controller: AddBeastViewController, beast: Beast)
}