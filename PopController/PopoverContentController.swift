//
//  PopoverContentController.swift
//  PopController
//
//  Created by Nikolay Pochekuev on 15.04.2024.
//

import UIKit

class PopoverContentController: UIViewController {

    var segmentHandler: ((Int) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        segmentedButton.selectedSegmentIndex = 0
        segmentHandler?(0)
    }
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            segmentHandler?(0)
        }
        if sender.selectedSegmentIndex == 1 {
            segmentHandler?(1)
        }
    }
    
    @objc func closeButtonDidTap() {
        self.dismiss(animated: true)
    }
    
    private var containerView = UIView()
    private var segmentedButton: UISegmentedControl = {
        let segmentedControl = UISegmentedControl()
        segmentedControl.insertSegment(withTitle: "280pt", at: 0, animated: true)
        segmentedControl.insertSegment(withTitle: "150pt", at: 1, animated: true)
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
        return segmentedControl
    }()
    private var closeButton: UIButton = {
        let button = UIButton(type: .close)
        button.addTarget(self, action: #selector(closeButtonDidTap), for: .touchUpInside)
        return button
    }()
}

private extension PopoverContentController {
    func setup() {
        self.view.addSubview(containerView)
        containerView.addSubview(segmentedButton)
        containerView.addSubview(closeButton)
        segmentedButton.selectedSegmentIndex = 0
        makeConstraints()
    }
    
    func makeConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            containerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant:  0),
            containerView.bottomAnchor.constraint(equalToSystemSpacingBelow: view.bottomAnchor, multiplier: 0)
        ])
        
        segmentedButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            segmentedButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            segmentedButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            segmentedButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            closeButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            closeButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            closeButton.heightAnchor.constraint(equalToConstant: 32),
            closeButton.widthAnchor.constraint(equalToConstant: 32)
        ])
    }
}
