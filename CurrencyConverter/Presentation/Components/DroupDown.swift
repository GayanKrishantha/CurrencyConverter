
// Created by Gayan Dias on 29/11/2022.

import SwiftUI

struct DroupDown: View {
    
    @State private(set) var isSheetPopOver = false
    @State private(set) var currencyCode = ""
    var title: String
    var isFromDroupDownSelect: Bool
    var selectCurrency: (CurrencyValue) -> ()
    
    var body: some View {
        LazyVStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(.title2)
            Button(action: {
                endTextEditing()
                isSheetPopOver.toggle()
            }) {
                HStack(alignment: .firstTextBaseline , spacing: 0) {
                    Text(((currencyCode.isEmpty) ?
                          (L10n.Label.required) :
                            (currencyCode)))
                    .font((currencyCode.isEmpty ?
                        .title3 :
                        .title3.bold()))
                    .foregroundColor((currencyCode.isEmpty) ?
                        Color("colors/button_disable") :
                        .black)
                    Spacer()
                    Image(systemName: "arrowtriangle.down.fill")
                        .foregroundColor(.gray)
                }.padding()
                    .background(.white)
                    .cornerRadius(5)
                    .shadow(radius: 3)
            }.sheet(isPresented: $isSheetPopOver, content: {
                CurrencyListModalView(didSelectCurrency: { currency, isFromCurrencySelected  in
                    currencyCode = currency.code
                    isFromCurrencySelected ?
                    self.selectCurrency(currency) :
                    self.selectCurrency(currency)
                }, isSetFromCurrency: isFromDroupDownSelect)
            })
        }
        .padding([.bottom, .top],10)
    }
}

struct DroupDown_Previews: PreviewProvider {
    static var previews: some View {
        DroupDown(title: "",
                  isFromDroupDownSelect: false) { value in
            print("Value")
        }.previewLayout(.sizeThatFits)
          .padding()
    }
}
