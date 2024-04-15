//
//  ViewController.swift
//  PopController
//
//  Created by Nikolay Pochekuev on 15.04.2024.
//

import UIKit

class ViewController: UIViewController {
    
    let popoverContentController = PopoverContentController()
    var popViewHeight: CGFloat = 280
    
    @IBAction func buttonClicked(_ sender: Any) {
        let button = sender as? UIButton
        let buttonFrame = button?.frame ?? CGRect.zero
        popoverContentController.modalPresentationStyle = .popover
        popoverContentController.preferredContentSize = CGSize(width: 300, height: popViewHeight)
        
        popoverContentController.segmentHandler = { [weak self] segment in
            guard let self = self else { return }
            if segment == 0 {
                self.popViewHeight = 280
                self.popoverContentController.preferredContentSize = CGSize(width: 300, height: self.popViewHeight)
            } else {
                self.popViewHeight = 150
                self.popoverContentController.preferredContentSize = CGSize(width: 300, height: self.popViewHeight)
            }
        }
        
        guard let popoverPresentationController = popoverContentController.popoverPresentationController else { return }
        popoverPresentationController.permittedArrowDirections = .up
        popoverPresentationController.sourceView = self.view
        popoverPresentationController.sourceRect = buttonFrame
        popoverPresentationController.delegate = self
        
        present(popoverContentController, animated: true, completion: nil)
    }
}

extension ViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }

    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {

    }

    func popoverPresentationControllerShouldDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) -> Bool {
        return true
    }

    func prepareForPopoverPresentation(_ popoverPresentationController: UIPopoverPresentationController) {
        guard let popoveContainerView = popoverPresentationController.containerView else { return }
        popoveContainerView.layer.shadowColor = UIColor.black.cgColor
        popoveContainerView.layer.shadowOpacity = 0.2
        popoveContainerView.layer.shadowOffset = CGSize(width: 0, height: 4)
        popoveContainerView.layer.shadowRadius = 4
    }
}
