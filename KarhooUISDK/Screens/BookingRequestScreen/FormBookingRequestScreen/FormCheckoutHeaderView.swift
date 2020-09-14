//
//  GuestCheckoutHeaderView.swift
//  KarhooUISDK
//
//  Copyright © 2020 Karhoo All rights reserved.
//

import UIKit
import KarhooSDK

public struct KHFormCheckoutHeaderViewID {
    public static let view = "guest_checkout_header_view"
    public static let logo = "logo_image"
    public static let rideDetailsContainer = "ride_details_stack_view"
    public static let name = "name_label"
    public static let rideInfoView = "ride_info_view"
    public static let etaTitle = "eta_title_label"
    public static let etaText = "eta_text_label"
    public static let estimatedPrice = "estimated_price_title_label"
    public static let priceText = "price_text_label"
    public static let carType = "car_type_label"
}

final class FormCheckoutHeaderView: UIView {
    
    private var didSetupConstraints: Bool = false
    
    private var logoLoadingImageView: LoadingImageView!
    private var rideDetailStackView: UIStackView!
    private var name: UILabel!
    private var carType: UILabel!
    private var vehicleCapacityView: VehicleCapacityView!
    
    private var rideInfoView: UIView!
    private var etaTitle: UILabel!
    private var etaText: UILabel!
    private var priceTitle: UILabel!
    private var priceText: UILabel!
    
    init() {
        super.init(frame: .zero)
        self.setUpView()
    }
    
