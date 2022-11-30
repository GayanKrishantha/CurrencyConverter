
// Created by Gayan Dias on 29/11/2022.

import SwiftUI

struct Result: View {
    
    @State var rate: CurrencyRate?
    
    var body: some View {
        LazyVStack(alignment: .leading, spacing: 5){
            LazyHStack{
                Text(L10n.Label.results)
                    .font(.headline)
                Text(String(format: "%.4f", rate?.result ?? 0.0))
                    .font(.paragraph)
                    .lineLimit(3)
            }
            LazyHStack{
                Text(L10n.Label.date)
                    .font(.headline)
                Text(Double(rate?.info?.timestamp ?? 0) .getDateStringFromUTC() )
                    .font(.paragraph)
            }
            LazyHStack{
                Text(L10n.Label.quote)
                    .font(.headline)
                Text(String(format: "%.4f", rate?.info?.quote ?? 0.0))
                    .font(.paragraph)
            }
        }.padding([.bottom, .top],10)
    }
}

struct Result_Previews: PreviewProvider {
    static var previews: some View {
        Result()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}

