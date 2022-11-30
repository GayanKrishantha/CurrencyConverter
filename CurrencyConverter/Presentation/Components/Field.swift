
// Created by Gayan Dias on 29/11/2022.

import SwiftUI
import Foundation

struct Field: View {
    
    @State private(set) var amount = ""
    var title: String?
    var enteredValue: (String) -> ()?
    
    var body: some View {
        HStack(){
            TextField("", text: $amount, prompt: Text(title ?? L10n.Label.enterHere))
                .font(.title3)
                .keyboardType(UIKeyboardType.decimalPad)
                .foregroundColor(.black)
                .background(.white)
                .colorScheme(.light)
                .onChange(of: amount) { newValue in
                    self.enteredValue(amount)
                }
        }.padding()
            .background(.white)
            .cornerRadius(5)
            .shadow(radius: 3)
    }
}

struct Field_Previews: PreviewProvider {
    static var previews: some View {
        Field { value in
            print(value)
        }.previewLayout(.sizeThatFits)
         .padding()
    }
}
