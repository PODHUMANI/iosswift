//FirebaseManager
import Foundation
import FirebaseDatabase
import FirebaseAuth
import FirebaseFirestore

class FirebaseManager {
    static let shared = FirebaseManager()
    
    private let itemsRef = Database.database().reference().child("items")
    private let usersRef = Database.database().reference().child("users")
    private let ordersRef = Database.database().reference().child("orders")
    
    init() {}
        func fetchItems(completion: @escaping ([ItemModel]) -> Void) {
        itemsRef.observe(.value) { snapshot in
            var items: [ItemModel] = []
            for child in snapshot.children {
                if let snap = child as? DataSnapshot,
                   let dict = snap.value as? [String: Any],
                   let title = dict["title"] as? String,
                   let description = dict["description"] as? String,
                   let imageName = dict["imageName"] as? String,
                   let category = dict["category"] as? String,
                   let price = dict["price"] as? String,
                   let quantity = dict["quantity"] as? String {
                    items.append(ItemModel(
                        id: snap.key,
                        title: title,
                        description: description,
                        imageName: imageName,
                        category: category,
                        price: price,
                        quantity: quantity
                    ))
                }
            }
            completion(items)
        }
    }
    
    func saveItem(_ item: ItemModel) {
        itemsRef.child(item.id).setValue(item.toDictionary())
    }
    
    func deleteItem(id: String) {
        itemsRef.child(id).removeValue()
    }
        func addToCart(_ item: ItemModel) {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        let cartRef = usersRef.child(userId).child("cart").child(item.id)
        let data: [String: Any] = [
            "title": item.title,
            "price": item.price,
            "category": item.category,
            "quantity": "1",
            "imageName": item.imageName
        ]
        cartRef.setValue(data)
    }
    
    func fetchCartItems(completion: @escaping ([ItemModel]) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        usersRef.child(userId).child("cart").observe(.value) { snapshot in
            var items: [ItemModel] = []
            for child in snapshot.children {
                if let snap = child as? DataSnapshot,
                   let dict = snap.value as? [String: Any],
                   let title = dict["title"] as? String,
                   let price = dict["price"] as? String,
                   let imageName = dict["imageName"] as? String,
                   let category = dict["category"] as? String,
                   let quantity = dict["quantity"] as? String {
                    items.append(ItemModel(
                        id: snap.key,
                        title: title,
                        description: "",
                        imageName: imageName,
                        category: category,
                        price: price,
                        quantity: quantity
                    ))
                }
            }
            completion(items)
        }
    }
    func updateCartQuantity(itemId: String, quantity: Int) {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        usersRef.child(userId).child("cart").child(itemId).child("quantity").setValue("\(quantity)")
    }
    
    func deleteCartItem(itemId: String) {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        usersRef.child(userId).child("cart").child(itemId).removeValue()
    }
    func saveOrder(total: Int, cartItems: [ItemModel]) {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        let db = Firestore.firestore()
        db.collection("users").document(userId).getDocument { snapshot, error in
            let username = snapshot?.data()?["username"] as? String ?? "Unknown User"
            
            let orderId = UUID().uuidString
            let orderData: [String: Any] = [
                "userId": userId,
                "username": username,
                "total": total,
                "items": cartItems.map { [
                    "title": $0.title,
                    "price": $0.price,
                    "quantity": $0.quantity
                ] },
                "status": "Paid"
            ]
        Database.database().reference().child("orders").child(orderId).setValue(orderData)
        Database.database().reference().child("users").child(userId).child("cart").removeValue()
        }
    }


    
    func fetchOrders(completion: @escaping ([OrderModel]) -> Void) {
        ordersRef.observe(.value) { snapshot in
            var list: [OrderModel] = []
            for child in snapshot.children {
                if let snap = child as? DataSnapshot,
                   let dict = snap.value as? [String: Any],
                   let userId = dict["userId"] as? String,
                   let username = dict["username"] as? String, // fetch username
                   let total = dict["total"] as? Int,
                   let status = dict["status"] as? String,
                   let itemsArray = dict["items"] as? [[String: Any]] {
                    let items = itemsArray.compactMap { ItemSummary(dict: $0) }
                    list.append(OrderModel(id: snap.key, userId: userId, username: username, total: total, items: items, status: status))
                }
            }
            completion(list)
        }}}
