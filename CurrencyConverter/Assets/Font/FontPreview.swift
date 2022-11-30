
// Created by Gayan Dias on 25/11/2022.

import SwiftUI

struct Font_Previews: PreviewProvider {
    static var fonts: [(font: Font, text: String)] {
        [
            (.paragraph, "Paragraph"),
            (.labelLarge, "Label Large")
        ]
    }
    
    static var previews: some View {
        Group {
            ForEach(fonts, id: \.text) { font, text in
                Group {
                    VStack {
                        Text(text)
                            .environment(\.sizeCategory, .small)
                        Text(text)
                        Text(text)
                            .environment(\.sizeCategory, .extraLarge)
                        Text(text)
                            .environment(\.sizeCategory, .extraExtraExtraLarge)
                        Text(text)
                            .environment(\.sizeCategory, .accessibilityLarge)
                        Text(text)
                            .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
                    }
                    .font(font)
                }
                .padding()
            }
        }
        .previewLayout(.sizeThatFits)
    }
}
