//
//  ViewController.swift
//  WordPadDemoAshutos
//
//  Created by Ashutos on 01/09/19.
//  Copyright © 2019 Ashutos. All rights reserved.
//

import UIKit
import RichEditorView

class ViewController: UIViewController {
    @IBOutlet weak var htmlTextView: UITextView!{
        didSet{
            htmlTextView.layer.cornerRadius = 5.0
            htmlTextView.layer.borderColor = UIColor.lightGray.cgColor
            htmlTextView.layer.borderWidth = 1.0
        }
    }
    
    @IBOutlet weak var RichEditorView: RichEditorView!{
        didSet{
            RichEditorView.layer.cornerRadius = 5.0
            RichEditorView.layer.borderColor = UIColor.lightGray.cgColor
            RichEditorView.layer.borderWidth = 1.0
        }
    }
    
    lazy var toolbar: RichEditorToolbar = {
        let toolbar = RichEditorToolbar(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 44))
        toolbar.options = RichEditorDefaultOption.all
        return toolbar
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        RichEditorView.delegate = self
        RichEditorView.inputAccessoryView = toolbar
        RichEditorView.placeholder = "Type some text..."
        
        toolbar.delegate = self
        toolbar.editor = RichEditorView
        
        let item = RichEditorOptionItem(image: nil, title: "Clear") { toolbar in
            toolbar.editor?.html = ""
        }
        
        var options = toolbar.options
        options.append(item)
        toolbar.options = options
        // Do any additional setup after loading the view.
    }


}


extension ViewController : RichEditorDelegate,RichEditorToolbarDelegate {
    func richEditor(_ editor: RichEditorView, contentDidChange content: String) {
        if content.isEmpty {
            htmlTextView.text = "HTML Preview"
        } else {
            htmlTextView.text = content
        }
    }
    
    fileprivate func randomColor() -> UIColor {
        let colors: [UIColor] = [
            .red,
            .orange,
            .yellow,
            .green,
            .blue,
            .purple
        ]
        
        let color = colors[Int(arc4random_uniform(UInt32(colors.count)))]
        return color
    }
    
    func richEditorToolbarChangeTextColor(_ toolbar: RichEditorToolbar) {
        let color = randomColor()
        toolbar.editor?.setTextColor(color)
    }
    
    func richEditorToolbarChangeBackgroundColor(_ toolbar: RichEditorToolbar) {
        let color = randomColor()
        toolbar.editor?.setTextBackgroundColor(color)
    }
    
    func richEditorToolbarInsertImage(_ toolbar: RichEditorToolbar) {
        toolbar.editor?.insertImage("https://gravatar.com/avatar/696cf5da599733261059de06c4d1fe22", alt: "Gravatar")
    }
    
    func richEditorToolbarInsertLink(_ toolbar: RichEditorToolbar) {
        // Can only add links to selected text, so make sure there is a range selection first
        if toolbar.editor?.hasRangeSelection == true {
            toolbar.editor?.insertLink("http://github.com/cjwirth/RichEditorView", title: "Github Link")
        }
    }
}

