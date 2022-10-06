//
//  ViewController.swift
//  73940285
//
//  Created by evilisn_jiang on 14/07/1401 AP.
//

import UIKit

let myNotes = "myNotes"

class ViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    
    let userDefault = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let attributedText = self.getAttributedTextFromUserDefault(key: myNotes)
        textView.attributedText = attributedText.attributedStringWithResizedImages(with: 100)
    }
    
    func saveAttributedTextToUserDefault(attributedText: NSAttributedString, key: String) {
        
        do {
            let data = try attributedText.data(from: NSRange(location: 0, length: attributedText.length), documentAttributes: [.documentType: NSAttributedString.DocumentType.rtfd])
            
            userDefault.set(data, forKey: myNotes)
        } catch {
            print(error)
        }
    }
    
    func getAttributedTextFromUserDefault(key: String) -> NSAttributedString {
        
        if let dataValue = userDefault.data(forKey: myNotes) {
            do {
                let attributeText = try NSAttributedString(data: dataValue, documentAttributes: nil)
                return attributeText
            } catch {
                print("error: ", error)
            }
            
        }else{
            //if defaults not set
            let string = spawnAttributeString()
            //set default
            saveAttributedTextToUserDefault(attributedText: string, key: myNotes)
            return string
        }
        
        return NSAttributedString()
    }
    
    
    private func spawnAttributeString() -> NSAttributedString{
        // create an NSMutableAttributedString that we'll append everything to
        let fullString = NSMutableAttributedString(string: "Start of text")
        

        // create our NSTextAttachment
        let image1Attachment = NSTextAttachment()
        image1Attachment.image = UIImage(named: "ricardo")

        // wrap the attachment in its own attributed string so we can append it
        let image1String = NSAttributedString(attachment: image1Attachment)

        // add the NSTextAttachment wrapper to our full string, then add some more text.
        fullString.append(image1String)
        fullString.append(NSAttributedString(string: "End of text"))

        return fullString
    }
}

