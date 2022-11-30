
// Created by Gayan Dias on 30/11/2022.

import XCTest
@testable import CurrencyConverter

class CurrencyConverterTests: XCTestCase {

    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}

    func test_CurrencyConverterViewModel_isButtonEnable_shouldBeFalse() {
        //Given
        let fromValue: String = ""
        let toValue: String = ""
        let amount: String = ""
        
        //When
        let vm = ConverterViewModel()
        vm.fromValue = fromValue
        vm.toValue = toValue
        vm.amount = amount
        
        //Then
        XCTAssertFalse(vm.isButtonEnable == ((fromValue.isEmpty) ||
                      (toValue.isEmpty) ||
                      (amount.isEmpty)))
    }
    
    func test_CurrencyConverterViewModel_isButtonEnable_shouldBeTrue() {
        //Given
        let fromValue: String = "GFT"
        let toValue: String = "HUI"
        let amount: String = "12"
        
        //When
        let vm = ConverterViewModel()
        vm.fromValue = fromValue
        vm.toValue = toValue
        vm.amount = amount
        
        //Then
        XCTAssertTrue(vm.isButtonEnable == (!(fromValue.isEmpty) ||
                      !(toValue.isEmpty) ||
                      !(amount.isEmpty)))
    }
    
    func test_CurrencyConverterViewModel_shouldShowResultView_shouldBeTrue() {
        //Given
        let currencyRate = self.testData()
        
        //When
        let vm = ConverterViewModel()
        vm.currencyRate = currencyRate
        
        //Then
        XCTAssertTrue(vm.shouldShowResultView == (currencyRate.success != nil))
    }
    
    func test_CurrencyListViewModel_isEmptyData_shouldtrue() {
        //Given
        let isAvailableData = (UserDefaultsManager.personList != nil)
        
        //When
        let vm = CurrencyListViewModel()

        //Then
        XCTAssertTrue(vm.isEmptyData == isAvailableData)
    }
    
    func test_CurrencyListViewModel_isEmptyData_shoulFalse() {
        //Given
        let isAvailableData = (UserDefaultsManager.personList == nil)
        
        //When
        let vm = CurrencyListViewModel()

        //Then
        XCTAssertFalse(vm.isEmptyData == isAvailableData)
    }
}
 

extension CurrencyConverterTests {
    func testData() -> CurrencyRate {
        let currency = CurrencyRate(success: true,
                                    query: QueryItem(form: "GHT",
                                                     to: "HJY",
                                                     amount: 12.88999),
                                    info: InfoData(timestamp: 123455,
                                                   quote: 12.000000),
                                    result: 12.99999)
        return currency
    }
}
