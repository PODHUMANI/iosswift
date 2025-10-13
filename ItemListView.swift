//ItemListView->adminview
import SwiftUI
import FirebaseDatabase
struct ItemListView: View {
    @State var homePage = false
    @State private var items: [ItemModel] = []
    @State private var showEdit = false
    @State private var itemToEdit: ItemModel? = nil
    @State private var showAddItemView = false
    @State private var selectedUserID: String? = nil

    var body: some View {
        NavigationStack {
            ZStack {
                BggImage()
                VStack {
                    Text("List of Menu")
                        .font(.system(size: 30))
                        .padding(.top)

                    ScrollView {
                        LazyVStack(spacing: 20) {
                            ForEach(items) { item in
                                itemCard(item)}}
                        .padding()}
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button {
                                homePage = true
                            } label: {
                                Image(systemName: "house.fill")
                            }}}}}
            .onAppear {
                FirebaseManager().fetchItems { fetchedItems in
                    self.items = fetchedItems}}
            .navigationDestination(isPresented: $homePage) {
                AdminHomePageView()
            }
            .navigationDestination(isPresented: $showAddItemView) {
                AddItemView(itemToEdit: itemToEdit)
            }}}
    private func itemCard(_ item: ItemModel) -> some View {
        VStack {
            HStack {
                Image(item.imageName)
                    .resizable()
                    .frame(width: 90, height: 90)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding(.leading)
                VStack(alignment: .leading, spacing: 6) {
                    HStack {
                        Text(item.title.capitalized)
                            .font(.headline)
                        Spacer()
                        Text(item.category)
                            .font(.subheadline)
                            .foregroundColor(.black)
                            .padding(.trailing)
                    }

                    Text(item.description)
                        .font(.caption)
                        .foregroundColor(.black.opacity(0.7))
                        .lineLimit(3)
                        .frame(width: 250, height: 40, alignment: .leading)

                   
                    HStack {
                        Text("Price : ₹\(item.price) ")
                            .bold()
                        Text("Quantity : \(item.quantity) kg")
                    }}}
            .frame(width: 348, height: 150)
            .overlay(RoundedRectangle(cornerRadius: 35).stroke(Color.textbg.opacity(0.8), lineWidth: 3))
            .background(LinearGradient(colors: [.white, .blue],
                                       startPoint: .topLeading,
                                       endPoint: .bottomTrailing))
            .clipShape(RoundedRectangle(cornerRadius: 35))
            if showEdit && selectedUserID == item.id{
                HStack {
                    Button(action: {
                        itemToEdit = item
                           showAddItemView = true
                    }, label: {
                        Text("Edit Item")
                            .font(.system(size: 13))
                            .frame(width: 120, height: 35)
                            .foregroundColor(.green)
                            .fontWeight(.bold)
                            .background(Color.white)
                            .cornerRadius(20)
                    })
                    Button(action: {
                        FirebaseManager().deleteItem(id: item.id)
                    }, label: {
                        Text("Remove Item")
                            .font(.system(size: 13))
                            .frame(width: 120, height: 35)
                            .foregroundColor(.red)
                            .fontWeight(.bold)
                            .background(Color.white)
                            .cornerRadius(20)})}}}
        .onTapGesture {
            showEdit.toggle()
            selectedUserID = item.id}}}
#Preview {
    ItemListView()
}
