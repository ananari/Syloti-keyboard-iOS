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
        let topButtonTitles = ["ꠂ", "ꠣ", "ꠛ", "ꠢ", "ꠉ", "ꠖ", "ꠎ", "ꠒ", "ꠐ", "ꠠ"]
        let middleButtonTitles = ["ꠧ", "ꠦ", "\u{A806}", "ꠤ", "ꠥ", "ꠙ", "ꠞ", "ꠇ", "ꠔ", "ꠌ", "ꠐ"]
        let bottomButtonTitles = ["ꠋ", "ꠝ", "ꠘ", "ꠟ", "ꠡ"]
        
        
        
        let topRow = UIView(frame: CGRect(x:0, y:10, width:UIScreen.main.bounds.size.width, height:40))
        let middleRow = UIView(frame: CGRect(x:0, y:60, width:UIScreen.main.bounds.size.width, height:40))
        let bottomRow = UIView(frame: CGRect(x:0, y:110, width:UIScreen.main.bounds.size.width, height:40))
        let lastRow = UIView(frame: CGRect(x: 0, y: 160, width:UIScreen.main.bounds.size.width, height: 40))

        func createButtons(titles: [String]) -> [UIButton] {
                
            var buttons = [UIButton]()
                
            for title in titles {
                let button = createButton(title: title)
                button.addTarget(self, action:#selector(KeyboardViewController.keyPressed(_:)), for: .touchUpInside)
                buttons.append(button)
                allButtons.append(button)
            }
                
            return buttons
        }
        
        func addConstraints(buttons: [UIButton], containingView: UIView){
            
            for (index, button) in buttons.enumerated() {
                
                let topConstraint = NSLayoutConstraint(item: button, attribute: .top, relatedBy: .equal, toItem: containingView, attribute: .top, multiplier: 1.0, constant: 1)
                
                let bottomConstraint = NSLayoutConstraint(item: button, attribute: .bottom, relatedBy: .equal, toItem: containingView, attribute: .bottom, multiplier: 1.0, constant: -1)
                
                var leftConstraint : NSLayoutConstraint!
                if index == 0 {
                    
                    leftConstraint = NSLayoutConstraint(item: button, attribute: .left, relatedBy: .equal, toItem: containingView, attribute: .left, multiplier: 1.0, constant: 1)

                } else {
                    
                    leftConstraint = NSLayoutConstraint(item: button, attribute: .left, relatedBy: .equal, toItem: buttons[index-1], attribute: .right, multiplier: 1.0, constant: 5)
                    
                    let widthConstraint = NSLayoutConstraint(item: buttons[0], attribute: .width, relatedBy: .equal, toItem: button, attribute: .width, multiplier: 1.0, constant: 0)
                    
                    containingView.addConstraint(widthConstraint)
                }
                
                var rightConstraint : NSLayoutConstraint!
                
                if index == buttons.count - 1 {
                    
                    rightConstraint = NSLayoutConstraint(item: button, attribute: .right, relatedBy: .equal, toItem: containingView, attribute: .right, multiplier: 1.0, constant: -1)
                    
                    
                } else{

                    rightConstraint = NSLayoutConstraint(item: button, attribute: .right, relatedBy: .equal, toItem: buttons[index + 1], attribute: .left, multiplier: 1.0, constant: -5)
                    
                }
                
                containingView.addConstraints([topConstraint, bottomConstraint, leftConstraint, rightConstraint])
            }
        }
        
        let shiftButton = createButton(title: "↑", colour: 0.9, type: .custom)
        shiftButton.addTarget(self, action:#selector(toggleCaps), for: .touchUpInside)
        shiftButton.frame.size = CGSize(width: 50, height: 40)

        
        let deleteButton = createButton(title: nil, colour: 0.9, type: .custom)
        let delImage = #imageLiteral(resourceName: "delete")
        deleteButton.setImage(delImage, for: .normal)
        deleteButton.addTarget(self, action:#selector(handleDelete(sender:)), for: .touchUpInside)
        
        let spaceButton = createButton(title: " ")
        spaceButton.addTarget(self, action:#selector(keyPressed(_:)), for: .touchUpInside)
        
        let returnButton = createButton(title: "return")
        returnButton.addTarget(self, action:#selector(handleReturn), for: .touchUpInside)
        
        let topButtons = createButtons(titles: topButtonTitles)
        let middleButtons = createButtons(titles: middleButtonTitles)
        var bottomButtons = createButtons(titles: bottomButtonTitles)
        bottomButtons.insert(self.nextKeyboardButton, at: 0)
        bottomButtons.insert(shiftButton, at: 0)
        bottomButtons.append(deleteButton)
        let lastButtons: [UIButton] = [spaceButton, returnButton]
        
        for button in topButtons {
            topRow.addSubview(button)
        }
        for button in middleButtons {
            middleRow.addSubview(button)
        }
        for button in bottomButtons {
            bottomRow.addSubview(button)
        }
        for button in lastButtons {
            lastRow.addSubview(button)
        }
        
        self.view.addSubview(topRow)
        self.view.addSubview(middleRow)
        self.view.addSubview(bottomRow)
        self.view.addSubview(lastRow)
                
        addConstraints(buttons: topButtons, containingView: topRow)
        addConstraints(buttons: middleButtons, containingView: middleRow)
        addConstraints(buttons: bottomButtons, containingView: bottomRow)
        addConstraints(buttons: lastButtons, containingView: lastRow)
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
