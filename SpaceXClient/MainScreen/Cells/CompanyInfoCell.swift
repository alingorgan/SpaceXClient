//
//  CompanyInfoCell.swift
//  SpaceXClient
//
//  Created by Alin Gorgan on 5/27/21.
//

import UIKit

final class CompanyInfoCell: UITableViewCell, IdentifiableCell {
    
    static var CellIdentifier = String(describing: CompanyInfoCell.self)
    
    func update(displayable: Any) {
        guard let companyInfo = displayable as? CompanyInfo else {
            assertionFailure("Expecting company info data")
            return
        }
        
        textLabel?.text = "\(companyInfo.name) was founded by \(companyInfo.founder) in "
        + "\(companyInfo.year). It has now \(companyInfo.employeeCount) employees, "
        + "\(companyInfo.launchSiteCount) launch sites, and is valued at "
        + "\(companyInfo.valuation)"
    }
    
}
