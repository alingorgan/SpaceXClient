//
//  LaunchInfoCell.swift
//  SpaceXClient
//
//  Created by Alin Gorgan on 5/27/21.
//

import UIKit

protocol IdentifiableCell: UITableViewCell {
    
    static var CellIdentifier: String { get }
    
    func update(displayable: Any)
}

final class LaunchInfoCell: UITableViewCell, IdentifiableCell {

    static var CellIdentifier = "LaunchInfoCell"
    
    @IBOutlet weak var missionImageView: UIImageView!
    @IBOutlet weak var missionNameLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var rocketTypeLabel: UILabel!
    @IBOutlet weak var daysToDepartureLabel: UILabel!
    @IBOutlet weak var launchStateIcon: UIImageView!
    
    var imageLoadingSessionId: UUID?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageLoadingSessionId = nil
        missionImageView.image = nil
    }
    
    func update(displayable: Any) {
        guard let launchInfo = displayable as? LaunchInfo else { return }
        
        missionNameLabel.text = launchInfo.mission.name
        dateTimeLabel.text = launchInfo.mission.dateFormatted
        rocketTypeLabel.text = launchInfo.rocketInfo?.type ?? "unknown"
        daysToDepartureLabel.text = launchInfo.mission.etdFormatted
        
        if let missionImageUrl = launchInfo.mission.imageUrl {
            imageLoadingSessionId = UIImage.loadImage(from: missionImageUrl) {
                [weak self] image, sessionId in
                
                guard let self = self, self.imageLoadingSessionId == sessionId else { return }
                self.missionImageView.image = image
            }
        }
        
        guard let isSuccessfullLaunch = launchInfo.mission.isSuccessfullLaunch else {
            launchStateIcon.isHidden = true
            return
        }
        
        launchStateIcon.isHidden = false
        launchStateIcon.image = isSuccessfullLaunch ? #imageLiteral(resourceName: "check_icon") : #imageLiteral(resourceName: "cross_icon")
    }
}
