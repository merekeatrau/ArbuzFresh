//
//  SubscriptionViewController.swift
//  ArbuzFresh
//
//  Created by Mereke on 23.05.2023.
//

import UIKit

class SubscriptionViewController: UIViewController {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        scrollView.keyboardDismissMode = .interactive
        return scrollView
    }()
    
    private let proceedCheckoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Оформить подписку", for: .normal)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = 24
        return button
    }()
    
    private let contentView: UIView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setNavBar()
        setupScrollView()
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.right.equalTo(view)
            make.width.equalTo(scrollView)
        }
        
        let fieldsData = ["Адрес доставки", "Выбор дня доставки", "Номер телефона", "Срок подписки", "Имя"]
        var previousField: UITextField?
        
        for data in fieldsData {
            let textField = createPaddedTextField(placeholder: data)
            contentView.addSubview(textField)
            textField.snp.makeConstraints { make in
                if let previousField = previousField {
                    make.top.equalTo(previousField.snp.bottom).offset(16)
                } else {
                    make.top.equalToSuperview().offset(16)
                }
                make.left.right.equalToSuperview().inset(16)
            }
            previousField = textField
        }
        
        contentView.addSubview(proceedCheckoutButton)
        proceedCheckoutButton.snp.makeConstraints { make in
            make.top.equalTo(previousField!.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }
        proceedCheckoutButton.addTarget(self, action: #selector(cancelSubcriptionProcess), for: .touchUpInside)
        
        contentView.snp.makeConstraints { make in
            make.bottom.equalTo(proceedCheckoutButton.snp.bottom).offset(16)
        }
    }
    
    private func setNavBar() {
        title = "Оформление"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: createSignOutButton())]
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        navigationController?.navigationBar.tintColor = .systemGreen
    }
    
    private func createSignOutButton() -> UIButton {
        let signOutImage = UIImage(systemName: "xmark")
        let signOutButton = UIButton(type: .system)
        signOutButton.setImage(signOutImage, for: .normal)
        signOutButton.tintColor = .systemGreen
        return signOutButton
    }
    
    private func createPaddedTextField(placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.black.withAlphaComponent(0.1).cgColor
        textField.layer.cornerRadius = 25
        textField.tintColor = .systemGreen
        textField.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        let systemImageName: String
        switch placeholder {
        case "Адрес доставки":
            systemImageName = "house"
        case "Выбор дня доставки":
            systemImageName = "calendar"
        case "Номер телефона":
            systemImageName = "phone"
        case "Срок подписки":
            systemImageName = "clock"
        case "Имя":
            systemImageName = "person"
        default:
            systemImageName = "questionmark"
        }
        
        let imageView = UIImageView(image: UIImage(systemName: systemImageName))
        imageView.tintColor = .systemGreen
        imageView.contentMode = .scaleAspectFit
        
        let iconContainerView: UIView = UIView(frame: CGRect(x: 8, y: 0, width: 60, height: 24))
        iconContainerView.addSubview(imageView)
        imageView.center = iconContainerView.center
        textField.leftView = iconContainerView
        textField.leftViewMode = .always
        
        if placeholder == "Период подписки" || placeholder == "Срок подписки" {
            let datePicker = UIDatePicker()
            datePicker.datePickerMode = .date
            datePicker.preferredDatePickerStyle = .wheels
            datePicker.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)
            textField.inputView = datePicker
        }
        
        return textField
    }
    
    @objc private func handleDatePicker(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        if let activeTextField = view.currentFirstResponder() as? UITextField {
            activeTextField.text = dateFormatter.string(from: sender.date)
        }
    }
    
    @objc func cancelSubcriptionProcess() {
        dismiss(animated: true, completion: nil)
    }
}

extension UIView {
    func currentFirstResponder() -> UIResponder? {
        if isFirstResponder {
            return self
        }
        for view in subviews {
            if let responder = view.currentFirstResponder() {
                return responder
            }
        }
        return nil
    }
}
