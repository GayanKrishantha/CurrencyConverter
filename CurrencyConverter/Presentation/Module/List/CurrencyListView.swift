
// Created by Gayan Dias on 29/11/2022.

import Foundation
import SwiftUI

struct CurrencyListModalView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: CurrencyListViewModel = CurrencyListViewModel()
    @State private var searchText = ""
    var didSelectCurrency: (CurrencyValue, Bool) -> ()
    var isSetFromCurrency: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 0)  {
                if !(viewModel.isEmptyData) {
                    Text(L10n.Label.notAvailable)
                        .font(.title2)
                } else {
                    List(searchResults, id:\.self) { item in
                        Button(action: {
                            self.didSelectCurrency(item, isSetFromCurrency)
                            presentationMode.wrappedValue.dismiss()
                        }){
                            LazyVStack(alignment: .leading, spacing: 5){
                                Text(item.code)
                                    .font(.labelLarge)
                                Text(item.description)
                                    .font(.labelLarge)
                                    .foregroundColor(Color("colors/button_disable"))
                            }
                        }
                        .foregroundColor(Color("colors/currency_list_textcolor"))
                    }
                }
            }
            .navigationTitle(L10n.Navigation.Title.search)
            .searchable(text: $searchText,
                        placement: .navigationBarDrawer(displayMode: .always),
                        prompt: L10n.Label.searchCurrencies)
            .listStyle(GroupedListStyle())
            .toolbar {
                buttonView
            }
        }
        .onAppear {
            viewModel.getSavedCurrincies()
        }
    }
    
    private var buttonView: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "xmark.circle").imageScale(.large)
                .foregroundColor(.blue)
        }
    }
    
    private var searchResults: [CurrencyValue] {
        searchText.isEmpty ?
        viewModel.currencies :
        viewModel.currencies.filter { $0.code.localizedCaseInsensitiveContains(searchText) }
    }
}
