
// Created by Gayan Dias on 29/11/2022.

import SwiftUI

struct Action: View {
    
    @State private var disabled = false
    var isButonEnable: Bool = false
    var buttonAction: () -> (Void)
    
    var body: some View {
        LazyVStack(alignment: .leading, spacing: 50) {
            Button(action: {
                endTextEditing()
                if isButonEnable {
                    self.buttonAction()
                }
            }) {
                Text(L10n.Label.convert)
                    .font(.title2)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .foregroundColor(isButonEnable ?
                        .white :
                        .black)
                    .cornerRadius(5)
            }.disabled(disabled == isButonEnable)
                .padding([.bottom, .top],10)
        }
        .padding([.bottom, .top],15)
        .background(isButonEnable ?
                    Color("colors/button_enable") :
                        Color("colors/button_disable"))
        .opacity(isButonEnable ? 1 : 0.4)
        .cornerRadius(5)
        .shadow(radius: 5)
    }
}

struct Action_Previews: PreviewProvider {
    static var previews: some View {
        Action {}
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
