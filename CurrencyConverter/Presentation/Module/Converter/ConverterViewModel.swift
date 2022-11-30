
// Created by Gayan Dias on 27/11/2022.

import Foundation
import Combine

class ConverterViewModel: ObservableObject {
    
    var cancelable: Set<AnyCancellable> = []
    var isAsyncDataRefresh = false
    
    @Published var currencyRate: CurrencyRate?
    @Published var fromValue: String = ""
    @Published var toValue: String = ""
    @Published var amount: String = ""
    @Published var isLoading = false
    @Published var alertMessage: AlertMessage?
    
    init() {
        self.scheduleTimer()
        self.getProducts()
    }
    
    private func getProducts() {
        if isDataPersisted {
            return
        } else {
            self.isLoading = true
            self.isAsyncDataRefresh = false
            self.removePersistedData
            APIClient.dispatch(
                APIRouter.GetCurrencies(queryParams: APIParameters.CurrencyParams(
                    apikey: APIConstants.apiKey) ))
            .sink(
                receiveCompletion: { completion in
                    self.receiveCompletion(completion: completion)
                },
                receiveValue: { [weak self] response in
                    self?.receiveValue(response: response)
                }
            ).store(in: &cancelable)
        }
    }
    
    func getCurrencyRate() {
        self.isLoading = true
        APIClient.dispatch(
            APIRouter.GetCurrencyRate(queryParams:
                                        APIParameters.CurrencyRateParams(
                                            to: toValue,
                                            from: fromValue,
                                            amount: Double(amount),
                                            apikey: APIConstants.apiKey)
                                     ))
        .sink(
            receiveCompletion: { completion in
                self.receiveCompletion(completion: completion)
            },
            receiveValue: { [weak self] response in
                print(response)
                self?.currencyRate = response
            }
        ).store(in: &cancelable)
    }
    
    private func receiveCompletion(completion: (Subscribers.Completion<NetworkRequestError>)) {
        switch completion {
        case .failure(let error):
            self.alertMessage = AlertMessage(title: error.errorTitle,
                                             message: error.errorDescription)
            print(error.errorTitle, error.errorDescription)
        case .finished:
            print("Publisher is finished")
        }
        self.isLoading = false
    }
    
    private func receiveValue(response: (APIRouter.GetCurrencies.ReturnType)) {
        var currencies: [CurrencyValue] = []
        response.currencies.forEach { (key: String, value: String) in
            currencies.append(CurrencyValue(code: key, description: value))
        }
        
        UserDefaultsManager.personList = currencies
        self.isLoading = false
    }
    
    private func scheduleTimer() {
        let timer = Timer.scheduledTimer(timeInterval: 1800,
                                         target: self,
                                         selector: #selector(handleTimerExecution),
                                         userInfo: nil,
                                         repeats: true)
        RunLoop.current.add(timer, forMode: .common)
    }
    
    @objc private func handleTimerExecution() {
        self.isAsyncDataRefresh = true
        self.getProducts()
    }
    
    var isButtonEnable: Bool {
        return ((fromValue.isEmpty)
                || (toValue.isEmpty)
                || (amount.isEmpty )) ?
        false :
        true
    }
    
    var shouldShowResultView: Bool {
        return (self.currencyRate?.success != nil) ?
        true:
        false
    }
    
    private var removePersistedData: Void {
        UserDefaults.standard.removeObject(forKey: "currencyList")
    }
    
    private var isDataPersisted: Bool {
        return ((isKeyPresentInUserDefaults(key: "currencyList")) &&
                !isAsyncDataRefresh) ?
        true :
        false
    }
    
    private func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
}

