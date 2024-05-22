//
//  Cell.swift
//  taskonesql
//
//  Created by MANSVITA on 23/08/22.
//

import UIKit


class Cell: UITableViewCell {
    var datapass:String?
    var delegate:datapassBack!

    @IBOutlet weak var lblfirstname: UILabel!
    
    @IBOutlet weak var lblphoneno: UILabel!
   
    
    @IBOutlet weak var lbladdress: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
