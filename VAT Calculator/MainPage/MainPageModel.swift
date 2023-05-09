struct MainPageModel {
    private(set) var vatPercent = 0.0
    private(set) var feePercent = 0.0
    private(set) var serviceChargePercent = 0.0
    private(set) var calculateVatOnSc = false
    
    mutating func updateCharges(vatPercent: Double, feePercent: Double, serviceChargePercent: Double, calculateVatOnSc: Bool) {
        self.vatPercent = vatPercent
        self.feePercent = feePercent
        self.serviceChargePercent = serviceChargePercent
        self.calculateVatOnSc = calculateVatOnSc
    }
    
    func calculateGross() -> Double {
        let vatOnSc = calculateVatOnSc ? serviceChargePercent * vatPercent / 100.0 : 0.0
        let gross = 100.0 + vatPercent + feePercent + serviceChargePercent + vatOnSc
        return gross
    }
}
