import XCTest
@testable import VAT_Calculator

class CalculatorPageModelTests: XCTestCase {

    var calculatorPageModel: CalculatorPageModel!
    
    override func setUpWithError() throws {
        calculatorPageModel = CalculatorPageModel()
    }

    override func tearDownWithError() throws {
        calculatorPageModel = nil
    }
    
    func testInitCharges() throws {
        let vatPercent = 5.0
        let feePercent = 7.0
        let serviceChargePercent = 10.0
        let calculateVatOnSc = true
        calculatorPageModel.setCharges(vatPercent: vatPercent, feePercent: feePercent, serviceChargePercent: serviceChargePercent, calculateVatOnSc: calculateVatOnSc)
        XCTAssertEqual(vatPercent, calculatorPageModel.vatPercent)
        XCTAssertEqual(feePercent, calculatorPageModel.feePercent)
        XCTAssertEqual(serviceChargePercent, calculatorPageModel.serviceChargePercent)
        XCTAssertEqual(calculateVatOnSc, calculatorPageModel.calculateVatOnSc)
    }
    
    func testSettingNet() throws {
        let netSales = 100.0
        calculatorPageModel.setNet(netSales)
        XCTAssertEqual(netSales, calculatorPageModel.netSales)
    }
    
    func testGettingNetInitiatedByNet() {
        let netSales = 100.0
        calculatorPageModel.setNet(netSales)
        let testedNetSales = calculatorPageModel.getNet(.initiatedByNet)
        XCTAssertEqual(netSales, testedNetSales)
    }
    
    func testGettingNetInitiatedByGross() {
        var gross = 122.5
        let vatPercent = 5.0
        let feePercent = 7.0
        let serviceChargePercent = 10.0
        var calculateVatOnSc = true
        calculatorPageModel.setGross(gross)
        calculatorPageModel.setCharges(vatPercent: vatPercent, feePercent: feePercent, serviceChargePercent: serviceChargePercent, calculateVatOnSc: calculateVatOnSc)
        var testedNetSales = calculatorPageModel.getNet(.initiatedByGross)
        XCTAssertEqual(100, testedNetSales)
        
        gross = 122
        calculateVatOnSc = false
        calculatorPageModel.setGross(gross)
        calculatorPageModel.setCharges(vatPercent: vatPercent, feePercent: feePercent, serviceChargePercent: serviceChargePercent, calculateVatOnSc: calculateVatOnSc)
        testedNetSales = calculatorPageModel.getNet(.initiatedByGross)
        XCTAssertEqual(100, testedNetSales)
    }
    
    func testGettingVatInitiatedByNet() {
        let netSales = 100.0
        calculatorPageModel.setNet(netSales)
        let vatPercent = 5.0
        calculatorPageModel.setCharges(vatPercent: vatPercent, feePercent: 0, serviceChargePercent: 0, calculateVatOnSc: false)
        let testedVat = calculatorPageModel.getVat(.initiatedByNet)
        XCTAssertEqual(5, testedVat)
    }
    
    func testGettingVatInitiatedByGross() {
        var gross = 122.5
        calculatorPageModel.setGross(gross)
        let vatPercent = 5.0
        let feePercent = 7.0
        let serviceChargePercent = 10.0
        var calculateVatOnSc = true
        calculatorPageModel.setCharges(vatPercent: vatPercent, feePercent: feePercent, serviceChargePercent: serviceChargePercent, calculateVatOnSc: calculateVatOnSc)
        var testedVat = calculatorPageModel.getVat(.initiatedByGross)
        XCTAssertEqual(5, testedVat)
        
        gross = 122
        calculateVatOnSc = false
        calculatorPageModel.setGross(gross)
        calculatorPageModel.setCharges(vatPercent: vatPercent, feePercent: feePercent, serviceChargePercent: serviceChargePercent, calculateVatOnSc: calculateVatOnSc)
        testedVat = calculatorPageModel.getVat(.initiatedByGross)
        XCTAssertEqual(5, testedVat)
    }
    
