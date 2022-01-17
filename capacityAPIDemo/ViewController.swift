//
//  ViewController.swift
//  capacityAPIDemo
//
//  Created by Kevin Wang on 2021/12/22.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var pastBoard = UIPasteboard.general
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let docsURL = URL(fileURLWithPath: path)
        let values = try! docsURL.resourceValues(forKeys: [.volumeAvailableCapacityKey,.volumeAvailableCapacityForImportantUsageKey,.volumeAvailableCapacityForOpportunisticUsageKey,.volumeTotalCapacityKey])
        let strF = ByteCountFormatter()
        
        switch indexPath.row{
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "c1", for: indexPath)
            cell.textLabel?.text = path
            cell.detailTextLabel?.text = ""
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "c1", for: indexPath)
            //cell.detailTextLabel?.text = strF.string(fromByteCount: Int64(values.volumeAvailableCapacity!))
            cell.detailTextLabel?.text = ByteCountFormatter.string(fromByteCount: Int64(values.volumeAvailableCapacity!), countStyle: .binary)
            cell.textLabel?.text="AvailableCapacityKey"
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "c1", for: indexPath)
            cell.detailTextLabel?.text = strF.string(fromByteCount: values.volumeAvailableCapacityForImportantUsage!)
            cell.textLabel?.text="AvailableCapacityForImportantUsageKey"
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "c1", for: indexPath)
            cell.detailTextLabel?.text = strF.string(fromByteCount: values.volumeAvailableCapacityForOpportunisticUsage!)
            cell.textLabel?.text="AvailableCapacityForOpportunisticUsageKey"
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "c1", for: indexPath)
            cell.detailTextLabel?.text = strF.string(fromByteCount: Int64(values.volumeTotalCapacity!))
            cell.textLabel?.text="TotalCapacity"
            return cell
        default:
            fatalError("Error")
        }
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "Writen by Kevin Wang @ 2022"
    }
    
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let configuration = UIContextMenuConfiguration(identifier: nil, previewProvider: nil, actionProvider: {
            suggestedActions in
            let copyKeyAction =
            UIAction(title: "Copy Key", image: UIImage(systemName: "doc.on.doc")){action in
                self.pastBoard.string = tableView.cellForRow(at: indexPath)?.textLabel?.text
                print("copy Key")
            }
            let copyValueAction =
            UIAction(title: "Copy Value", image: UIImage(systemName: "doc.on.doc")){action in
                self.pastBoard.string = tableView.cellForRow(at: indexPath)?.detailTextLabel?.text
                print("copy Value")
            }
        return UIMenu(title: "",  children: [copyKeyAction,copyValueAction])
        })
        return configuration
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
