import SwiftUI

struct DismissSheet: View {
    @State private var showSheet = false
    var body: some View {
                VStack {
                    Button("Show Sheet") {
                        showSheet = true
                    }
                }
                .sheet(isPresented: $showSheet) {
                    SheetView()
                }
            }
        

    struct SheetView: View {
        @Environment(\.dismiss) var dismiss  //
        var body: some View {
            VStack {
                Text("This is a Sheet")
                    .font(.largeTitle)
                Button("Dismiss") {
                    dismiss() 
                }
                .padding()
            }
        }
    }

    }


#Preview {
    DismissSheet()
}
