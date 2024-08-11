import UIKit

protocol PersonFollowingTableViewCellDelegate : AnyObject {
    func personFollowingTableViewCell(
        _ cell: PersonFollowingTableViewCell,
        didTapWith viewModel: PersonFollowingViewModel
    )
}

class PersonFollowingTableViewCell: UITableViewCell {
    static let identifier = "PersonFollowingTableViewCell"
    
    private var viewModel: PersonFollowingViewModel?
    
    weak var delegate: PersonFollowingTableViewCellDelegate?
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        return label
    }()
    
    private let birthDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let followButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.clipsToBounds = true
        
        contentView.addSubview(profileImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(birthDateLabel)
        contentView.addSubview(followButton)
        
        followButton.addTarget(self, action: #selector(didTapFollowButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    @objc private func didTapFollowButton() {
        guard let viewModel = viewModel else {
            return
        }
        
        delegate?.personFollowingTableViewCell(self, didTapWith: viewModel)
    }
    
    func configure(with viewModel: PersonFollowingViewModel) {
        self.viewModel = viewModel
        
        profileImageView.image = viewModel.profileImage
        
        nameLabel.text = viewModel.name
        birthDateLabel.text = viewModel.birthDate
        
        if viewModel.isFollowing {
            followButton.setTitle("Unfollow", for: .normal)
            followButton.setTitleColor(.black, for: .normal)
            followButton.layer.borderColor = UIColor.black.cgColor
        } else {
            followButton.setTitle("Follow", for: .normal)
            followButton.setTitleColor(.white, for: .normal)
            followButton.backgroundColor = .link
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        let cellWidth = contentView.frame.size.width
        let cellHeight = contentView.frame.size.height
        
        let imgSize = cellHeight - 10
        profileImageView.frame = CGRect(x: 5, y: 5, width: imgSize, height: imgSize)
        
        nameLabel.frame = CGRect(x: 5 + imgSize + 5, y: 5, width: cellWidth - (5 + imgSize + 10), height: cellHeight/2)
        birthDateLabel.frame = CGRect(x: 5 + imgSize + 5, y: cellHeight/2, width: cellWidth - (5 + imgSize + 10), height: cellHeight/2)
        
        followButton.frame = CGRect(x: cellWidth - 120, y: 10, width: 110, height: cellHeight - 20)
        followButton.layer.borderWidth = 1
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        print("TVC: prepareForReuse")
        profileImageView.image = nil
        nameLabel.text = nil
        birthDateLabel.text = nil
        followButton.setTitle(nil, for: .normal)
        followButton.setTitleColor(nil, for: .normal)
        followButton.backgroundColor = nil
    }
}
