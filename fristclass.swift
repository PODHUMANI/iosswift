import UIKit

class ViewController: UIViewController {
    var c = 6
    override func viewDidLoad() {
        super.viewDidLoad()
        //let var
        let name = "podhumani"
        print("name :\(name)")
        var age = 21
        age = 23
        print(age)
        //Array
        let ary : [String] = ["A","B","C","D"]
        print(ary)
        print(ary.count)
        let x = ary.count-1
        // for loop
        //print the index of value
        for index in 0...x{
            print(ary[index])
        }
        print("number is",oddoreven(a: 5))
        //dictionary
        var _dic:[Int:String] = [:]
        _dic = [1:"a",2:"b",3:"c"]
        print(_dic)
        let number3 = _dic[3]
        // optionl,force unwrap,safe wrap
        print(_dic[3])
        print(number3!)
        print(number3 ?? "not found")
        oddorEven();//fuction call
        add(a: 2,b: 5);
        oddorEven(c: 5);
        odoreven();
    }
    //Function  / method
    func oddoreven(a: Int) -> String{
        if a%2 == 0{
            return " even"
        }
        else{
            return " odd"
        }
    }
    
    // 1.With out argument and no return value
    func odoreven(){
        if c % 2 == 0
        {
            print("\(c) is Even number")
        }
        else{
            print("number is odd")
        }}
    func oddorEven()
    {
         
        if c % 2 == 0{
            print("number is  Even   ")
        }
        else{
            print("number is odd")
        }
    }
   
    //2.With argument and no return value
    //ex1
    func add  ( a:Int,b:Int){
        print("c:",a+b)
     }
    //ex2
    func oddorEven(c: Int)
    {
        if c % 2 == 0{
            print("number is Even")
        }
        else{
            print("number is odd")
        }
    }
    
    //3.without Argument and with return value
    func odorev()->Int{
        let a = 4
        let b = 6
        return (a+b)
    }
    //4. With Argument and with return value
    func odorev(c :Int) ->String{
        if c % 2 == 0{
            return "Even"
        }
        else{
            return " odd"
        }
    }

}
