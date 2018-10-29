//
//  ViewController.swift
//  checklist
//
//  Created by Aravind on 25/10/18.
//  Copyright © 2018 Aravind. All rights reserved.
//

import UIKit
protocol addItemviewcontroldelegate:class {
    func additemviewdidcancel(_ controller:Additemcontroller)
    func additemviewcontroller(_ controller:Additemcontroller,didfinishadding item:checklistitem)
}
class Additemcontroller: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var donebarbutton: UIBarButtonItem!
    @IBOutlet weak var textfield:UITextView!
    @IBOutlet weak var cancelbarbutton: UIBarButtonItem!
    weak var delegate:addItemviewcontroldelegate?
    override func viewWillAppear(_ animated: Bool) {
        textfield.becomeFirstResponder()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        donebarbutton.isEnabled=false
    }
    @IBAction func cancel(){
        navigationController?.popViewController(animated: true)
        delegate?.additemviewdidcancel(self)
    }
    @IBAction func done(){
        let item=checklistitem()
        item.text=textfield.text!
        item.ischecked=false
        delegate?.additemviewcontroller(self, didfinishadding: item)
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldtext=textField.text!
        let stringrange=Range(range,in:oldtext)
        let newtext=oldtext.replacingCharacters(in: stringrange!, with: string)
        if newtext.isEmpty{
            donebarbutton.isEnabled=false
        }
        else{
            donebarbutton.isEnabled=true
        }
        return true
    }
}
