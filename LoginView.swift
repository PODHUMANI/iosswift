import SwiftUI
struct LoginView: View {
     @State var viewModel = LoginAndRegisterViewModel()
    @StateObject var appVm = AppViewModel()
    @Environment(\.dismiss) var dismiss
    @State private var role = "user"
  //  @State private var adminPage  = false
    @State private var homePage  = false
    var body: some View {
        NavigationStack{
            ZStack{
                BgView()
                VStack(spacing: 20){
                    Spacer()
                    LogoView()
                    Spacer()
                    VStack(alignment: .leading,spacing: 15){
                        Text("User Name")
                            .font(.system(size: 15))
                        TextField("Name",text: $viewModel.name)
                        //  .keyboardType(.emailAddress)
                            .font(.system(size: 20))
                            .foregroundColor(.black)
                            .padding()
                            .frame(width: 350, height: 50)
                            .background(Color.white.opacity(0.8))
                            .overlay(RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.black.opacity(0.8), lineWidth: 4))
                            .clipShape(RoundedRectangle(cornerRadius:  15))
                        Text("Password")
                            .font(.system(size: 15))
                        PasswordComponentView(showPassword: $viewModel.showPassword, password: $viewModel.password)
                        Picker("Role", selection: $role) {
                            Text("User").tag("user")
                            Text("Admin").tag("admin")
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        Button(action:{
                            
                            if appVm.loginUser(username: viewModel.name, password: viewModel.password){
                                homePage = true
                            }else{
                                //                        if appVm.loginUser(username: "Admin", password: "123456"){
                                //                            adminPage = true
                                //                           // return
                                //                        }else{
                                viewModel.alertTitle = "Faild"
                                viewModel.alertMessage = "invaild username or password"
                                viewModel.showAlert = true
                                //}
                            }
                        },label: {
                            Text("Login")
                                .font(.system(size: 15,weight: .semibold))
                                .padding(12)
                                .foregroundStyle(.white)
                                .frame(maxWidth:.infinity)
                                .background(.green)
                                .overlay(RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.black.opacity(0.8), lineWidth: 4))
                                .clipShape(RoundedRectangle(cornerRadius:  15))
                                .padding(.horizontal)
                        })
                        .padding(.top)
                        HStack{
                            Spacer()
                            Text("Dont't have an account?")
                                .font(.system(size: 14))
                            Button(action:{
                                viewModel.presentRegisterView = true                }, label: {
                                    Text("Register now")
                                        .font(.system(size: 14,weight: .semibold))
                                })
                            Spacer()
                        }
                    }
                    Spacer()
                        .padding(.horizontal,10)
                        .fullScreenCover(isPresented: $viewModel.presentRegisterView, content: {
                            RegisterView()
                        })
                    
                        .navigationDestination(isPresented: $homePage ){
                            if role == "user"{
                                HomeView()
                            }else{
                                
                            }
                           
                        }
                }
                
                .frame(width: 350)
                .padding(.horizontal)
                .alert(viewModel.alertTitle, isPresented: $viewModel.showAlert){
                    Button(action: {
                        dismiss()
                    }, label: {
                        Text("OK")
                    })
                }message: {
                    Text(viewModel.alertMessage)
                }
            }
            //            NavigationLink(destination: appVm.loggedInUser?.role == "admin" ? AnyView(AdminHomeView()) : AnyView( HomeView()), isActive: $profilePage) {
            //                EmptyView()
            //            }
        }}
}

#Preview {
    NavigationStack{
        LoginView()
    }
}
