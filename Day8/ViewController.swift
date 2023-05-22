//
//  ViewController.swift
//  Day8
//
//  Created by Ilya Krupko on 22.05.23.
//

import UIKit

class ViewController: UIViewController {
    
    let imageWidth = CGFloat(36)
    let largeTitlePanelHeight = 52
    
    let scrollView = UIScrollView()
    
    let iconView: UIImageView = {
        let view = UIImageView(image: UIImage(systemName: "person.crop.circle.fill"))
        view.tintColor = .systemGray2
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let iconContainer = UIView()
    
    var initialScrollContentOffsetTop: CGFloat?
    
    // MARK: -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Avatar"
        view.backgroundColor = .systemGroupedBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        scrollView.frame = view.frame
        scrollView.delegate = self
        scrollView.contentSize = .init(width: view.frame.width, height: 800)
        addSubviews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        iconContainer.frame = .init(x: 0, y: 0, width: Int(view.frame.width), height: largeTitlePanelHeight)
        iconContainer.center.y = view.safeAreaInsets.top - CGFloat(largeTitlePanelHeight/2)
        iconView.frame = .init(
            x: view.frame.width - CGFloat(imageWidth) - view.layoutMargins.right,
            y: iconContainer.frame.height/2 - imageWidth/2,
            width: imageWidth,
            height: imageWidth
        )
    }
    
    func addSubviews() {
        view.addSubview(scrollView)
        view.addSubview(iconContainer)
        iconContainer.addSubview(iconView)
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if initialScrollContentOffsetTop == nil {
            initialScrollContentOffsetTop = scrollView.adjustedContentInset.top
        }
        guard let initialScrollContentOffsetTop else { return }
        
        let offset =  -(initialScrollContentOffsetTop + scrollView.contentOffset.y)
        iconContainer.clipsToBounds = offset < 0
        let origin = iconContainer.frame.height / 2 - imageWidth / 2
        iconView.frame = .init(
            x: iconView.frame.minX,
            y: origin + offset,
            width: imageWidth,
            height: imageWidth
        )
    }
}

