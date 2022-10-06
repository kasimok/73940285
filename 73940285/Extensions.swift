//
// Created by 0x67 on 6/10/2022.
// Copyright © 2022 0x67. All rights reserved.
// 

import Foundation
import UIKit

extension NSAttributedString {
    
    func attributedStringWithResizedImages(with maxWidth: CGFloat) -> NSAttributedString {
        
        let text = NSMutableAttributedString(attributedString: self)
        text.enumerateAttribute(NSAttributedString.Key.attachment, in: NSMakeRange(0, text.length), options: .init(rawValue: 0), using: { (value, range, stop) in
            if let attachment = value as? NSTextAttachment {
                
                let image = attachment.image(forBounds: attachment.bounds, textContainer: NSTextContainer(), characterIndex: range.location)!
                
                if image.size.width > maxWidth {
                    
                    let newImage =  image.resizeImage(scale: maxWidth/image.size.width)
                    let newAttribut = NSTextAttachment()
                    newAttribut.image = newImage
                    text.addAttribute(NSAttributedString.Key.attachment, value: newAttribut, range: range)
                    
                }
                
            }
        })
        return text
    }
    
}


extension UIImage {
    func resizeImage(scale: CGFloat) -> UIImage {
        
        let newSize = CGSize(width: self.size.width*scale, height: self.size.height*scale)
        let rect = CGRect(origin: CGPoint.zero, size: newSize)
        
        UIGraphicsBeginImageContext(newSize)
        self.draw(in: rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}
