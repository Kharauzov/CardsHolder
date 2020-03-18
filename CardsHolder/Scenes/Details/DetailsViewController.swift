//
//  DetailsViewController.swift
//  CardsHolder
//
//  Created by Serhii Kharauzov on 11.03.2020.
//  Copyright © 2020 Serhii Kharauzov. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    lazy var customView = view as! DetailsView
    let viewModel: ActivityViewModel
    
    override func loadView() {
        view = DetailsView(frame: UIScreen.main.bounds)
    }
    
    init(viewModel: ActivityViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customView.titleLabel.attributedText = viewModel.title.formattedString(font: UIFont.customFont(ofSize: 20, weight: .bold), textColor: .black, lineHeight: 28, letterSpace: 0.2, alignment: .center)
        customView.authorLabel.text = viewModel.authorName
        if let image = viewModel.coverImage {
            setupImageContainerView(image: image)
        }
        customView.textView.attributedText = getMockTextViewText().formattedString(font: UIFont.systemFont(ofSize: 16, weight: .regular), textColor: .black, lineHeight: 24, letterSpace: 0.5, alignment: .left)
        customView.dismissButton.addTarget(self, action: #selector(dismissButtonTapped), for: .touchUpInside)
    }
    
    private func setupImageContainerView(image: UIImage) {
        let averageColor = image.averageColor()
        customView.imageView.image = image
        customView.imageContainerView.firstColor = averageColor
        customView.imageContainerView.secondColor = averageColor.withAlphaComponent(0)
        customView.imageContainerView.horizontalMode = false
    }
    
    @objc private func dismissButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    private func getMockTextViewText() -> String {
        return """
        A plot is one of the most important parts of a story, and has many different purposes. Firstly, the plot focuses attention on the important characters and their roles in the story. It motivates the characters to affect the story, and connects the events in an orderly manner. The plot creates a desire for the reader to go on reading by absorbing them in the middle of the story, ensuring they want to know what happens next.
        The plot leads to the climax, but by gradually releasing the story in order to maintain readers’ interest. During the plot of a book, a reader gets emotionally involved, connecting with the book, not allowing himself to put the book down. Eventually, the plot reveals the entire story, giving the reader a sense of completion that he has finished the story and reached a conclusion.
        The plot is what forms a memory in readers’ minds, allowing them to think about the book and even making them want to read it again. By identifying and understanding the plot, the reader is able to understand the message being conveyed by the author, and the explicit or implicit moral of the story.
        """
    }
}
