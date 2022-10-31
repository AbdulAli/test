//
//  UserDetailsViewController.swift
//  CartrackTechChallenge
//
//  Created by Ricardo Correia on 09/06/2020.
//  Copyright © 2020 Ricardo Correia. All rights reserved.
//

import Foundation
import MapKit
import UIKit

internal class UserDetailsViewController: UITableViewController {
    
    // MARK: - Internal Attributes
    internal var userDetails: User?
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - TableView delegate and datasource functions
extension UserDetailsViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0, 2:
            return 350
        case 1:
            return 180
        default:
            break
        }
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            return self.buildMainCell(indexPath)
        case 1:
            return self.buildCompanyCell(indexPath)
        case 2:
            return self.buildAddressCell(indexPath)
        default:
            break
        }
        
        return UITableViewCell()
    }
    
    private func buildMainCell(_ indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserDetailsMainCell", for: indexPath) as? UserDetailsMainCell else {
            return UITableViewCell()
        }
            
        cell.selectionStyle = .none
        cell.name?.text = userDetails?.name ?? ""
        
        let usernameImg = UIImage(named: "username") ?? UIImage()
        cell.username?.set(image: usernameImg, with: userDetails?.username ?? "", width: 15, height: 15)
        
        let phoneImg = UIImage(named: "phone") ?? UIImage()
        cell.phoneNumber?.set(image: phoneImg, with: userDetails?.phone ?? "", width: 15, height: 15)
        
        let emailImg = UIImage(named: "email") ?? UIImage()
        cell.email?.set(image: emailImg, with: userDetails?.email ?? "", width: 20, height: 15)
        
        let webImg = UIImage(named: "web") ?? UIImage()
        cell.website?.set(image: webImg, with: userDetails?.website ?? "", width: 15, height: 15)
        
        return cell
    }
    
    private func buildCompanyCell(_ indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CompanyCell", for: indexPath) as? CompanyCell else {
            return UITableViewCell()
        }
            
        cell.selectionStyle = .none
        
        let workImg = UIImage(named: "work") ?? UIImage()
        cell.worksAtLabel.set(image: workImg, with: "works_at".localized(), width: 20, height: 20)
        
        cell.companyName?.text = userDetails?.company?.name ?? ""
        cell.catchPhrase?.text = userDetails?.company?.catchPhrase ?? ""
        cell.bs?.text = userDetails?.company?.bs ?? ""
        
        return cell
    }
    
    private func buildAddressCell(_ indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AddressCell", for: indexPath) as? AddressCell else {
            return UITableViewCell()
        }
            
        cell.selectionStyle = .none
        
        let addressImg = UIImage(named: "address") ?? UIImage()
        cell.addressLabel.set(image: addressImg, with: "address".localized(), width: 20, height: 20)
        
        let address = "\(userDetails?.address?.street ?? ""), \(userDetails?.address?.suite ?? ""), \(userDetails?.address?.zipcode ?? ""), \(userDetails?.address?.city ?? "")"
        cell.addressName?.text = address
        
        let lat = userDetails?.address?.geo?.latitude ?? 0
        let long = userDetails?.address?.geo?.longitude ?? 0
        
        let userCenter = CLLocationCoordinate2D(latitude: lat, longitude: long)
        let annotation = MKPointAnnotation()
        annotation.title = address
        annotation.coordinate = userCenter
        
        cell.mapView.addAnnotation(annotation)
        cell.mapView.setCenter(userCenter, animated: true)
        
        return cell
    }
}
