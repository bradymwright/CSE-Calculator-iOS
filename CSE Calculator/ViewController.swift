//
//  ViewController.swift
//  CSE Calculator
//
//  Created by Brady on 5/1/18.
//  Copyright © 2018 Brady Wright. All rights reserved.
//

/*MARK: Calculation Algorithm
 1.  Calculate BMR (Basal Metabolic Rate)
        Female BMR = 655 + (4.35 * Weight in LBS) + (1.8 * Height in CM) - (4.7 * Age in YRS)
        Male BMR = 66 + (6.23 * Weight in LBS) + (5 * Height in CM) - (6.8 * Age in YRS)
        ^^^You have to calculate the numbers in paraentheses first^^^
 2.  Calculate TDEE (Total Daily Energy Expenditure)
        TDEE = BMR * Activity Factor
            Little to None = 1.2 * BMR
            Light (1-2 days/week) = 1.375 * BMR
            Active (3-5 days/week) = 1.55 * BMR
            Very Active (6-7 days/week) = 1.725 * BMR
            Heavy (2x/day) = 1.9 * BMR
 3.  Calculate and Display Daily Calorie Target Based on Goals
        Deficit (10-15% below) = TDEE - (TDEE * .125)
        Deficit (20-25% below) = TDEE - (TDEE * .225)
        Deficit (30-35% below) = TDEE - (TDEE * .325)
        Deficit (40%+ below) = TDEE - (TDEE * .4)
        Maintain Current Weight = TDEE
        Surplus (10-15% above) = TDEE + (TDEE * .125)
        Surplus (20-25% above) = TDEE + (TDEE * .225)
        Surplus (30-35% above) = TDEE + (TDEE * .325)
        Surplus (40%+) = TDEE + (TDEE * .4)
 4.  Display Servings Suggestions Based on Calorie Target
        if 1250-1499 Calories:
            3 Meals / 1 Snack
            3 Meals / 2 Dessert Bites
        if 1500-1749 Calories:
            3 Meals / 2 Snacks
            3 Meals / 1 Snack / 2 Desserts
        if 1750-1999 Calories:
            3 Meals / 3 Snacks
            3 Meals / 3 Snacks / 2 Desserts
        if 2000-2249 Calories:
            3 Meals / 4 Snacks
            3 Meals / 3 Snacks / 1 Dessert
            4 Meals / 2 Snack / 1 Dessert
        if 2250-2499 Calories:
            4 Meals / 3 Snacks / 1 Dessert
            3 Meals / 4 Snacks / 2 Desserts
            3 Meals / 5 Snacks
        if 2500-2749 Calories:
            4 Meals / 4 Snacks / 1 Dessert
            5 Meals / 3 Snacks
            5 Meals / 2 Snacks / 2 Desserts
        if 2750-2999 Calories:
            5 Meals / 3 Snacks / 1 Dessert
            6 Meals / 2 Snacks / 2 Desserts
            6 Meals / 3 Snacks
        if 3000+ Calories:
            5 Meals / 5 Snacks / 1 Dessert
            6 Meals / 4 Snacks
            6 Meals / 3 Snacks / 2 Desserts
 */

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: Properties
    @IBOutlet weak var uiView: UIView!
    @IBOutlet weak var maleFemale: UISegmentedControl!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var heightTextField: HeightTextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var activityLevelTextField: ActivityTextField!
    @IBOutlet weak var goalTextField: GoalTextField!
    @IBOutlet weak var result: UILabel!
  
  
    //MARK: Actions
    @IBAction func maleFemalePressed(_ sender: UISegmentedControl) {
    }
  @IBAction func calculatePressed(_ sender: Any) {
    if selectedHeight == nil {return;}
    if selectedGoal == nil {return;}
    if selectedActivity == nil {return;}
    if weightTextField.text == nil || weightTextField.text?.count==0 {return;}
    if ageTextField.text == nil  || ageTextField.text?.count==0{return;}

    //use these numbers for daily target view
    var heightCM = 2.54 * Float(48+height.index(of: selectedHeight!)!)
    var activityFactor = 1.2 + (0.175 * Float(activity.index(of: selectedActivity!)!))
    var bmr:Float = 0.0
    if maleFemale.selectedSegmentIndex == 0 {//male
      //Male BMR = 66 + (6.23 * Weight in LBS) + (5 * Height in CM) - (6.8 * Age in YRS)
      
      bmr = 66.0 +
        (6.23 * Float(weightTextField.text!)!) +
        (5.0 * heightCM) -
        (6.8 * Float(ageTextField.text!)!)
    }else{//female
      //Female BMR = 655 + (4.35 * Weight in LBS) + (1.8 * Height in CM) - (4.7 * Age in YRS)
        bmr = 655.0 +
          (4.35 * Float(weightTextField.text!)!) +
          (1.8 * heightCM) -
          (4.7 * Float(ageTextField.text!)!)
    }
    //TDEE = BMR * Activity Factor
    var tdee = bmr*activityFactor
    
    var goalIndex = goal.index(of:selectedGoal!)!
    var targetFactor:Float = 0.0
    switch(goalIndex){
    case 0:
      targetFactor = -0.125
      break
    case 1:
      targetFactor = -0.225
      break
    case 2:
      targetFactor = -0.325
      break
    case 3:
      targetFactor = -0.4
      break
    case 4:
      targetFactor = 0.0
      break
    case 5:
      targetFactor = 0.125
      break
    case 6:
      targetFactor = 0.225
      break
    case 7:
      targetFactor = 0.325
      break
    case 8:
      targetFactor = 0.4
      break
    default:
      targetFactor = 0.0
      break
    }
    dailyCalorieTarget = tdee + (tdee*targetFactor)
  }
    
    //MARK: Declarations
    let height = ["4'", "4'1\"", "4'2\"", "4 feet 3 inches", "4 feet 4 inches", "4 feet 5 inches", "4 feet 6 inches", "4 feet 7 inches", "4 feet 8 inches", "4 feet 9 inches", "4 feet 10 inches", "4 feet 11 inches", "5 feet", "5 feet 1 inch", "5 feet 2 inches", "5 feet 3 inches", "5 feet 4 inches", "5 feet 5 inches", "5 feet 6 inches", "5 feet 7 inches", "5 feet 8 inches", "5 feet 9 inches", "5 feet 10 inches", "5 feet 11 inches", "6 feet", "6 feet 1 inch", "6 feet 2 inches", "6 feet 3 inches", "6 feet 4 inches", "6 feet 5 inches", "6 feet 6 inches", "6 feet 7 inches", "6 feet 8 inches", "6 feet 9 inches", "6 feet 10 inches", "6 feet 11 inches", "7 feet"]
    
        /*MARK: Height Conversions (if needed)
        1 FT = 30.48 CM
        1 IN = 2.54 CM
     
        4 FT = 121.92 CM
        4 FT 1 IN = 124.46 CM
        4 FT 2 IN = 127 CM
        4 FT 3 IN = 129.54 CM
        4 FT 4 IN = 132.08 CM
        4 FT 5 IN = 134.62 CM
        4 FT 6 IN = 137.16 CM
        4 FT 7 IN = 139.7 CM
        4 FT 8 IN = 142.24 CM
        4 FT 9 IN = 144.78 CM
        4 FT 10 IN = 147.32 CM
        4 FT 11 IN = 149.86 CM
        ETC, ETC, ETC...
        */
    
    let activity = ["Little to None", "Light (1-2 days/week)", "Active (3-5 days/week)", "Very Active (6-7 days/week)", "Heavy (2x/day)"]
    
        /*MARK: Activity Conversions
        Little to None = 1.2
        Light (1-2 days/week) = 1.375
        Active (3-5 days/week) = 1.55
        Very Active (6-7 days/week) = 1.725
        Heavy (2x/day) = 1.9
        */
    
    let goal = ["Deficit (10-15% below)", "Deficit (20-25% below)", "Deficit (30-35% below)", "Deficit (40%+ below)", "Maintain Current Weight", "Surplus (10-15% above)", "Surplus (20-25% above)", "Surplus (30-35% above)", "Surplus (40%+)"]
    
        /*MARK: Goal Conversions (Split in between the percentages)
        Deficit (10-15% below) = .125
        Deficit (20-25% below) = .225
        Deficit (30-35% below) = .325
        Deficit (40%+ below) = .4
        Maintain Current Weight = 0
        Surplus (10-15% above) = .125
        Surplus (20-25% above) = .225
        Surplus (30-35% above) = .325
        Surplus (40%+) = .4
        */
    
    var selectedHeight: String?
    var selectedActivity: String?
    var selectedGoal: String?
    var dailyCalorieTarget:Float?
    
    
    //MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        ageTextField.delegate = self
        weightTextField.delegate = self
        createHeightPicker()
        createActivityPicker()
        createGoalPicker()
        createToolbar()
  }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
  
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
        heightPicker.delegate = heightTextField
        
        heightTextField.inputView = heightPicker
        heightTextField.parent = self
        
        //Customizations
        heightPicker.backgroundColor = .white
    }
    
    
    //MARK: Activity Picker
     func createActivityPicker() {
        let activityPicker = UIPickerView()
        activityPicker.delegate = activityLevelTextField
     
        activityLevelTextField.inputView = activityPicker
        activityLevelTextField.parent = self
      
        activityPicker.backgroundColor = .white
     }
  
  func createGoalPicker() {
    let goalPicker = UIPickerView()
    goalPicker.delegate = goalTextField
    
    goalTextField.inputView = goalPicker
    goalTextField.parent = self
    
    goalPicker.backgroundColor = .white
  }
     
    
    
    func createToolbar() {
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        //Customizations
        toolBar.barTintColor = .black
        toolBar.tintColor = .white
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(ViewController.dismissKeyboard))
        
        toolBar.setItems([UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil), doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        heightTextField.inputAccessoryView = toolBar
        activityLevelTextField.inputAccessoryView = toolBar
        goalTextField.inputAccessoryView = toolBar
        ageTextField.inputAccessoryView = toolBar
        weightTextField.inputAccessoryView = toolBar
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

class HeightTextField : UITextField, UIPickerViewDelegate, UIPickerViewDataSource{
  var parent: ViewController?
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return parent!.height.count
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return parent!.height[row]
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    parent?.selectedHeight = parent!.height[row]
    text = parent?.selectedHeight
  }
}

class ActivityTextField : UITextField, UIPickerViewDelegate, UIPickerViewDataSource{
  var parent: ViewController?
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return parent!.activity.count
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return parent!.activity[row]
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    parent?.selectedActivity = parent!.activity[row]
    text = parent?.selectedActivity
  }
}

class GoalTextField : UITextField, UIPickerViewDelegate, UIPickerViewDataSource{
  var parent: ViewController?
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return parent!.goal.count
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return parent!.goal[row]
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    parent?.selectedGoal = parent!.goal[row]
    text = parent?.selectedGoal
  }
}
