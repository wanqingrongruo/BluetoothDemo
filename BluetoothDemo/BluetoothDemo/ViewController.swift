//
//  ViewController.swift
//  BluetoothDemo
//
//  Created by roni on 2020/1/17.
//  Copyright © 2020 roni. All rights reserved.
//

import UIKit
import CoreBluetooth

let BLE_USER_DATA_SERVICE_ASSIGNED_NUMBER = CBUUID(string: "0x181C")

class ViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var deviceLabel: UILabel!
    @IBOutlet weak var sLabel: UILabel!

    var centralManager: CBCentralManager?
    var peripheralEarpod: CBPeripheral?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        activityIndicator.backgroundColor = .black
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        statusView.backgroundColor = .red

        let centralQueue = DispatchQueue(label: "com.demo.bluetooth", attributes: .concurrent)
        centralManager = CBCentralManager(delegate: self, queue: centralQueue)
    }


}

extension ViewController: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOn:
            DispatchQueue.main.async {
                self.activityIndicator.startAnimating()
            }

            centralManager?.scanForPeripherals(withServices: [BLE_USER_DATA_SERVICE_ASSIGNED_NUMBER])
        default:
            break
        }
    }
}
