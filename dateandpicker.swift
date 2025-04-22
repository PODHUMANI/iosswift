import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    @IBOutlet weak var pickerViewLabel: UILabel!
    @IBOutlet weak var datePickerLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var dateView: UIDatePicker!

    // variable
    let sutentName:[String] = ["janani","sri","mani","ravi","madhu","kani","kavi","janu","san","ramu"]
    let age : [String] = ["  25","  35","  24","  26","  26","  80","  19","  32","  45","  36"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        pickerView.delegate = self
        pickerView.dataSource = self
        
        
        
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sutentName.count;
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let sow = sutentName[row]+age[row]
        pickerViewLabel.text = sow
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let sow = sutentName[row]+age[row]
        return  sow
        
    }
    
    
    @IBAction func datePicker(_ sender: Any) {
      
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        dateView.maximumDate = Date()
        datePickerLabel.text = dateFormatter.string(from: dateView.date)
        
    }
    
}
