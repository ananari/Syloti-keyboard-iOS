//
//  KeyboardViewController.swift
//  Sylheti keyboard
//
//  Created by 9999 on 4/29/20.
//  Copyright © 2020 Anaïs. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {

    @IBOutlet var nextKeyboardButton: UIButton!
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    var isCaps = false;
    var allButtons = [UIButton]();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Perform custom UI setup here
        
        
        func createButton(title: String?, colour: CGFloat = 1.0, type: UIButton.ButtonType = .system) -> UIButton {
            let button = UIButton(type: type)
            button.setTitle(title, for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false;
            button.sizeToFit()
            button.backgroundColor = UIColor(white: colour, alpha: 1.0)
            button.setTitleColor(.darkGray, for: .normal)
            button.layer.cornerRadius = 5;
            button.layer.shadowRadius = 1;
            button.layer.shadowColor = UIColor(white: 0.4, alpha: 1.0).cgColor;
            button.layer.shadowOpacity = 1;
            button.layer.shadowRadius = 0;
            button.layer.shadowOffset = CGSize(width: 0, height: 1)
            button.frame.size = CGSize(width: 30, height: 40)
            return button;
        }
        
        self.nextKeyboardButton = createButton(title: "🌐", colour: 0.9)
        self.nextKeyboardButton.setTitle(NSLocalizedString("🌐", comment: "Title for 'Next Keyboard' button"), for: [])
        self.nextKeyboardButton.sizeToFit()
        
        self.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
//        self.nextKeyboardButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
//        self.nextKeyboardButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
//        self.view.addSubview(self.nextKeyboardButton)
        let topButtonTitles = ["ꠂ", "ꠣ", "ꠛ", "ꠢ", "ꠉ", "ꠖ", "ꠎ", "ꠒ", "ꠐ", "ꠠ"]
        let middleButtonTitles = ["ꠧ", "ꠦ", "\u{A806}", "ꠤ", "ꠥ", "ꠙ", "ꠞ", "ꠇ", "ꠔ", "ꠌ", "ꠐ"]
        let bottomButtonTitles = ["ꠋ", "ꠝ", "ꠘ", "ꠟ", "ꠡ"]
        func addKeys(titles: [String]) -> UIView {
            
            let RowStackView = UIStackView.init()
            RowStackView.spacing = 5
            RowStackView.axis = .horizontal
            RowStackView.alignment = .fill
            RowStackView.distribution = .fillEqually
            
            for title in titles {
                let button = createButton(title: title)
                button.addTarget(self, action:#selector(KeyboardViewController.keyPressed(_:)), for: .touchUpInside)
                allButtons.append(button)
                RowStackView.addArrangedSubview(button)
            }
            
            let viewDict = ["RowStackView": RowStackView]
            
            let keysView = UIStackView()
            keysView.backgroundColor = .clear
            keysView.addArrangedSubview(RowStackView)
            keysView.addConstraints(NSLayoutConstraint.constraints(
                withVisualFormat: "H:|[RowStackView]|", metrics: nil, views: viewDict))
            keysView.addConstraints(NSLayoutConstraint.constraints(
                withVisualFormat: "V:|[RowStackView]|", metrics: nil, views: viewDict))
            return keysView
        }
        
        let shiftButton = createButton(title: "↑", colour: 0.9, type: .custom)
        shiftButton.addTarget(self, action:#selector(toggleCaps), for: .touchUpInside)

        
        let deleteButton = createButton(title: nil, colour: 0.9, type: .custom)
        let delImage = #imageLiteral(resourceName: "delete")
        deleteButton.setBackgroundImage(delImage, for: .normal)
        deleteButton.addTarget(self, action:#selector(handleDelete(sender:)), for: .touchUpInside)
        
        
        let spaceButton = createButton(title: " ")
        spaceButton.addTarget(self, action:#selector(keyPressed(_:)), for: .touchUpInside)
        
        let returnButton = createButton(title: "return")
        returnButton.addTarget(self, action:#selector(handleReturn), for: .touchUpInside)
        returnButton.backgroundColor = .systemBlue
        returnButton.setTitleColor(.white, for: .normal)
        
        let topRow = addKeys(titles: topButtonTitles)
        let middleRow = addKeys(titles: middleButtonTitles)
        let bottomKeys = addKeys(titles: bottomButtonTitles)
        let bottomRow = UIStackView(arrangedSubviews: [shiftButton, bottomKeys, deleteButton])
        bottomRow.distribution = .fillProportionally
        bottomRow.spacing = 5
        let functionRow = UIStackView(arrangedSubviews: [self.nextKeyboardButton, spaceButton, returnButton])
        functionRow.distribution = .fillProportionally
        functionRow.spacing = 5
        spaceButton.widthAnchor.constraint(equalTo: spaceButton.superview!.widthAnchor, multiplier: 0.5).isActive = true
        
        
        let mainStackView = UIStackView(arrangedSubviews: [topRow,middleRow,bottomRow, functionRow])
        mainStackView.axis = .vertical
        mainStackView.spacing = 3.0
        mainStackView.distribution = .fillEqually
        mainStackView.alignment = .fill
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mainStackView)
        
        mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 2).isActive = true
        mainStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 2).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -2).isActive = true
        mainStackView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
    }
    
    @objc func keyPressed(_ sender: UIButton?) {
        let button = sender! as UIButton
        let title = button.title(for: .normal)
        (textDocumentProxy as UIKeyInput).insertText(title!)
    }
    
    @objc func handleDelete(sender: UIButton?) {
        (textDocumentProxy as UIKeyInput).deleteBackward()
    }
    
    @objc func handleReturn() {
        (textDocumentProxy as UIKeyInput).insertText("\n")
    }
    
    @objc func toggleCaps(_ sender: UIButton?) {
        let capsDict: [String: String] = [
            "ꠒ": "ꠓ",
            "ꠓ": "ꠒ",
            "ꠙ": "ꠚ",
            "ꠚ": "ꠙ",
            "ꠐ": "ꠑ",
            "ꠑ": "ꠐ",
            "ꠌ": "ꠍ",
            "ꠍ": "ꠌ",
            "ꠎ": "ꠏ",
            "ꠏ": "ꠎ",
            "ꠥ": "ꠃ",
            "ꠃ": "ꠥ",
            "ꠤ": "ꠁ",
            "ꠁ": "ꠤ",
            "ꠉ": "ꠊ",
            "ꠊ": "ꠉ",
            "ꠛ": "ꠜ",
            "ꠜ": "ꠛ",
            "ꠣ": "ꠀ",
            "ꠀ": "ꠣ",
            "ꠇ": "ꠈ",
            "ꠈ": "ꠇ",
            "ꠔ": "ꠕ",
            "ꠕ": "ꠔ",
            "ꠖ": "ꠗ",
            "ꠗ": "ꠖ",
            "ꠧ": "ꠅ",
            "ꠅ": "ꠧ",
            "ꠦ": "ꠄ",
            "ꠄ": "ꠦ"
        ]
        
        for button in allButtons {
            let title = button.title(for: .normal)!
            if capsDict[title] != nil {
                button.setTitle(capsDict[title], for: .normal)
            }
        }
        
    }
    
    
    override func viewWillLayoutSubviews() {
        self.nextKeyboardButton.isHidden = !self.needsInputModeSwitchKey
        super.viewWillLayoutSubviews()
    }
    
    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
        
        var textColor: UIColor
        let proxy = self.textDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
            textColor = UIColor.white
        } else {
            textColor = UIColor.black
        }
        self.nextKeyboardButton.setTitleColor(textColor, for: [])
    }

}
