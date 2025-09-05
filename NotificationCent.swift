if userVM.validateUser(username: viewModel.username, password: viewModel.password) {
    loginState = .loggedIn
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
        NotificationCenter.default.post(
            name: .userLoggedIn,
            object: nil,
            userInfo: ["username": viewModel.username]
        )
    }
}
