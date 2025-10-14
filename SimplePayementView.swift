//PayementView
import SwiftUI

struct PayementView: View {
    @Environment(\.dismiss) var dismiss
    @State private var paymentSuccess = false
    @State private var paymentFailed = false

    var totalAmount: Int
    var cartItems: [ItemModel]

    var body: some View {
        VStack(spacing: 30) {
            if paymentSuccess {
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 80))
                    .foregroundColor(.green)
                Text("Payment Successful")
                    .font(.title)
                    .bold()

                Button("Back to Home") {
                    dismiss()
                }
                .buttonStyle(PrimaryButtonStyle())
            }
            else if paymentFailed {
                Image(systemName: "xmark.octagon.fill")
                    .font(.system(size: 80))
                    .foregroundColor(.red)
                Text("Payment Failed")
                    .font(.title)
                    .bold()
                
                Button("Try Again") {
                    paymentFailed = false
                }
                .buttonStyle(PrimaryButtonStyle())
            }
            else {
                Text("Total Amount: ₹\(totalAmount)")
                    .font(.title)
                    .padding()

                Button("Pay Now") {
                    processPayment()
                }
                .buttonStyle(PrimaryButtonStyle())
            }
        }
        .padding()
    }

    func processPayment() {
        let success = true

        if success {
            FirebaseManager.shared.saveOrder(total: totalAmount, cartItems: cartItems)
            paymentSuccess = true
        } else {
            paymentFailed = true}}}
