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
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		
		assert(titleLabel != nil)
		assert(bodyLabel != nil)
		
		titleLabel.font = Typography.Title.font
		Typography.Body.style(bodyLabel)
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

