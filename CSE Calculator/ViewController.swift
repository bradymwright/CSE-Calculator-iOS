//
//  ViewController.swift
//  CSE Calculator
//
//  Created by Brady on 5/1/18.
//  Copyright © 2018 Brady Wright. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //MARK: Properties
    @IBOutlet weak var uiView: UIView!
    @IBOutlet weak var maleFemale: UISegmentedControl!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var activityPicker: UIPickerView!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var activityLevelTextField: UITextField!
    @IBOutlet weak var goalTextField: UITextField!
    
    
    //MARK: Actions
    @IBAction func maleFemalePressed(_ sender: UISegmentedControl) {
    }
    @IBAction func calculatePressed(_ sender: UIButton) {
    }
    
    
    //MARK: Declarations
    let height = ["4 feet", "4 feet 1 inch", "4 feet 2 inches", "4 feet 3 inches", "4 feet 4 inches", "4 feet 5 inches", "4 feet 6 inches", "4 feet 7 inches", "4 feet 8 inches", "4 feet 9 inches", "4 feet 10 inches", "4 feet 11 inches", "5 feet", "5 feet 1 inch", "5 feet 2 inches", "5 feet 3 inches", "5 feet 4 inches", "5 feet 5 inches", "5 feet 6 inches", "5 feet 7 inches", "5 feet 8 inches", "5 feet 9 inches", "5 feet 10 inches", "5 feet 11 inches", "6 feet", "6 feet 1 inch", "6 feet 2 inches", "6 feet 3 inches", "6 feet 4 inches", "6 feet 5 inches", "6 feet 6 inches", "6 feet 7 inches", "6 feet 8 inches", "6 feet 9 inches", "6 feet 10 inches", "6 feet 11 inches", "7 feet"]
    
    let activity = ["Little to None", "Light (1-2 days/week)", "Active (3-5 days/week)", "Very Active (6-7 days/week)", "Heavy (2x/day)"]
    
    let goal = ["Deficit (10-15% below)", "Deficit (20-25% below)", "deficit (30-35% below)", "deficit (40%+ below)", "Maintain Current Weight", "Surplus (10-15% above)", "Surplus (20-25% above)", "Surplus (30-35% above)", "Surplus (40%+)"]
    
    var selectedHeight: String?
    var selectedActivity: String?
    var selectedGoal: String?
    

    //MARK: Touch Screen to Exit
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == ageTextField {
            weightTextField.becomeFirstResponder()
        } else if textField == weightTextField {
            textField.resignFirstResponder()
        }
        return true
    }
    
    
    //MARK: Height Picker
    func createHeightPicker() {
        let heightPicker = UIPickerView()
        heightPicker.delegate = self
        
        heightTextField.inputView = heightPicker
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return height.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return height[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        selectedHeight = height[row]
        heightTextField.text = selectedHeight
    }
    

    //MARK: Overrides
    override func viewDidLoad() {
        ageTextField.delegate = self
        weightTextField.delegate = self
        createHeightPicker()
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
