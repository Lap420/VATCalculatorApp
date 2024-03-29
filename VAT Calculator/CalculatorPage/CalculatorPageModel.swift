enum CalculatorUpdateType {
    case initiatedByNet
    case initiatedByGross
}

struct CalculatorPageModel {
    private(set) var vatPercent = 0.0
    private(set) var feePercent = 0.0
    private(set) var serviceChargePercent = 0.0
    private(set) var netSales = 0.0
    private(set) var grossSales = 0.0
    private(set) var calculateVatOnSc = false
    
    mutating func setCharges(vatPercent: Double, feePercent: Double, serviceChargePercent: Double, calculateVatOnSc: Bool) {
        self.vatPercent = vatPercent
        self.feePercent = feePercent
        self.serviceChargePercent = serviceChargePercent
        self.calculateVatOnSc = calculateVatOnSc
    }
    
    mutating func setNet(_ netSales: Double) {
        self.netSales = netSales
    }
    
    func getNet(_ calculatorUpdateType: CalculatorUpdateType) -> Double {
        var net = 0.0
        switch calculatorUpdateType {
        case .initiatedByNet:
            net = netSales
        case .initiatedByGross:
            net = grossSales / (100 + vatPercent + feePercent + serviceChargePercent + (calculateVatOnSc ? serviceChargePercent * vatPercent / 100 : 0)) * 100
        }
        return net
    }
    
    func getVat(_ calculatorUpdateType: CalculatorUpdateType) -> Double {
        var vat = 0.0
        switch calculatorUpdateType {
        case .initiatedByNet:
            vat = netSales * vatPercent / 100
        case .initiatedByGross:
            vat = grossSales / (100 + vatPercent + feePercent + serviceChargePercent + (calculateVatOnSc ? serviceChargePercent * vatPercent / 100 : 0)) * vatPercent
        }
        return vat
    }
    
    func getFee(_ calculatorUpdateType: CalculatorUpdateType) -> Double {
        var fee = 0.0
        switch calculatorUpdateType {
        case .initiatedByNet:
            fee = netSales * feePercent / 100
        case .initiatedByGross:
            fee = grossSales / (100 + vatPercent + feePercent + serviceChargePercent + (calculateVatOnSc ? serviceChargePercent * vatPercent / 100 : 0)) * feePercent
        }
        return fee
    }
    
    func getServiceCharge(_ calculatorUpdateType: CalculatorUpdateType) -> Double {
        var serviceCharge = 0.0
        switch calculatorUpdateType {
        case .initiatedByNet:
            serviceCharge = netSales * serviceChargePercent / 100
        case .initiatedByGross:
            serviceCharge = grossSales / (100 + vatPercent + feePercent + serviceChargePercent + (calculateVatOnSc ? serviceChargePercent * vatPercent / 100 : 0)) * serviceChargePercent
        }
        return serviceCharge
    }
    
    func getVatOnSc(_ calculatorUpdateType: CalculatorUpdateType) -> Double {
        var vatOnSc = 0.0
        switch calculatorUpdateType {
        case .initiatedByNet:
            vatOnSc = netSales * serviceChargePercent / 100 * (calculateVatOnSc ? vatPercent / 100 : 0)
        case .initiatedByGross:
            vatOnSc = (grossSales / (100 + vatPercent + feePercent + serviceChargePercent + (calculateVatOnSc ? serviceChargePercent * vatPercent / 100 : 0)) * serviceChargePercent) * (calculateVatOnSc ? vatPercent / 100 : 0)
        }
        return vatOnSc
    }
    
    func getTotalVat(_ calculatorUpdateType: CalculatorUpdateType) -> Double {
        var totalVat = 0.0
        switch calculatorUpdateType {
        case .initiatedByNet:
            totalVat = netSales * (vatPercent + (calculateVatOnSc ? serviceChargePercent * vatPercent / 100 : 0)) / 100
        case .initiatedByGross:
            totalVat = grossSales / (100 + vatPercent + feePercent + serviceChargePercent + (calculateVatOnSc ? serviceChargePercent * vatPercent / 100 : 0)) * (vatPercent + (calculateVatOnSc ? serviceChargePercent * vatPercent / 100 : 0))
        }
        return totalVat
    }
    
    mutating func setGross(_ grossSales: Double) {
        self.grossSales = grossSales
    }
    
    mutating func getGross(_ calculatorUpdateType: CalculatorUpdateType) -> Double {
        var gross = 0.0
        switch calculatorUpdateType {
        case .initiatedByNet:
            gross = netSales * (100 + vatPercent + feePercent + serviceChargePercent + (calculateVatOnSc ? serviceChargePercent * vatPercent / 100 : 0)) / 100
            grossSales = gross
        case .initiatedByGross:
            gross = grossSales
        }
        return gross
    }
}
