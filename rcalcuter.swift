import UIKit

class CalculatorViewController: UIViewController {
    
    @IBOutlet var displayLabel: UILabel!
    var result  = 0
    var fristNumber : String = ""
    var secondNumber  = ""
    var opretorValue  = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    @IBAction func calcutionAction(_ sender: Any) {
    
    
   // @IBAction func calcuAction(_ sender: Any) {
        switch(sender as AnyObject).tag{
            
        case 1:
            deleteAll()
        case 2:
            return
        case 3:
            // operatorFuction(" %")
            setOpe("%")
        case 4:
            setOpe("/")
        case 5:
            setOpe("*")

        case 6:
            setOpe("-")
        case 7:
            setOpe("+")
        case 8:
            operatorFuction()
        case 9:
            return
        case 10:
            setData("0")
        case 11:
            setData("1")
        case 12:
            setData("2")
        case 13:
            setData("3")
        case 14:
            setData("4")
        case 15:
            setData("5")
        case 16:
            setData("6")
        case 17:
            setData("7")
        case 18:
            setData("8")
        case 19:
            setData("9")
        default :
            return
            
        }}
        func  setData(_ data : String){
            if opretorValue == ""{
                fristNumber += "\(data)"
                displayLabel.text = fristNumber
                
            }else{
                secondNumber += "\(data)"
                displayLabel.text = secondNumber
            }
        }
        func setOpe(_ oper : String){
            opretorValue = oper
            if oper == "*"{displayLabel.text = "X"} else {displayLabel.text = oper}
        }
        func deleteAll(){
            result = 0
            fristNumber  = ""
            secondNumber  = ""
             opretorValue  = ""
        }
        func operatorFuction(){
            //displayLabel.text = "="
            let intNum1 =  Int(fristNumber) ?? 0
            let intNum2 = Int(secondNumber) ?? 0
            
            switch opretorValue {
            case "+": result = intNum1 + intNum2
            case "-": result = intNum1 - intNum2
            case "*": result = intNum1 * intNum2
            case "/": result = intNum2 != 0 ? intNum1 / intNum2 : 0
            default: displayLabel.text = "error";return
            }
            displayLabel.text = String(result)
            deleteAll();
        }
        
        
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
         }
         */
        
    }
