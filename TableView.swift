 @IBOutlet var tblList: UITableView!
    
 

   var image = [UIImage(named: "Dahlia"),UIImage(named: "Jasmine"),UIImage(named: "Lily"),UIImage(named: "Shoe Flower"),UIImage(named: "Sun Flower"),UIImage(named: "Rose"),UIImage(named: "Lotus"),UIImage(named: "Tulip"),UIImage(named: "Lavender"),UIImage(named: "Peony")]
    var name = ["Dahlia","Jasmine","Lily","Shoe Flower","Sun Flower","Rose","Lotus","Tulip","Lavender","Peony"]
    var info = ["Dahlia flower consists of six petall ike segments.","The jasmine is a very popular flower found in the world.","Lily flower consists of six petal like segments.","It is also known as hibiscus or china rose.","Sunflower has beautiful large head with eight petals.","Rose is the king of the flowers.","Lotus is the national flower of India.","Tulips are plants that bloom in early spring.","Lavenders are fragrant and attractive pioneers.","Peony blooms from late spring to early summer."]
    override func viewDidLoad() {
        super.viewDidLoad()
        tblList.delegate = self
        tblList.dataSource = self
      
        tblList.register(UINib(nibName: "FlowerTableViewCell", bundle: nil), forCellReuseIdentifier: "FlowerTableViewCell")

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return name.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tcell = tableView.dequeueReusableCell(withIdentifier: "FlowerTableViewCell", for: indexPath) as? FlowerTableViewCell else{
            return UITableViewCell()
        }
       
        if indexPath.row < image.count {
            tcell.flowerImage.image = image[indexPath.row] ?? UIImage(named: "defaultImage")
        } else {
            tcell.flowerImage.image = UIImage(named: "defaultImage")
        }
     //   tcell.flowerImage.image = image[indexPath.row] ?? UIImage(named: "defaultImage")
        tcell.flowerLabelOne.text = name[indexPath.row]
        //tcell.flowerLabelOne.contentMode = .top
        tcell.flowerLabelTwo.text = info[indexPath.row]
        return tcell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle ==.insert{
//            
//        }
           if editingStyle == .delete {
               name.remove(at: indexPath.row)
               info.remove(at: indexPath.row)
               image.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
           }
       }
       
//       func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
//           return true
//       }
//   
    

}
