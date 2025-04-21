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
        if (sender as AnyObject).tag == 1 {// Ac
            self.displayLabel.text = ""
            deleteAll();
        }
        if (sender as AnyObject).tag == 2{// " /"
            self.displayLabel.text = "/"
            opretorValue = "/"
        }
        if (sender as AnyObject).tag == 3{//"7"
            self.displayLabel.text = checkNumber(number: 7);
        }
        if (sender as AnyObject).tag == 4{//"8"
            self.displayLabel.text =  checkNumber(number: 8);
                  }
         if (sender as AnyObject).tag == 5{//"9"
             self.displayLabel.text = checkNumber(number: 9);
        }
         if (sender as AnyObject).tag == 6{//"X"
             self.displayLabel.text = "x"
             opretorValue = "*"
        }
         if (sender as AnyObject).tag == 7{//"4"
            self.displayLabel.text = checkNumber(number: 4);
        }
         if (sender as AnyObject).tag == 8{ //"5"
            self.displayLabel.text = checkNumber(number: 5);
        }
         if (sender as AnyObject).tag == 9{//"6"
            self.displayLabel.text = checkNumber(number: 6);
        }
        if (sender as AnyObject).tag == 10{            //-
            self.displayLabel.text = "-"
            opretorValue = "-"
        }
        if (sender as AnyObject).tag == 11{            //1
            self.displayLabel.text = checkNumber(number: 1);
        }
         if (sender as AnyObject).tag == 12{            //2
            self.displayLabel.text = checkNumber(number: 2);
        }
        if (sender as AnyObject).tag == 13{            //3
            self.displayLabel.text = checkNumber(number: 3);
        }
         if (sender as AnyObject).tag == 14{//+
            self.displayLabel.text = "+"
             opretorValue = "+"
        }
         if (sender as AnyObject).tag == 15{//0
            self.displayLabel.text = checkNumber(number: 0);
        }
         if (sender as AnyObject).tag == 16{ // =
            self.displayLabel.text = "="
             var intNum1 =  Int(num1)
             var intNum2 = Int(num2)
             print(" number 1 :\(intNum1!)")
             print(opretorValue)
             print(" number 2 :\(intNum2!)")
             
             switch  opretorValue { //calcution fuction
             case "+":
                 resultValue = (intNum1 ?? 0  ) + (intNum2 ??  0  )
                 displayLabel.text = String(resultValue)
             case "-":
                 resultValue = (intNum1 ?? 0) - (intNum2 ?? 0)
                 displayLabel.text = String(resultValue)
             case "*":
                 resultValue = (intNum1 ?? 0) * (intNum2 ?? 0)
                 displayLabel.text = String(resultValue)
                 
             case "/":
                 resultValue = (intNum1 ?? 0) / (intNum2 ?? 0)
                 displayLabel.text = String(resultValue)
             default:
                 displayLabel.text = "error"
             }
             print("result :\(resultValue)")
             deleteAll();
        }
        // fuction
        func checkNumber(number: Int)->String{ // display value number 1 and number 2
            if opretorValue == ""{
                num1 += "\(number)"
                return "\(num1)"
            }else {
                num2 += "\(number)"
                return "\(num2)"
            }
        }
        func deleteAll(){ // delete the value
            num1 = ""
            num2 = ""
            opretorValue = ""
            resultValue = 0
        }}}
