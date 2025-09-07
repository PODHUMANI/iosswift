import SwiftUI
import PhotosUI
struct ProfilePageView: View {
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var profileImage: UIImage? = nil
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Profile Page")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            // Profile Image View
            if let image = profileImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.blue, lineWidth: 3))
                    .shadow(radius: 10)
            } else {
                Circle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 150, height: 150)
                    .overlay(Text("No Image").foregroundColor(.gray))
            }
            
            // Pick from Gallery Button
            PhotosPicker(selection: $selectedItem, matching: .images, photoLibrary: .shared()) {
                Text("Select Profile Image")
                    .font(.headline)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            .onChange(of: selectedItem) { newItem in
                Task {
                    if let data = try? await newItem?.loadTransferable(type: Data.self),
                       let uiImage = UIImage(data: data) {
                        profileImage = uiImage
                    }
                }
            }
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ProfilePageView()
}
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePageView()
    }
}
