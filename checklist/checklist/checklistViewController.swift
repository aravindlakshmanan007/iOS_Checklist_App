//
//  ViewController.swift
//  checklist
//
//  Created by Aravind on 25/10/18.
//  Copyright © 2018 Aravind. All rights reserved.
//

import UIKit

class checklistViewController: UITableViewController,addItemviewcontroldelegate {
     var item:[checklistitem]
    func additemviewdidcancel(_ controller: Additemcontroller) {
        navigationController?.popViewController(animated: true)
    }
    
    func additemviewcontroller(_ controller: Additemcontroller, didfinishadding itemss: checklistitem) {
        let newrow=item.count
        item.append(itemss)
        let indexpath=IndexPath(row: newrow, section: 0)
        let indexpaths=[indexpath]
        tableView.insertRows(at: indexpaths, with: .automatic)
        navigationController?.popViewController(animated: true)
    }
    
   
    
    
    @IBAction func additem(_ sender: Any) {
        
    }
    required init?(coder aDecoder: NSCoder) {
        item = [checklistitem]()
       
        
        super.init(coder:aDecoder)
        
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        item.remove(at: indexPath.row)
        let indexpaths=indexPath
        tableView.deleteRows(at: [indexpaths], with: .automatic)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Additem" {
            let controller=segue.destination as! Additemcontroller
            controller.delegate = self
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return item.count
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell=tableView.cellForRow(at: indexPath){
            let item = self.item[indexPath.row]
            item.ischecked = !item.ischecked
            configurecheckmark(for: cell, with:item)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "checklistitem", for: indexPath)
        let label=cell.viewWithTag(1000) as! UILabel
        let item = self.item[indexPath.row]
        label.text = item.text
        
        
        configurecheckmark(for: cell, with:item)
        return cell
    }
    func configurecheckmark(for cell:UITableViewCell,with item : checklistitem) {
        if item.ischecked {
            cell.accessoryType = .checkmark
        }else{
            cell.accessoryType = .none
        }
    }
}

