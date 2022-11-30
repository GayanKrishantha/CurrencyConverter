
// Created by Gayan Dias on 29/11/2022.

import Foundation

class CurrencyListViewModel: ObservableObject {
    
    @Published var currencies: [CurrencyValue] = []
    
    func getSavedCurrincies() {
        if let savedPeople = UserDefaultsManager.personList {
            self.currencies = savedPeople as [CurrencyValue]
        }
    }
    
    var isEmptyData: Bool {
        (UserDefaultsManager.personList != nil) ?
        true :
        false
    }
}
