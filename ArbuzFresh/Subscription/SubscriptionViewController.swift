//
//  SubscriptionViewController.swift
//  ArbuzFresh
//
//  Created by Mereke on 23.05.2023.
//

import UIKit
import PhoneNumberKit

class SubscriptionViewController: UIViewController {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        scrollView.keyboardDismissMode = .interactive
        return scrollView
    }()
    
    let phoneNumberKit = PhoneNumberKit()
    
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
        
        let fieldsData = ["Адрес доставки", "День недели", "Номер телефона", "Срок подписки", "Имя"]
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
        proceedCheckoutButton.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
        
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
        case "День недели":
            systemImageName = "person"
            
            let pickerView = UIPickerView()
            pickerView.delegate = self
            pickerView.dataSource = self
            textField.inputView = pickerView
        case "Номер телефона":
            systemImageName = "phone"
            textField.textContentType = .telephoneNumber
            textField.keyboardType = .phonePad
            textField.addTarget(self, action: #selector(formatPhoneNumber(_:)), for: .editingChanged)
        case "Срок подписки":
            systemImageName = "clock"
            
            let pickerView = UIPickerView()
            pickerView.delegate = self
            pickerView.dataSource = self
            textField.inputView = pickerView
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
        
        return textField
    }
    
    
    @objc private func handleDatePicker(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        if let activeTextField = view.currentFirstResponder() as? UITextField {
            activeTextField.text = dateFormatter.string(from: sender.date)
        }
    }
    
    @objc private func formatPhoneNumber(_ textField: UITextField) {
        if let text = textField.text {
            do {
                let phoneNumber = try phoneNumberKit.parse(text)
                let formattedNumber = phoneNumberKit.format(phoneNumber, toType: .national, withPrefix: true)
                textField.text = formattedNumber
            } catch {
                textField.text = text
            }
        }
    }
    
    @objc private func showAlert() {
        let alertController = UIAlertController(title: "Подтверждение подписки",
                                                message: "Вы уверены, что хотите оформить подписку?",
                                                preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        let confirmAction = UIAlertAction(title: "Подтвердить", style: .default) { [weak self] _ in
            let alertController = UIAlertController(title: "Подписка оформлена",
                                                    message: "Поздравляем! Ваша подписка успешно оформлена.",
                                                    preferredStyle: .alert)
            
            self?.present(alertController, animated: true, completion: nil)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                alertController.dismiss(animated: true) {
                    let homeViewController = HomeViewController()
                    self?.navigationController?.pushViewController(homeViewController, animated: true)
                }
            }
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(confirmAction)
        
        present(alertController, animated: true, completion: nil)
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

extension SubscriptionViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if let activeTextField = view.currentFirstResponder() as? UITextField, activeTextField.placeholder == "Срок подписки" {
            return 12
        }
        return 7
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if let activeTextField = view.currentFirstResponder() as? UITextField, activeTextField.placeholder == "Срок подписки" {
            return "\(row + 1) месяц"
        }
        return ["Понедельник", "Вторник", "Среда", "Четверг", "Пятница", "Суббота", "Воскресенье"][row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if let activeTextField = view.currentFirstResponder() as? UITextField {
            if activeTextField.placeholder == "Срок подписки" {
                activeTextField.text = "\(row + 1) месяц"
            } else {
                activeTextField.text = ["Понедельник", "Вторник", "Среда", "Четверг", "Пятница", "Суббота", "Воскресенье"][row]
            }
        }
    }
}
