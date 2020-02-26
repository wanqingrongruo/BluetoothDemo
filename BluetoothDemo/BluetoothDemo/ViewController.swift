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

    @IBOutlet weak var tableView: UITableView!

    var dataSource = [DeviceModel]()

    var centralManager: CBCentralManager?
    var peripheralEarpod: CBPeripheral?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "设备列表"
        setup()
        let centralQueue = DispatchQueue(label: "com.demo.bluetooth", attributes: .concurrent)
        centralManager = CBCentralManager(delegate: self, queue: centralQueue)
    }

    func setup() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
    }

    var index = 0
}

extension ViewController: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOn:
            centralManager?.scanForPeripherals(withServices: nil)
        default:
            centralManager?.stopScan()
            break
        }
    }

    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        let model = DeviceModel(name: peripheral.name ?? "\(index)", data: advertisementData, rssi: RSSI)
        dataSource.append(model)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        index += 1
        if index >= 10 {
            centralManager?.stopScan()
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DeviceCell", for: indexPath) as! DeviceCell
        let model = dataSource[indexPath.row]
        cell.render(model)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
