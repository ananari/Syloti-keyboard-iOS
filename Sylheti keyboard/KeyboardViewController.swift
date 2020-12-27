//
//  KeyboardViewController.swift
//  Sylheti keyboard
//
//  Created by Anaïs on 4/29/20.
//  Copyright © 2020 Anaïs. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {

    @IBOutlet var nextKeyboardButton: UIButton!
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    
    var allButtons = [UIButton]();
    var allTextButtons = [UIButton]();
    var mainStackView : UIStackView!
    var showChars: Bool = false
    var showBengaliNums: Bool = false
    var isCaps: Bool = false
    var kbAppearance: UIKeyboardAppearance = .default {
        didSet {
            if kbAppearance != oldValue {
                if kbAppearance == .dark {
                    for button in allButtons {
                        if button.tag == 1 {
                            button.backgroundColor = normalDarkKeyColour
                        }
                        else {
                            button.backgroundColor = specialDarkKeyColour
                        }
                        button.setTitleColor(.white, for: .normal)
                    }
                }
                else {
                    for button in allButtons {
                        if button.tag == 1 {
                            button.backgroundColor = normalKeyColour
                        }
                        else {
                            button.backgroundColor = specialKeyColour
                        }
                        button.setTitleColor(.black, for: .normal)
                    }
                }
            }
        }
    }
    let normalKeyColour = UIColor(white: 1.0, alpha: 1.0)
    let specialKeyColour = UIColor(white: 0.9, alpha: 1.0)
    let normalDarkKeyColour = UIColor(white: 0.4, alpha: 1.0)
    let specialDarkKeyColour = UIColor(white: 0.3, alpha: 1.0)
    var showLetters: Bool = true {
        didSet {
            if showLetters {
                showChars = false
                showBengaliNums = false
                for view in mainStackView.arrangedSubviews {
                    view.removeFromSuperview()
                }
                addLetters()
                
            }
            else {
                isCaps = false
                addNumbers()
            }
        }
    }

    

    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Perform custom UI setup here

