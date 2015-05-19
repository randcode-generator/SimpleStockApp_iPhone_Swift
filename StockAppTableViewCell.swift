//
//  StockAppTableViewCell.swift
//  SimpleStockApp_iPhone-Swift
//
//  Created by Eric on 5/18/15.
//  Copyright (c) 2015 Eric. All rights reserved.
//

import UIKit

class StockAppTableViewCell: UITableViewCell {
    @IBOutlet var symbol: UILabel!
    @IBOutlet var price: UILabel!
    @IBOutlet var history: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    /*
    override func viewDidLoad() {
        //added to remove the separator inset
        self.view.layoutMargins = UIEdgeInsetsZero
    }
    */
}
