
// Created by Gayan Dias on 29/11/2022.

import Foundation
import SwiftUI

struct ActivityIndicator: UIViewRepresentable {
    
    typealias UIViewType = UIActivityIndicatorView
    let style: UIActivityIndicatorView.Style
    
    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>)
    -> ActivityIndicator.UIViewType {
        return UIActivityIndicatorView(style: style)
    }
    
    func updateUIView(_ uiView: ActivityIndicator.UIViewType,
                      context: UIViewRepresentableContext<ActivityIndicator>) {
        uiView.startAnimating()
    }
}

struct Loading: View {
    
    @State var displayText: String?
    
    var body: some View {
        ZStack (alignment: .center){
            VStack (){
                ActivityIndicator(style: .large)
                Text(displayText ?? L10n.Label.loading)
            }
            .frame(width: 110, height: 110)
            .background(Color.secondary.colorInvert())
            .foregroundColor(Color.secondary)
            .cornerRadius(10)
            .opacity(10)
            .shadow(color: .secondary, radius: 10, x: 0, y: -1)
        }
    }
}

struct Loading_Previews: PreviewProvider {
    static var previews: some View {
        Loading()
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
