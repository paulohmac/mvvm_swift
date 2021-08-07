//
//  CustomMsgBox.swift
//  Dialog box customizado para a aplicação
//
//  Created by Paulo H. Mahtura on 16/02/20.
//

import UIKit

class CustomMsgBox: NSObject {

    /// Exibe um dialogo customizado para a aplicacao
    ///
    /// - parameter msg: Mensagem a ser exibida
    /// - parameter parent: UiviewController no qual a janela será exibida
    class func showMessage(msg : String , parent: UIViewController){
        
        DispatchQueue.main.async {
            
            let toastContainer = UIView(frame: CGRect())
            toastContainer.backgroundColor = UIColor(hexString: "#0194fd")
            toastContainer.alpha = 0.0
            toastContainer.layer.cornerRadius = 25;
            toastContainer.clipsToBounds  =  true
            
            let toastLabel = UILabel(frame: CGRect())
            toastLabel.textColor = UIColor.white
            toastLabel.textAlignment = .center;
            toastLabel.font.withSize(12.0)
            toastLabel.text = msg
            toastLabel.clipsToBounds  =  true
            toastLabel.numberOfLines = 0
            
            toastContainer.addSubview(toastLabel)
            parent.view.addSubview(toastContainer)
            
            toastLabel.translatesAutoresizingMaskIntoConstraints = false
            toastContainer.translatesAutoresizingMaskIntoConstraints = false
            
            let a1 = NSLayoutConstraint(item: toastLabel, attribute: .leading, relatedBy: .equal, toItem: toastContainer, attribute: .leading, multiplier: 1, constant: 15)
            let a2 = NSLayoutConstraint(item: toastLabel, attribute: .trailing, relatedBy: .equal, toItem: toastContainer, attribute: .trailing, multiplier: 1, constant: -15)
            let a3 = NSLayoutConstraint(item: toastLabel, attribute: .bottom, relatedBy: .equal, toItem: toastContainer, attribute: .bottom, multiplier: 1, constant: -15)
            let a4 = NSLayoutConstraint(item: toastLabel, attribute: .top, relatedBy: .equal, toItem: toastContainer, attribute: .top, multiplier: 1, constant: 15)
            toastContainer.addConstraints([a1, a2, a3, a4])
            
            toastContainer.centerXAnchor.constraint(equalTo: parent.view.centerXAnchor).isActive = true
            
            toastContainer.centerYAnchor.constraint(equalTo: parent.view.centerYAnchor).isActive = true

            UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
                toastContainer.alpha = 1.0
            }, completion: { _ in
                UIView.animate(withDuration: 0.5, delay: 2.5, options: .curveEaseOut, animations: {
                    toastContainer.alpha = 0.0
                }, completion: {_ in
                    toastContainer.removeFromSuperview()
                })
            })
        }
    }
    
    @IBDesignable class InsetLabel: UILabel {
        @IBInspectable var topInset: CGFloat = 0.0
        @IBInspectable var leftInset: CGFloat = 0.0
        @IBInspectable var bottomInset: CGFloat = 0.0
        @IBInspectable var rightInset: CGFloat = 0.0
        
        var insets: UIEdgeInsets {
            get {
                return UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
            }
            set {
                topInset = newValue.top
                leftInset = newValue.left
                bottomInset = newValue.bottom
                rightInset = newValue.right
            }
        }
        
        override func drawText(in rect: CGRect) {
            super.drawText(in: super.bounds.inset(by:insets))
        }
        
        override func sizeThatFits(_ size: CGSize) -> CGSize {
            var adjSize = super.sizeThatFits(size)
            adjSize.width += leftInset + rightInset
            adjSize.height += topInset + bottomInset
            
            return adjSize
        }
        
        override var intrinsicContentSize: CGSize {
            var contentSize = super.intrinsicContentSize
            contentSize.width += leftInset + rightInset
            contentSize.height += topInset + bottomInset
            
            return contentSize
        }
    }
    
}
