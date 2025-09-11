import SwiftUI

struct DatePickerExample: View {
    @State private var selectedDate = Date()

    var body: some View {
        VStack {
            // DatePicker
            DatePicker(
                "Select a date",
                selection: $selectedDate,
                displayedComponents: .date   // Only date picker
            )
            .datePickerStyle(.graphical)   // Style: graphical, compact, wheel
            .padding()

            // Selected Date Show
            Text("You selected: \(selectedDate.formatted(date: .long, time: .omitted))")
                .padding()
        }
    }
}
