struct MainPageModel {
    var vatPercent = 0.0
    var feePercent = 0.0
    var serviceChargePercent = 0.0
    var calculateVatOnSc = false
    var gross: Double {
        let vatOnSc = calculateVatOnSc ? serviceChargePercent * vatPercent / 100.0 : 0.0
        let gross = 100.0 + vatPercent + feePercent + serviceChargePercent + vatOnSc
        return gross
    }
}