    func testGettingFeeInitiatedByNet() {
        let netSales = 100.0
        calculatorPageModel.setNet(netSales)
        let feePercent = 7.0
        calculatorPageModel.setCharges(vatPercent: 0, feePercent: feePercent, serviceChargePercent: 0, calculateVatOnSc: false)
        let testedFee = calculatorPageModel.getFee(.initiatedByNet)
        XCTAssertEqual(7, testedFee)
    }
    
    func testGettingFeeInitiatedByGross() {
        var gross = 122.5
        calculatorPageModel.setGross(gross)
        let vatPercent = 5.0
        let feePercent = 7.0
        let serviceChargePercent = 10.0
        var calculateVatOnSc = true
        calculatorPageModel.setCharges(vatPercent: vatPercent, feePercent: feePercent, serviceChargePercent: serviceChargePercent, calculateVatOnSc: calculateVatOnSc)
        var testedFee = calculatorPageModel.getFee(.initiatedByGross)
        XCTAssertEqual(7, testedFee)
        
        gross = 122
        calculateVatOnSc = false
        calculatorPageModel.setGross(gross)
        calculatorPageModel.setCharges(vatPercent: vatPercent, feePercent: feePercent, serviceChargePercent: serviceChargePercent, calculateVatOnSc: calculateVatOnSc)
        testedFee = calculatorPageModel.getFee(.initiatedByGross)
        XCTAssertEqual(7, testedFee)
    }
    
    func testGettingServiceChargeInitiatedByNet() {
        let netSales = 100.0
        calculatorPageModel.setNet(netSales)
        let scPercent = 10.0
        calculatorPageModel.setCharges(vatPercent: 0, feePercent: 0, serviceChargePercent: scPercent, calculateVatOnSc: false)
        let testedSc = calculatorPageModel.getServiceCharge(.initiatedByNet)
        XCTAssertEqual(10, testedSc)
    }
    
    func testGettingServiceChargeInitiatedByGross() {
        var gross = 122.5
        calculatorPageModel.setGross(gross)
        let vatPercent = 5.0
        let feePercent = 7.0
        let serviceChargePercent = 10.0
        var calculateVatOnSc = true
        calculatorPageModel.setCharges(vatPercent: vatPercent, feePercent: feePercent, serviceChargePercent: serviceChargePercent, calculateVatOnSc: calculateVatOnSc)
        var testedSc = calculatorPageModel.getServiceCharge(.initiatedByGross)
        XCTAssertEqual(10, testedSc)
        
        gross = 122
        calculateVatOnSc = false
        calculatorPageModel.setGross(gross)
        calculatorPageModel.setCharges(vatPercent: vatPercent, feePercent: feePercent, serviceChargePercent: serviceChargePercent, calculateVatOnSc: calculateVatOnSc)
        testedSc = calculatorPageModel.getServiceCharge(.initiatedByGross)
        XCTAssertEqual(10, testedSc)
    }
    
    func testGettingVatOnScInitiatedByNet() {
        let netSales = 100.0
        calculatorPageModel.setNet(netSales)
        let varPercent = 5.0
        let serviceChargePercent = 10.0
        var calculateVatOnSc = true
        calculatorPageModel.setCharges(vatPercent: varPercent, feePercent: 0, serviceChargePercent: serviceChargePercent, calculateVatOnSc: calculateVatOnSc)
        var testedVatOnSc = calculatorPageModel.getVatOnSc(.initiatedByNet)
        XCTAssertEqual(0.5, testedVatOnSc)
        
        calculateVatOnSc = false
        calculatorPageModel.setCharges(vatPercent: varPercent, feePercent: 0, serviceChargePercent: serviceChargePercent, calculateVatOnSc: calculateVatOnSc)
        testedVatOnSc = calculatorPageModel.getVatOnSc(.initiatedByNet)
        XCTAssertEqual(0, testedVatOnSc)
    }
    
