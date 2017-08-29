//
//  ChatsCell.swift
//  TestfulApp
//
//  Created by Nick Melnick on 8/28/17.
//  Copyright © 2017 Nick Melnick. All rights reserved.
//

import UIKit
import SDWebImage

class ChatsCell: UITableViewCell, ChatsRepresentation {
    
    var viewModel: ContactViewModel?
    
    @IBOutlet private var avatarImageView: UIImageView!
    @IBOutlet private var fullnameLabel: UILabel!
    @IBOutlet private var messageLabel: UILabel!
    @IBOutlet private var unreadCountLabel: UILabel!
    @IBOutlet private var dateTimeLabel: UILabel!
    
    func setup(withViewModel vm: ContactViewModel?) {
        viewModel = vm
        fullnameLabel.text = viewModel?.fullname
        messageLabel.text = viewModel?.lastMessage
        unreadCountLabel.text = viewModel?.unreadCountText
        dateTimeLabel.text = viewModel?.lastMessageTime
        if let data = viewModel?.avatar {
            let image = UIImage(data: data)
            avatarImageView.image = image
        } else {
            let placeholderImage = UIImage.fromColor(UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 1))
            let url = viewModel?.avatarURL
            avatarImageView.sd_setImage(with: url, placeholderImage: placeholderImage, options: .lowPriority, completed: { [weak self] (image, error, _, _) in
                guard let image = image else { return }
                self?.viewModel?.saveAvatar(image)
                self?.avatarImageView.layer.cornerRadius = self?.avatarImageView.frame.height ?? 0 / 2.0
            })
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImageView.sd_cancelCurrentImageLoad()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
