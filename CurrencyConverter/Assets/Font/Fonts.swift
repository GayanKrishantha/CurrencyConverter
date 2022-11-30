
// Created by Gayan Dias on 25/11/2022.

import SwiftUI

struct FontType {
    let name: String
    let size: CGFloat
    var lineHeightMultiple: CGFloat = 1.3
    var lineSpacing: CGFloat {
        size * lineHeightMultiple - size
    }
    
    static func sourceSansPro(_ type: SourceSansPro, size: CGFloat) -> FontType {
        FontType(name: type.name, size: size)
    }
    
    static var paragraph: FontType {
        .sourceSansPro(.regular, size: 16)
    }
    
    static var labelLarge: FontType {
        .sourceSansPro(.bold, size: 14)
    }
    
    func font(forTextStyle textStyle: UIFont.TextStyle? = nil) -> UIFont {
        let font = UIFont(name: name, size: size)!
        if let textStyle = textStyle {
            return UIFontMetrics(forTextStyle: textStyle).scaledFont(for: font)
        } else {
            return font
        }
    }
    
    func font(forTextStyle textStyle: Font.TextStyle? = nil) -> Font {
        guard let textStyle = textStyle else {
            return .custom(name, size: size)
        }
        if #available(iOS 14.0, *) {
            return .custom(name, size: size, relativeTo: textStyle)
        } else {
            let scaledSize = UIFontMetrics.default.scaledValue(for: size)
            return .custom(name, size: scaledSize)
        }
    }
}

extension UIFont {
    static func sourceSansPro(_ type: SourceSansPro,
                              size: CGFloat, forTextStyle
                              textStyle: UIFont.TextStyle? = nil) -> UIFont {
        FontType.sourceSansPro(type, size: size).font(forTextStyle: textStyle)
    }
    
    static var paragraph: UIFont {
        FontType.paragraph.font(forTextStyle: .body)
    }
    
    static var labelLarge: UIFont {
        FontType.labelLarge.font(forTextStyle: .body)
    }
}

extension Font {
    static func sourceSansPro(_ type: SourceSansPro,
                              size: CGFloat, forTextStyle
                              textStyle: Font.TextStyle? = nil) -> Font {
        FontType.sourceSansPro(type, size: size).font(forTextStyle: textStyle)
    }
    
    static var paragraph: Font {
        FontType.paragraph.font(forTextStyle: .body)
    }
    
    static var labelLarge: Font {
        FontType.labelLarge.font(forTextStyle: .body)
    }
}
