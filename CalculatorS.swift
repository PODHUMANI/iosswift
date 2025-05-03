import UIKit

class ViewController: UIViewController {
    //outlet
    @IBOutlet weak var displayLabel: UILabel!
    //variable decleration
    var num1 = ""
    var num2 = ""
    var opretorValue = ""
    var resultValue :Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    //Button Action
    @IBAction func calcuAction(_ sender: Any) {//assing the value of the button
        guard let tag = (sender as AnyObject).tag else { return }
        switch tag {
        case 1: // AC
            self.displayLabel.text = "00"
            deleteAll();
        case 2: // Division
            displayLabel.text = "/"
            opretorValue = "/"
        case 3://"7"
            appendNum(7)
        case 4 ://"8"
            appendNum(8)
        case 5 ://"9"
            appendNum(9)
        case 6 ://"X"
            self.displayLabel.text = "x"
            opretorValue = "*"
        case 7 ://"4"
            appendNum(4);
        case 8 : //"5"
            appendNum(5)
        case 9 ://"6"
            appendNum( 6)
        case 10 :            //-
            self.displayLabel.text = "-"
            opretorValue = "-"
        case 11:            //1
            appendNum(1)
        case 12:            //2
            appendNum(2);
        case 13 :            //3
            appendNum(3)
        case 14 ://+
            self.displayLabel.text = "+"
            opretorValue = "+"
        case 15 ://0
            appendNum(0)
        case 16 : // =
            calcution();
        default :
            break
        }
    }
        // fuction
        func appendNum(_ number: Int){ // display value number 1 and number 2
            if opretorValue == ""{
                num1 += "\(number)"
                displayLabel.text = num1
            }else {
                num2 += "\(number)"
                displayLabel.text = num2
            }
        }
        func deleteAll(){ // delete the value
            num1 = ""
            num2 = ""
            opretorValue = ""
            resultValue = 0
        }
        func calcution()  {
            let intNum1 =  Int(num1) ?? 0
            let intNum2 = Int(num2) ?? 0

            switch opretorValue {
            case "+": resultValue = intNum1 + intNum2
            case "-": resultValue = intNum1 - intNum2
            case "*": resultValue = intNum1 * intNum2
            case "/": resultValue = intNum2 != 0 ? intNum1 / intNum2 : 0
            default: displayLabel.text = "error";return
            }
            displayLabel.text = String(resultValue)
            deleteAll();
        }
   }
