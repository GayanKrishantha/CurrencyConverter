
// Created by Gayan Dias on 28/11/2022.

import SwiftUI

struct CurrencyConverterView: View {
    
    @ObservedObject var viewModel: ConverterViewModel = ConverterViewModel()
    
    var body: some View {
        NavigationView {
            ZStack(){
                GeometryReader { geometry in
                    ScrollView(){
                        LazyVStack(alignment: .center, spacing: 10) {
                            if viewModel.isLoading {
                                Loading(displayText: L10n.Label.fetching)
                                .frame(width: geometry.size.width)
                                .frame(minHeight: geometry.size.height)
                            } else {
                                Field(title: L10n.Label.amount) { value in
                                    self.viewModel.amount = value
                                }
                                DroupDown(title: L10n.Label.from,
                                          isFromDroupDownSelect: true) { currency in
                                    self.viewModel.fromValue = currency.code
                                }
                                DroupDown(title: L10n.Label.to,
                                          isFromDroupDownSelect: false) { currency in
                                    self.viewModel.toValue = currency.code
                                }
                                Action(isButonEnable: viewModel.isButtonEnable) {
                                    viewModel.getCurrencyRate()
                                }
                                if viewModel.shouldShowResultView {
                                    Result(rate: viewModel.currencyRate)
                                }
                                Spacer()
                            }
                        }.navigationTitle(L10n.Navigation.Title.main)
                            .padding([.leading, .trailing, .top],16)
                    }
                    .alert(item: $viewModel.alertMessage,
                           content: Alert.init)
                }.onTapGesture {
                    _ = viewModel.isButtonEnable
                    endTextEditing()
                }
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct CurrencyConverterView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyConverterView()
    }
}
