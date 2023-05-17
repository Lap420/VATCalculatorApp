//
//  VAT_CalculatorTests.swift
//  VAT CalculatorTests
//
//  Created by Lap on 15.05.2023.
//

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
        sut?.updateCharges(vatPercent: 5, feePercent: 7, serviceChargePercent: 10, calculateVatOnSc: true)
        XCTAssert(
            sut.vatPercent == 5 &&
            sut.feePercent == 7 &&
            sut.serviceChargePercent == 10 &&
            sut.calculateVatOnSc == true,
            "Something is wrong with charges init")
    }
    
    func testMainPageModelGrossCalculation() {
        var gross = sut?.calculateGross()
        XCTAssert(gross == 100, "Gross sales is incorrect")
        
        sut?.updateCharges(vatPercent: 5, feePercent: 7, serviceChargePercent: 10, calculateVatOnSc: true)
        gross = sut?.calculateGross()
        XCTAssert(gross == 122.5, "Gross sales is incorrect")
        
        sut?.updateCharges(vatPercent: 5, feePercent: 7, serviceChargePercent: 10, calculateVatOnSc: false)
        gross = sut?.calculateGross()
        XCTAssert(gross == 122, "Gross sales is incorrect")
    }
}
