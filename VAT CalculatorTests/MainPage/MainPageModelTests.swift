import XCTest
@testable import VAT_Calculator

class VAT_CalculatorTests: XCTestCase {

    var sut: MainPageModel!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = MainPageModel()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testMainPageModelUpdateCharges() {
        let vatPercent = 5.0
        let feePercent = 7.0
        let serviceChargePercent = 10.0
        let calculateVatOnSc = true
        sut?.updateCharges(vatPercent: vatPercent,
                           feePercent: feePercent,
                           serviceChargePercent: serviceChargePercent,
                           calculateVatOnSc: calculateVatOnSc)
        XCTAssert(
            sut.vatPercent == vatPercent &&
            sut.feePercent == feePercent &&
            sut.serviceChargePercent == serviceChargePercent &&
            sut.calculateVatOnSc == calculateVatOnSc,
            "Something is wrong with charges init")
    }
    
    func testMainPageModelGrossCalculation() {
        var gross = sut?.gross
        XCTAssert(gross == 100, "Gross sales is incorrect")
        
        sut?.updateCharges(vatPercent: 5, feePercent: 7, serviceChargePercent: 10, calculateVatOnSc: true)
        gross = sut?.gross
        XCTAssert(gross == 122.5, "Gross sales is incorrect")
        
        sut?.updateCharges(vatPercent: 5, feePercent: 7, serviceChargePercent: 10, calculateVatOnSc: false)
        gross = sut?.gross
        XCTAssert(gross == 122, "Gross sales is incorrect")
    }
}