    func testGettingVatOnScInitiatedByGross() {
        var gross = 122.5
        calculatorPageModel.setGross(gross)
        let vatPercent = 5.0
        let feePercent = 7.0
        let serviceChargePercent = 10.0
        var calculateVatOnSc = true
        calculatorPageModel.setCharges(vatPercent: vatPercent, feePercent: feePercent, serviceChargePercent: serviceChargePercent, calculateVatOnSc: calculateVatOnSc)
        var testedVatOnSc = calculatorPageModel.getVatOnSc(.initiatedByGross)
        XCTAssertEqual(0.5, testedVatOnSc)
        
        gross = 122
        calculateVatOnSc = false
        calculatorPageModel.setGross(gross)
        calculatorPageModel.setCharges(vatPercent: vatPercent, feePercent: feePercent, serviceChargePercent: serviceChargePercent, calculateVatOnSc: calculateVatOnSc)
        testedVatOnSc = calculatorPageModel.getVatOnSc(.initiatedByGross)
        XCTAssertEqual(0, testedVatOnSc)
    }
    
    func testGettingTotalVatInitiatedByNet() {
        let netSales = 100.0
        calculatorPageModel.setNet(netSales)
        let varPercent = 5.0
        let serviceChargePercent = 10.0
        var calculateVatOnSc = true
        calculatorPageModel.setCharges(vatPercent: varPercent, feePercent: 0, serviceChargePercent: serviceChargePercent, calculateVatOnSc: calculateVatOnSc)
        var testedTotalVat = calculatorPageModel.getTotalVat(.initiatedByNet)
        XCTAssertEqual(5.5, testedTotalVat)
        
        calculateVatOnSc = false
        calculatorPageModel.setCharges(vatPercent: varPercent, feePercent: 0, serviceChargePercent: serviceChargePercent, calculateVatOnSc: calculateVatOnSc)
        testedTotalVat = calculatorPageModel.getTotalVat(.initiatedByNet)
        XCTAssertEqual(5, testedTotalVat)
    }
    
    func testGettingTotalVatInitiatedByGross() {
        var gross = 122.5
        calculatorPageModel.setGross(gross)
        let vatPercent = 5.0
        let feePercent = 7.0
        let serviceChargePercent = 10.0
        var calculateVatOnSc = true
        calculatorPageModel.setCharges(vatPercent: vatPercent, feePercent: feePercent, serviceChargePercent: serviceChargePercent, calculateVatOnSc: calculateVatOnSc)
        var testedTotalVat = calculatorPageModel.getTotalVat(.initiatedByGross)
        XCTAssertEqual(5.5, testedTotalVat)
        
        gross = 122
        calculateVatOnSc = false
        calculatorPageModel.setGross(gross)
        calculatorPageModel.setCharges(vatPercent: vatPercent, feePercent: feePercent, serviceChargePercent: serviceChargePercent, calculateVatOnSc: calculateVatOnSc)
        testedTotalVat = calculatorPageModel.getTotalVat(.initiatedByGross)
        XCTAssertEqual(5, testedTotalVat)
    }
    
    func testSettingGross() {
        let gross = 100.0
        calculatorPageModel.setGross(gross)
        XCTAssertEqual(gross, calculatorPageModel.grossSales)
    }
    
    func testGettingGrossInitiatedByNet() {
        let netSales = 100.0
        let vatPercent = 5.0
        let feePercent = 7.0
        let serviceChargePercent = 10.0
        var calculateVatOnSc = true
        calculatorPageModel.setNet(netSales)
        calculatorPageModel.setCharges(vatPercent: vatPercent, feePercent: feePercent, serviceChargePercent: serviceChargePercent, calculateVatOnSc: calculateVatOnSc)
        var testedGross = calculatorPageModel.getGross(.initiatedByNet)
        XCTAssertEqual(122.5, testedGross)

        calculateVatOnSc = false
        calculatorPageModel.setCharges(vatPercent: vatPercent, feePercent: feePercent, serviceChargePercent: serviceChargePercent, calculateVatOnSc: calculateVatOnSc)
        testedGross = calculatorPageModel.getGross(.initiatedByNet)
        XCTAssertEqual(122, testedGross)
    }

    func testGettingGrossInitiatedByGross() {
        let gross = 100.0
        calculatorPageModel.setGross(gross)
        let testedGross = calculatorPageModel.getGross(.initiatedByGross)
        XCTAssertEqual(gross, testedGross)
    }
}