//        self.nextKeyboardButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
//        self.nextKeyboardButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
//        self.view.addSubview(self.nextKeyboardButton)
        addLetters()

    }

    
    func addLetters() {
        allButtons.removeAll()
        allTextButtons.removeAll()
        
        let topButtonTitles = ["ꠂ", "ꠧ", "ꠦ", "ꠣ", "ꠛ", "ꠉ", "ꠖ", "ꠎ", "ꠒ"]
        let middleButtonTitles = ["ꠤ", "ꠥ", "\u{A806}", "ꠞ", "ꠙ", "ꠇ", "ꠔ", "ꠌ", "ꠐ"]
        let bottomButtonTitles = ["ꠋ", "ꠝ", "ꠘ", "ꠟ", "ꠡ", "ꠢ"]
        
        let shiftButton = createButton(title: "⇧", colour: 0.9, type: .custom, keyDown: false, isText: false)
        shiftButton.addTarget(self, action:#selector(toggleCaps(sender:)), for: .touchUpInside)
        allTextButtons.append(shiftButton)

        let deleteButton = createDeleteButton()
        
        self.nextKeyboardButton = createNextKBButton()
        
        let spaceButton = createSpaceButton()
        
        let returnButton = createReturnButton()
        
        let numButton = createButton(title: "123", colour: 0.9, type: .custom, bigTitle: false, isText: false)
        numButton.addTarget(self, action:#selector(toggleNum), for: .touchUpInside)
        
        let topRow = addKeys(titles: topButtonTitles, isText: true)
        let middleRow = addKeys(titles: middleButtonTitles, isText: true)
        let bottomKeys = addKeys(titles: bottomButtonTitles, isText: true)
        let bottomRow = UIStackView(arrangedSubviews: [shiftButton, bottomKeys, deleteButton])
        bottomRow.distribution = .fillProportionally
        bottomRow.spacing = 5
        let functionRow = UIStackView(arrangedSubviews: [numButton, self.nextKeyboardButton, spaceButton, returnButton])
        functionRow.distribution = .fillProportionally
        functionRow.spacing = 5
        spaceButton.widthAnchor.constraint(equalTo: spaceButton.superview!.widthAnchor, multiplier: 0.5).isActive = true
        returnButton.widthAnchor.constraint(equalTo: returnButton.superview!.widthAnchor, multiplier: 0.25).isActive = true
        self.nextKeyboardButton.widthAnchor.constraint(equalTo: returnButton.superview!.widthAnchor, multiplier: 0.10).isActive = true
        
        handleMainStackView(stacks: [topRow, middleRow, bottomRow, functionRow])
    }
    
    func createButton(title: String?, colour: CGFloat = 1.0, type: UIButton.ButtonType = .system, bigTitle: Bool = true, keyDown: Bool = true, isText: Bool = true, isReturn: Bool = false) -> UIButton {
        let button = UIButton(type: type)
        button.setTitle(title, for: .normal)
        if bigTitle {
            button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        }
        button.translatesAutoresizingMaskIntoConstraints = false;
//        button.sizeToFit()
        if textDocumentProxy.keyboardAppearance != .dark {
            button.backgroundColor = UIColor(white: colour, alpha: 1.0)
            button.setTitleColor(.black, for: .normal)
        } else {
            button.backgroundColor = UIColor(white: colour - 0.6, alpha: 1.0)
            button.setTitleColor(.white, for: .normal)
        }
        button.layer.cornerRadius = 5;
        button.layer.shadowRadius = 1;
        button.layer.shadowColor = UIColor(white: 0.4, alpha: 1.0).cgColor;
        button.layer.shadowOpacity = 1;
        button.layer.shadowRadius = 0;
        button.layer.shadowOffset = CGSize(width: 0, height: 1)
//        button.frame.size = CGSize(width: 30, height: 40)
        if keyDown {
            button.addTarget(self, action:#selector(highlightButton(sender:)), for: .touchDown)
        }
        
        if !isReturn {
            allButtons.append(button);
            if isText {
                allTextButtons.append(button);
                button.tag = 1
            }
            else {
                button.tag = 0
            }
        }

        return button;
    }
    
    @objc func highlightButton(sender: UIButton) {
        if textDocumentProxy.keyboardAppearance != .dark {
            sender.backgroundColor = .darkGray
            sender.setTitleColor(.white, for: .normal)
        }
        else {
            sender.backgroundColor = UIColor(white: 0.8, alpha: 1.0)
            sender.setTitleColor(.black, for: .normal)
        }
    }
    
    @objc func unhighlightButton(sender: UIButton, colour: CGFloat = 1.0){
        if textDocumentProxy.keyboardAppearance != .dark {
            sender.backgroundColor = UIColor(white: colour, alpha: 1.0)
            sender.setTitleColor(.black, for: .normal)
        }
        else {
            sender.backgroundColor = UIColor(white: colour - 0.6, alpha: 1.0)
            sender.setTitleColor(.white, for: .normal)
        }
    }
    
    
    func addNumbers() {
        
        allButtons.removeAll()
        allTextButtons.removeAll()
        
        for view in mainStackView.arrangedSubviews {
            view.removeFromSuperview()
        }
        
        let topButtonTitles = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]
        let middleButtonTitles = ["-", "/", ":", ";", "(", ")", "£", "&", "@", "\""]
        let bottomButtonTitles = ["।", ".", ",", "?", "!", "'"]
        
        let otherCharsButton = createButton(title: "#+=", colour: 0.9, type: .custom, bigTitle: false, isText: false)
        otherCharsButton.addTarget(self, action:#selector(toggleOtherChars(sender:)), for: .touchUpInside)
        
        let bengaliNumsButton = createButton(title: "১২৩", colour: 0.9, type: .custom, bigTitle: false, isText: false)
        bengaliNumsButton.addTarget(self, action:#selector(toggleBengaliNums(sender:)), for: .touchUpInside)
        

        let deleteButton = createDeleteButton()
        
        self.nextKeyboardButton = createNextKBButton()
        
        let spaceButton = createSpaceButton()
        
        let returnButton = createReturnButton()
        
        let abcButton = createButton(title: "ꠇ", colour: 0.9, type: .custom, bigTitle: false, isText: false)
        abcButton.addTarget(self, action:#selector(toggleNum), for: .touchUpInside)
        
        let topRow = addKeys(titles: topButtonTitles, isText: false)
        let middleRow = addKeys(titles: middleButtonTitles, isText: false)
        let bottomKeys = addKeys(titles: bottomButtonTitles, isText: false)
        let bottomRow = UIStackView(arrangedSubviews: [otherCharsButton, bengaliNumsButton, bottomKeys, deleteButton])
        bottomRow.distribution = .fillProportionally
        bottomRow.spacing = 5
        let functionRow = UIStackView(arrangedSubviews: [abcButton, self.nextKeyboardButton, spaceButton, returnButton])
        functionRow.distribution = .fillProportionally
        functionRow.spacing = 5
        spaceButton.widthAnchor.constraint(equalTo: spaceButton.superview!.widthAnchor, multiplier: 0.5).isActive = true
        returnButton.widthAnchor.constraint(equalTo: returnButton.superview!.widthAnchor, multiplier: 0.25).isActive = true
        self.nextKeyboardButton.widthAnchor.constraint(equalTo: returnButton.superview!.widthAnchor, multiplier: 0.10).isActive = true
        
        handleMainStackView(stacks: [topRow, middleRow, bottomRow, functionRow])
    }
    
    func addKeys(titles: [String], isText: Bool) -> UIStackView {
        
        let rowStackView = UIStackView.init()
        rowStackView.spacing = 5
        rowStackView.axis = .horizontal
        rowStackView.alignment = .fill
        rowStackView.distribution = .fillEqually
        
        for title in titles {
            let button = createButton(title: title, isText: isText)
            button.addTarget(self, action:#selector(keyPressed(_:)), for: .touchUpInside)
            rowStackView.addArrangedSubview(button)
        }
        
        let viewDict = ["rowStackView": rowStackView]
        
        let keysView = UIStackView()
        keysView.backgroundColor = .clear
        keysView.addArrangedSubview(rowStackView)
        keysView.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|[rowStackView]|", metrics: nil, views: viewDict))
        keysView.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|[rowStackView]|", metrics: nil, views: viewDict))
        return rowStackView
    }
    
    func createDeleteButton() -> UIButton {
        let deleteButton = createButton(title: "⌫", colour: 0.9, type: .custom, isText: false)
        deleteButton.addTarget(self, action:#selector(handleDelete(sender:)), for: .touchUpInside)
        let longPresser = UILongPressGestureRecognizer.init(target: self, action: #selector(handleBackspaceLongPress(longPress:)))
        longPresser.minimumPressDuration = 0.5
        longPresser.numberOfTouchesRequired = 1
        deleteButton.addGestureRecognizer(longPresser)
        return deleteButton
    }
    
    @objc func handleBackspaceLongPress(longPress: UILongPressGestureRecognizer) {
        switch longPress.state {
          case .began:
            self.textDocumentProxy.deleteBackward()
          case .ended:
            let button = longPress.view! as! UIButton
            unhighlightButton(sender: button, colour: 0.9)
            return;
          default:
            self.textDocumentProxy.deleteBackward()
        }
        
    }
    
    func createNextKBButton() -> UIButton {
        let nextKBButton = createButton(title: "🌐", colour: 0.9, keyDown: false, isText: false)
        nextKBButton.setTitle(NSLocalizedString("🌐", comment: "Title for 'Next Keyboard' button"), for: [])
        nextKBButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
        return nextKBButton
    }
    
    func createSpaceButton() -> UIButton {
        let spaceButton = createButton(title: "space", bigTitle: false)
        spaceButton.addTarget(self, action:#selector(handleSpace(sender:)), for: .touchUpInside)
        return spaceButton
    }
    
    func createReturnButton() -> UIButton {
        let returnButton = createButton(title: "return", bigTitle: false, keyDown: false, isText: false, isReturn: true)
        returnButton.addTarget(self, action:#selector(handleReturn), for: .touchUpInside)
        returnButton.backgroundColor = .systemBlue
        returnButton.setTitleColor(.white, for: .normal)
        return returnButton
    }
    
    
    @objc func handleMainStackView(stacks: [UIStackView]) {
        mainStackView = UIStackView(arrangedSubviews: stacks)
        mainStackView.axis = .vertical
        mainStackView.spacing = 10
        mainStackView.distribution = .fillEqually
        mainStackView.alignment = .fill
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mainStackView)
        
        mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 2).isActive = true
        mainStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -2).isActive = true
        mainStackView.heightAnchor.constraint(equalTo: view.heightAnchor, constant: -10).isActive = true
        
    }

    
    @objc func keyPressed(_ sender: UIButton?) {
        let button = sender! as UIButton
        let title = button.title(for: .normal)
        if isCaps {
            toggleCaps(sender: allButtons.first(where: {$0.title(for: .normal) == "⇧"}))
        }
        unhighlightButton(sender: sender!)
        (textDocumentProxy as UIKeyInput).insertText(title!)
    }
    
    @objc func handleDelete(sender: UIButton) {
        unhighlightButton(sender: sender, colour: 0.9)
        (textDocumentProxy as UIKeyInput).deleteBackward()
    }
    
    
    @objc func handleSpace(sender: UIButton) {
        unhighlightButton(sender: sender)
        if isCaps {
            toggleCaps(sender: allButtons.first(where: {$0.title(for: .normal) == "⇧"}))
        }
        (textDocumentProxy as UIKeyInput).insertText(" ")
    }
    
    @objc func handleReturn() {
        if isCaps {
            toggleCaps(sender: allButtons.first(where: {$0.title(for: .normal) == "⇧"}))
        }
        (textDocumentProxy as UIKeyInput).insertText("\n")
    }
    
    @objc func toggleCaps(sender: UIButton?) {
        let shift = sender! as UIButton
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
            "ꠄ": "ꠦ",
            "ꠂ": "ꠅꠂ",
            "ꠅꠂ": "ꠂ",
            "ꠞ": "ꠠ",
            "ꠠ": "ꠞ"
        ]
        
        isCaps = !isCaps
        if isCaps {
            if textDocumentProxy.keyboardAppearance == .dark {
                shift.backgroundColor = UIColor(white: 0.8, alpha: 1.0)
                shift.setTitleColor(.black, for: .normal)
            }
            else {
                shift.backgroundColor = .black
                shift.setTitleColor(.white, for: .normal)
            }
        }
        else {
            if textDocumentProxy.keyboardAppearance == .dark {
                shift.backgroundColor = specialDarkKeyColour
                shift.setTitleColor(.white, for: .normal)
            }
            else {
                unhighlightButton(sender: shift, colour: 0.9)
            }
        }
        
        for button in allButtons {
            let title = button.title(for: .normal)!
            if capsDict[title] != nil {
                setTitleNoAnim(button: button, title: capsDict[title]!)
            }
        }
        
    }

    @objc func toggleNum(sender: UIButton) {
        unhighlightButton(sender: sender, colour: 0.9)
        showLetters = !showLetters
    }
    
    @objc func toggleOtherChars(sender: UIButton?) {
        let otherChars = sender! as UIButton
        unhighlightButton(sender: otherChars, colour: 0.9)
        let charsDict: [String: String] = [
            "1": "[",
            "[": "1",
            "2": "]",
            "]": "2",
            "{": "3",
            "3": "{",
            "}": "4",
            "4": "}",
            "#": "5",
            "5": "#",
            "6": "%",
            "%": "6",
            "7": "^",
            "^": "7",
            "8": "*",
            "*": "8",
            "9": "+",
            "+": "9",
            "=": "0",
            "0": "=",
            "-": "_",
            "_": "-",
            "/": "\\",
            "\\": "/",
            ":": "|",
            "|": ":",
            ";": "~",
            "~": ";",
            "(": "<",
            "<": "(",
            ")": ">",
            ">": ")",
            "£": "$",
            "$": "£",
            "@": "৳",
            "৳": "@",
            "¥": "‌‍₹",
            "‌‍₹": "¥",
            "\"": "•",
            "•": "\""
        ]
        if !showBengaliNums {
            if let benNums = allButtons.first(where: {$0.title(for: .normal) == "১২৩"}) {
                toggleDisabled(button: benNums)
            }
            showChars = !showChars
            if showChars {
                setTitleNoAnim(button: otherChars, title: "123")
            }
            else {
                setTitleNoAnim(button: otherChars, title: "#+=")
            }
            for button in allButtons {
                let title = button.title(for: .normal)!
                if charsDict[title] != nil {
                    setTitleNoAnim(button: button, title: charsDict[title]!)
                }
            }
        }
    }
    
    @objc func toggleBengaliNums(sender: UIButton?) {
        let benNums = sender!
        unhighlightButton(sender: benNums, colour: 0.9)
        let benDict: [String: String] = [
            "1": "১",
            "১": "1",
            "2": "২",
            "২": "2",
            "৩": "3",
            "3": "৩",
            "৪": "4",
            "4": "৪",
            "৫": "5",
            "5": "৫",
            "6": "৬",
            "৬": "6",
            "7": "৭",
            "৭": "7",
            "8": "৮",
            "৮": "8",
            "9": "৯",
            "৯": "9",
            "০": "0",
            "0": "০",
            ".": "꠨",
            "꠨": ".",
            ",": "꠩",
            "꠩": ",",
            "?": "꠪",
            "꠪": "?",
            "!": "꠫",
            "꠫": "!",
            "'": "⁕",
            "⁕": "'"
        ]
        if !showLetters && !showChars {
            showBengaliNums = !showBengaliNums
            if let otherChars = allButtons.first(where: {$0.title(for: .normal) == "#+="}) {
                toggleDisabled(button: otherChars)
            }
            if showBengaliNums {
                setTitleNoAnim(button: benNums, title: "123")
            }
            else {
                setTitleNoAnim(button: benNums, title: "১২৩")
            }
            for button in allButtons {
                let title = button.title(for: .normal)!
                if benDict[title] != nil {
                    setTitleNoAnim(button: button, title: benDict[title]!)

                }
            }
        }
    }
    
    @objc func toggleDisabled(button: UIButton) {
        button.isEnabled = !button.isEnabled;
        if button.isEnabled {
            if kbAppearance == .dark {
                button.backgroundColor = UIColor(white: 0.3, alpha: 1.0)
            }
            
            else {
                button.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
            }
        }
        else {
            if kbAppearance == .dark {
                button.backgroundColor = UIColor(white: 0.15, alpha: 1.0)
            }
            else {
                button.backgroundColor = UIColor(white: 0.75, alpha: 1.0)
            }
        }
    }
    
    
    @objc private func setTitleNoAnim(button: UIButton, title: String){
        UIView.performWithoutAnimation {
            button.setTitle(title, for: .normal)
            button.layoutIfNeeded()
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
        kbAppearance = proxy.keyboardAppearance!;
        if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
            textColor = UIColor.white
        } else {
            textColor = UIColor.black
        }
        self.nextKeyboardButton.setTitleColor(textColor, for: [])
    }

}
