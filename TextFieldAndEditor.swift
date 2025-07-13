import SwiftUI

struct TextFiledTask: View {
    @State private var text = ""
    @State private var tEditor = ""
    var body: some View {
        VStack{
            HStack{
                Text("TEXT FIELD")
                Spacer()
            }.padding(50)
            TextField("Enter your name", text : $text)
                .keyboardType(.alphabet)
                .textFieldStyle(.roundedBorder)
                    .padding(.horizontal, 30)
                    .font(.system(size: 20, weight: .bold))
            Text("Text Editor").font(.system(size: 30, weight: .bold))
            TextEditor( text: $tEditor) .background(Color.blue)
                .scrollContentBackground(.hidden)
                .frame(width: 300, height: 350)
               
                
            
        }    }
}

#Preview {
    TextFiledTask()
}
