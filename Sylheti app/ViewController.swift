//
//  ViewController.swift
//  Sylheti app
//
//  Created by Anaïs on 4/29/20.
//  Copyright © 2020 Anaïs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()
    }
    
    private lazy var label1 = UILabel()
     private lazy var label2 = UILabel()
     private lazy var label3 = UILabel()
     private lazy var label4 = UILabel()
     private lazy var label5 = UILabel()
     private lazy var label6 = UILabel()
     private lazy var label7 = UILabel()
     private lazy var label8 = UILabel()
     private lazy var textField = UITextField()
     private lazy var label9 = UILabel()
     private lazy var stackView = UIStackView()

     private func setupUI() {

        view.addSubview(stackView)

        view.backgroundColor = UIColor.systemGroupedBackground

        stackView.addArrangedSubview(label1)
        stackView.addArrangedSubview(label2)
        stackView.addArrangedSubview(label3)
        stackView.addArrangedSubview(label4)
        stackView.addArrangedSubview(label5)
        stackView.addArrangedSubview(label6)
        stackView.addArrangedSubview(label7)
        stackView.addArrangedSubview(label8)
        stackView.addArrangedSubview(textField)
        stackView.addArrangedSubview(label9)

        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false

        label9.contentMode = .left
        label9.font = UIFont.systemFont(ofSize: 17)
        label9.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: .horizontal)
        label9.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: .vertical)
        label9.text = "Feel free to try the Sylheti keyboard out!"
        label9.textAlignment = .center
        label9.translatesAutoresizingMaskIntoConstraints = false

        textField.borderStyle = .roundedRect
        textField.contentHorizontalAlignment = .left
        textField.contentVerticalAlignment = .center
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.minimumFontSize = 17
        textField.textAlignment = .natural
        textField.translatesAutoresizingMaskIntoConstraints = false

        label8.backgroundColor = UIColor.systemGray5

        label8.contentMode = .left
        label8.font = UIFont.systemFont(ofSize: 17)
        label8.numberOfLines = 0
        label8.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: .horizontal)
        label8.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: .vertical)
        label8.text = "7. Tap \"Sylheti keyboard\" in the list of installed keyboards and allow full access (not necessary but recommended - this app does not store anything you type)."
        label8.textAlignment = .center
        label8.translatesAutoresizingMaskIntoConstraints = false

        label7.contentMode = .left
        label7.font = UIFont.systemFont(ofSize: 17)
        label7.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: .horizontal)
        label7.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: .vertical)
        label7.text = "6. Add the Sylheti keyboard"
        label7.textAlignment = .center
        label7.translatesAutoresizingMaskIntoConstraints = false

        label6.backgroundColor = UIColor.systemGray5

        label6.contentMode = .left
        label6.font = UIFont.systemFont(ofSize: 17)
        label6.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: .horizontal)
        label6.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: .vertical)
        label6.text = "5. Tap \"Add New Keyboard\""
        label6.textAlignment = .center
        label6.translatesAutoresizingMaskIntoConstraints = false

        label5.contentMode = .left
        label5.font = UIFont.systemFont(ofSize: 17)
        label5.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: .horizontal)
        label5.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: .vertical)
        label5.text = "4. Tap \"Keyboards\""
        label5.textAlignment = .center
        label5.translatesAutoresizingMaskIntoConstraints = false


        label4.backgroundColor = UIColor.systemGray5

        label4.contentMode = .left
        label4.font = UIFont.systemFont(ofSize: 17)
        label4.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: .horizontal)
        label4.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: .vertical)
        label4.text = "3. Tap \"Keyboard\""
        label4.textAlignment = .center
        label4.translatesAutoresizingMaskIntoConstraints = false

        label3.contentMode = .left
        label3.font = UIFont.systemFont(ofSize: 17)
        label3.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: .horizontal)
        label3.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: .vertical)
        label3.text = "2. Tap \"General\""
        label3.textAlignment = .center
        label3.translatesAutoresizingMaskIntoConstraints = false

        label2.backgroundColor = UIColor.systemGray5

        label2.contentMode = .left
        label2.font = UIFont.systemFont(ofSize: 17)
        label2.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: .horizontal)
        label2.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: .vertical)
        label2.text = "1. Go to Settings "
        label2.textAlignment = .center
        label2.translatesAutoresizingMaskIntoConstraints = false

        label1.backgroundColor = UIColor.systemTeal
        label1.contentMode = .left
        label1.font = UIFont.systemFont(ofSize: 17)
        label1.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: .horizontal)
        label1.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: .vertical)
        label1.text = "Installation guide"
        label1.textAlignment = .center
        label1.translatesAutoresizingMaskIntoConstraints = false
     }

     private func setupLayout() {

        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: stackView.trailingAnchor).isActive = true

        label1.heightAnchor.constraint(equalToConstant: 30).isActive = true
     }

    

}