    convenience init(viewModel: QuoteViewModel) {
        self.init()
        self.set(viewModel: viewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpView() {
        translatesAutoresizingMaskIntoConstraints = false
        accessibilityIdentifier = KHFormCheckoutHeaderViewID.view
        
        logoLoadingImageView = LoadingImageView()
        logoLoadingImageView.accessibilityIdentifier = KHFormCheckoutHeaderViewID.logo
        logoLoadingImageView.layer.cornerRadius = 5.0
        logoLoadingImageView.layer.borderColor = KarhooUI.colors.lightGrey.cgColor
        logoLoadingImageView.layer.borderWidth = 0.5
        logoLoadingImageView.layer.masksToBounds = true
        addSubview(logoLoadingImageView)
        
        rideDetailStackView = UIStackView()
        rideDetailStackView.translatesAutoresizingMaskIntoConstraints = false
        rideDetailStackView.accessibilityIdentifier = KHFormCheckoutHeaderViewID.rideDetailsContainer
        rideDetailStackView.axis = .vertical
        rideDetailStackView.spacing = 8.0
        addSubview(rideDetailStackView)
        
        name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.accessibilityIdentifier = KHFormCheckoutHeaderViewID.name
        name.textColor = KarhooUI.colors.black
        name.font = KarhooUI.fonts.getBoldFont(withSize: 16.0)
        name.numberOfLines = 0
        rideDetailStackView.addArrangedSubview(name)
        
        carType = UILabel()
        carType.translatesAutoresizingMaskIntoConstraints = false
        carType.accessibilityIdentifier = KHFormCheckoutHeaderViewID.carType
        carType.font = KarhooUI.fonts.getRegularFont(withSize: 14.0)
        carType.textColor = KarhooUI.colors.guestCheckoutLightGrey
        rideDetailStackView.addArrangedSubview(carType)
        
        vehicleCapacityView = VehicleCapacityView()
        addSubview(vehicleCapacityView)
        
        rideInfoView = UIView()
        rideInfoView.translatesAutoresizingMaskIntoConstraints = false
        rideInfoView.accessibilityIdentifier = KHFormCheckoutHeaderViewID.rideInfoView
        rideInfoView.backgroundColor = KarhooUI.colors.guestCheckoutLightGrey
        rideInfoView.layer.masksToBounds = true
        rideInfoView.layer.cornerRadius = 8.0
        addSubview(rideInfoView)
        
        etaTitle = UILabel()
        etaTitle.translatesAutoresizingMaskIntoConstraints = false
        etaTitle.accessibilityIdentifier = KHFormCheckoutHeaderViewID.etaTitle
        etaTitle.textColor = KarhooUI.colors.white
        etaTitle.font = KarhooUI.fonts.getRegularFont(withSize: 12.0)
        etaTitle.text = UITexts.Generic.etaLong.uppercased()
        rideInfoView.addSubview(etaTitle)
        
        etaText = UILabel()
        etaText.translatesAutoresizingMaskIntoConstraints = false
        etaText.accessibilityIdentifier = KHFormCheckoutHeaderViewID.etaText
        etaText.textColor = KarhooUI.colors.white
        etaText.font = KarhooUI.fonts.getBoldFont(withSize: 24.0)
        rideInfoView.addSubview(etaText)

        priceTitle = UILabel()
        priceTitle.translatesAutoresizingMaskIntoConstraints = false
        priceTitle.accessibilityIdentifier = KHFormCheckoutHeaderViewID.estimatedPrice
        priceTitle.textColor = KarhooUI.colors.white
        priceTitle.textAlignment = .right
        priceTitle.font = KarhooUI.fonts.getRegularFont(withSize: 12.0)
        priceTitle.text = UITexts.Generic.estimatedPrice.uppercased()
        rideInfoView.addSubview(priceTitle)
        
        priceText = UILabel()
        priceText.translatesAutoresizingMaskIntoConstraints = false
        priceText.accessibilityIdentifier = KHFormCheckoutHeaderViewID.priceText
        priceText.textColor = KarhooUI.colors.white
        priceText.textAlignment = .right
        priceText.font = KarhooUI.fonts.getBoldFont(withSize: 24.0)
        rideInfoView.addSubview(priceText)
    }
    
    override func updateConstraints() {
        if !didSetupConstraints {
            let logoSize: CGFloat = 60.0
            _ = [logoLoadingImageView.widthAnchor.constraint(equalToConstant: logoSize),
                 logoLoadingImageView.heightAnchor.constraint(equalToConstant: logoSize),
                 logoLoadingImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
                 logoLoadingImageView.topAnchor.constraint(equalTo: topAnchor, constant: 20.0)]
                .map { $0.isActive = true }
            
            _ = [rideDetailStackView.centerYAnchor.constraint(equalTo: logoLoadingImageView.centerYAnchor),
                 rideDetailStackView.leadingAnchor.constraint(equalTo: logoLoadingImageView.trailingAnchor,
                                                              constant: 10.0),
                 rideDetailStackView.trailingAnchor.constraint(lessThanOrEqualTo: vehicleCapacityView.leadingAnchor,
                                                               constant: -10.0)].map { $0.isActive = true }
            
            _ = [vehicleCapacityView.centerYAnchor.constraint(equalTo: logoLoadingImageView.centerYAnchor),
                 vehicleCapacityView.trailingAnchor.constraint(equalTo: trailingAnchor)].map { $0.isActive = true }
            
            _ = [rideInfoView.topAnchor.constraint(equalTo: logoLoadingImageView.bottomAnchor, constant: 15.0),
                 rideInfoView.leadingAnchor.constraint(equalTo: logoLoadingImageView.leadingAnchor, constant: 10.0),
                 rideInfoView.trailingAnchor.constraint(equalTo: vehicleCapacityView.trailingAnchor, constant: -10.0),
                 rideInfoView.bottomAnchor.constraint(equalTo: bottomAnchor)].map { $0.isActive = true }
            
            _ = [etaTitle.leadingAnchor.constraint(equalTo: rideInfoView.leadingAnchor, constant: 10.0),
                 etaTitle.topAnchor.constraint(equalTo: rideInfoView.topAnchor, constant: 10.0),
                 etaTitle.trailingAnchor.constraint(lessThanOrEqualTo: priceTitle.leadingAnchor,
                                                    constant: 20.0)].map { $0.isActive = true }
            
            _ = [etaText.leadingAnchor.constraint(equalTo: etaTitle.leadingAnchor),
                 etaText.topAnchor.constraint(equalTo: etaTitle.bottomAnchor, constant: 5.0),
                 etaText.trailingAnchor.constraint(lessThanOrEqualTo: priceText.leadingAnchor, constant: 20.0),
                 etaText.bottomAnchor.constraint(equalTo: rideInfoView.bottomAnchor, constant: -10.0)]
                .map { $0.isActive = true }
            
            _ = [priceTitle.trailingAnchor.constraint(equalTo: rideInfoView.trailingAnchor, constant: -10.0),
                 priceTitle.topAnchor.constraint(equalTo: rideInfoView.topAnchor,
                                                 constant: 10.0)].map { $0.isActive = true }
            
            _ = [priceText.trailingAnchor.constraint(equalTo: priceTitle.trailingAnchor),
                 priceText.topAnchor.constraint(equalTo: priceTitle.bottomAnchor, constant: 5.0),
                 priceText.bottomAnchor.constraint(equalTo: rideInfoView.bottomAnchor,
                                                   constant: -10.0)].map { $0.isActive = true }
            
            didSetupConstraints = true
        }
        
        super.updateConstraints()
    }
    
    func set(viewModel: QuoteViewModel) {
        name.text = viewModel.fleetName
        etaText.text = viewModel.eta
        carType.text = viewModel.carType
        priceText.text = viewModel.fare
        logoLoadingImageView.load(imageURL: viewModel.logoImageURL,
                                  placeholderImageName: "supplier_logo_placeholder")
        logoLoadingImageView.setStandardBorder()
        vehicleCapacityView.setPassengerCapacity(viewModel.passengerCapacity)
        vehicleCapacityView.setBaggageCapacity(viewModel.baggageCapacity)
        
        updateConstraints()
    }
}