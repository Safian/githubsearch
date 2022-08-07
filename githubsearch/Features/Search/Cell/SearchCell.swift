//
//  SearchCell.swift
//  githubsearch
//
//  Created by Szabolcs Sáfián on 2022. 08. 06..
//

import UIKit
import Combine

class SearchCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: DowloadableImageView!
    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var repositoryNameLabel: UILabel!
    @IBOutlet weak var descriptionsLabel: UILabel!
    @IBOutlet weak var numberOfStarsLabel: UILabel!
    @IBOutlet weak var programmingLanguageLabel: UILabel!

    func setup(with data: SearchCellData) {
        ownerNameLabel.text = data.ownerName
        repositoryNameLabel.text = data.repositoryName
        descriptionsLabel.text = data.descritions
        numberOfStarsLabel.text = "⭐️ \(data.numberOfStars)"
        programmingLanguageLabel.text = data.programingLanguage
        avatarImageView.imageFromURL(urlString: data.avatarImageUrlString)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            setSelected(false, animated: true)
        }
    }
}


import Combine

class DowloadableImageView: UIImageView {

    var disposableImage: AnyCancellable? = nil

    func imageFromURL(urlString: String?, placeHolderImage:UIImage? = nil) {

        disposableImage?.cancel()
        guard let urlString = urlString, let url = URL(string: urlString) else {
            return
        }
        disposableImage = URLSession.shared
            .dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .assign(to: \.self.image , on: self)
    }
}
