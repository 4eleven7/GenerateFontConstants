//
//  ViewController.swift
//  GenerateFontConstantsDemo
//
//  Created by Daniel Love on 16/12/2015.
//  Copyright © 2015 Daniel Love. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
	@IBOutlet var titleLabel: UILabel!
	@IBOutlet var bodyLabel: UILabel!
	
	@IBOutlet var typographyLabel: TypographyLabel!
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		
		assert(titleLabel != nil)
		assert(typographyLabel != nil)
		assert(bodyLabel != nil)
		
		titleLabel.font = Typography.Title.font
		Typography.Body.style(bodyLabel)
	}
}
