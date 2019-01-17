//
//  ProjectDetailView.swift
//  HackingWithSwift
//
//  Created by Amit Kumar Swami on 17/1/19.
//  Copyright © 2019 Hacking with Swift. All rights reserved.
//

import Foundation
import UIKit

class ProjectDetailView: UIView {
    
    private var readProject: (() -> ())?
    
    convenience init(project: Project, readProject: (() -> ())? = nil) {
        self.init(frame: CGRect.zero)
        
        self.readProject = readProject
        
        backgroundColor = .white
        
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(scrollView)
        
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 20),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40)
            ])
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = project.image
        
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        titleLabel.numberOfLines = 0
        titleLabel.text = project.title
        
        let detailLabel = UILabel()
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        detailLabel.numberOfLines = 0
        detailLabel.font = UIFont.preferredFont(forTextStyle: .body)
        detailLabel.text = project.subtitle
        
        let learnTitleLabel = UILabel()
        learnTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        learnTitleLabel.numberOfLines = 0
        learnTitleLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        learnTitleLabel.text = "You'll learn…"
        
        let learnDetailLabel = UILabel()
        learnDetailLabel.translatesAutoresizingMaskIntoConstraints = false
        learnDetailLabel.numberOfLines = 0
        learnDetailLabel.font = UIFont.preferredFont(forTextStyle: .body)
        learnDetailLabel.text = project.topics
        
        let showButton = UIButton(type: .system)
        showButton.translatesAutoresizingMaskIntoConstraints = false
        showButton.setTitle("Start Reading", for: .normal)
        showButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        showButton.addTarget(self, action: #selector(readProjectButtonTapped), for: .touchUpInside)
        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(detailLabel)
        stackView.addArrangedSubview(learnTitleLabel)
        stackView.addArrangedSubview(learnDetailLabel)
        stackView.addArrangedSubview(showButton)
        
        stackView.spacing = 10
        stackView.setCustomSpacing(40, after: detailLabel)
        stackView.setCustomSpacing(40, after: learnDetailLabel)
    }
 
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func readProjectButtonTapped() {
        self.readProject?()
    }
    
}
