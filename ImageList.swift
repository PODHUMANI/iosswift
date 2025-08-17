import SwiftUI
struct ImageList: View {
    @State var showFavorite: Bool = false
    var ListOfImages : [String] = ["AppleImage","BananaImage","BookImage2","BookImage3","BookImage4","BookImageOne","GrapesImage","MangoImage","OrangeImage","Wattermelon"]
  //  @Environment(\.dismiss) private var dismiss
//    @Environment(\.managedObjectContext) private var viewContext
//    var imageInformation: ImageInformetion?
//    @State private var alertTitle = ""
//    @State private var alertMessage = ""
//    @State private var showAlert = false
  //  var SearchList
    var body: some View {
        
        ZStack {
            Color("BackgroundColor").edgesIgnoringSafeArea(.all)
            VStack {
                ScrollView {
                    
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 20) {
                        
                        ForEach(0..<ListOfImages.count, id: \.self) { item in
                            imageView(for: item)
                                .contextMenu {
                                    Button(role: .destructive) {
                                        //      delete(note: item)
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                }
                        }
                        VStack {
                            NavigationLink {
                                //  C
