//
//  DeviceCell.swift
//  BluetoothDemo
//
//  Created by roni on 2020/2/25.
//  Copyright © 2020 roni. All rights reserved.
//

import UIKit


struct DeviceModel {
    var name: String
    var data: [String: Any]
    var rssi: NSNumber

    init(name: String, data: [String: Any], rssi: NSNumber) {
        self.name = name
        self.data = data
        self.rssi = rssi
    }
}

class DeviceCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var rssiLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func render(_ model: DeviceModel) {
        self.nameLabel.text = model.name
        self.rssiLabel.text = String(format: "%@", model.rssi)
        self.dataLabel.text = String(format: "%@", model.data)
    }
}
