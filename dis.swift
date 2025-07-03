   DispatchQueue.global().async { [self] in
            let urltype = URL(string: myUrlImage)
            let data = try? Data(contentsOf: urltype!)
            DispatchQueue.main.async {
                self.appleImage.image = UIImage(data: data!)
            }
            
        }
        
