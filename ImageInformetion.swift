extension ImageInformetion {
    var wrappedName: String {
        imageName ?? "Unknown"
    }
    var uiImage: UIImage? {
        if let data = imageData {
            return UIImage(data: data)
        }
        return nil
    }
}
