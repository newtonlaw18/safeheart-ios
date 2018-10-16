//
//  ViewController.swift
//  Safe-Heart
//
//  Created by Newton Law on 13/09/2018.
//  Copyright © 2018 newton. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var helpPickerView: UIPickerView!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var helpDescriptionTextField: UITextField!
    
    var ref: DatabaseReference!
    var key = 995
    
    let type_of_help = ["FireFighters", "Ambulance", "Police"]
    var type_of_help_selected: String!
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return type_of_help.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return type_of_help[row]
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        type_of_help_selected = type_of_help[row]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //FirebaseApp.configure()
        
        ref = Database.database().reference().child("HelpReport")
        
        helpPickerView.delegate = self
        helpPickerView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func sendHelp(_ sender: Any) {
        key = key - 1
        
        // Get current date time
        let currentDateTime = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateStyle = .medium
        formatter.string(from: currentDateTime)
        
        // Writing data to firebase
        let helpreport = [
                      "username": userNameTextField.text! as String,
                      "created_at": formatter.string(from: currentDateTime),
                      "latitude": "5.3607",
                      "longitude": "100.2974",
                      "response": "false",
                      "type_of_help": type_of_help_selected,
                      "userID": "eB6jkrstCSdLti8891fdrEwtyFB3",
                      "help_description": helpDescriptionTextField.text! as String
        ]

        ref.child(String(key)).setValue(helpreport)
        
        let alert = UIAlertController(title: "Distres call received!", message: "Don't worry, stay calm and help will arrive soon.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
}

