DispatchQueue.global(qos: .background).async {
    let data = loadLargeImage()

    DispatchQueue.main.async {
        self.imageView.image = data
    }
}
