let button = UIButton()
button.translatesAutoresizingMaskIntoConstraints = false

view.addSubview(button)

NSLayoutConstraint.activate([
    button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
    button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
    button.widthAnchor.constraint(equalToConstant: 150),
    button.heightAnchor.constraint(equalToConstant: 50)
])
