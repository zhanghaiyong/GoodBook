//
//  PushBook_Cell.swift
//  GoodBook
//
//  Created by zhy on 17/3/30.
//  Copyright © 2017年 zhanghaiyong. All rights reserved.
//

import UIKit

class PushBook_Cell: UITableViewCell {

    var BookName : UILabel?
    var Editor : UILabel?
    var More : UILabel?
    var Cover : UIImageView?
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        for view in self.contentView.subviews {
            
            view.removeFromSuperview()
        }
        
        self.BookName = UILabel(frame: CGRect(x: 78, y: 8, width: 242, height: 25))
        self.Editor = UILabel(frame: CGRect(x: 78, y: 33, width: 242, height: 25))
        self.More = UILabel(frame: CGRect(x: 78, y: 58, width: 242, height: 25))
        
        self.BookName?.font = UIFont(name: MY_FONT, size: 15)
        self.Editor?.font = UIFont(name: MY_FONT, size: 15)
        self.More?.font = UIFont(name: MY_FONT, size: 13)
        self.More?.textColor = UIColor.gray
        
        self.contentView.addSubview(self.BookName!)
        self.contentView.addSubview(self.Editor!)
        self.contentView.addSubview(self.More!)
        
        self.Cover = UIImageView(frame: CGRect(x: 8, y: 9, width: 56, height: 70))
        self.contentView.addSubview(self.Cover!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
