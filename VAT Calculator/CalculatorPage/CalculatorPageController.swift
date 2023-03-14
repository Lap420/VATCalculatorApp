//
//  CalculatorPageController.swift
//  VAT Calculator
//
//  Created by Lap on 14.03.2023.
//

// TODO: знаки после запятой на втором экране

import UIKit

class CalculatorPageController: UIViewController {
    // MARK: - Publ properties
//    var vat = 0.0
//    var fee = 0.0
//    var serviceCharge = 0.0
//    var calculateVatOnSc = true
    
    // MARK: - View Lifecycle
    init(vatPercent: Double, feePercent: Double, serviceChargePercent: Double, calculateVatOnSc: Bool) {
        super.init(nibName: nil, bundle: nil)
        self.vatPercent = vatPercent
        self.feePercent = feePercent
        self.serviceChargePercent = serviceChargePercent
        self.calculateVatOnSc = calculateVatOnSc
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()        
    }
    
    // MARK: - Private constants
    private enum UIConstants {
        static let fontSizeHeader: CGFloat = 20
        static let fontSizeMain: CGFloat = 20
        static let fontSizeButton: CGFloat = 20
        static let menuItemsOffset: CGFloat = 16
        static let contentInset: CGFloat = 16
        static let afterGrossCustomSpacing: CGFloat = 50
    }

    // MARK: - Private properties
    private var vatPercent = 0.0
    private var feePercent = 0.0
    private var serviceChargePercent = 0.0
    private var calculateVatOnSc = false
}

// MARK: - Private methods
private extension CalculatorPageController {
    func initialize() {
        view.backgroundColor = .init(named: "BackgroundColor")
        navigationItem.title = "VAT Calculator"
        let attributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: UIConstants.fontSizeHeader)]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
    }
}
