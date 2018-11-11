//
//  EventTableViewCell.swift
//  Fun App
//
//  Created by Victor Zhang on 11/11/18.
//  Copyright © 2018 Victor Zhang. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {
    //MARK: Properties
    @IBOutlet weak var eventPosterImage: UIImageView!
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var eventPriceLabel: UILabel!
    @IBOutlet weak var eventVenueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    public func configerView(event: Event) {
        eventNameLabel.text = event.name
        eventPriceLabel.text = event.priceString
        eventVenueLabel.text = event.venue
    }
}
