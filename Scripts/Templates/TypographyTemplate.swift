/* Generated by 'Generate-Swift-Font-Constants.swift' DO NOT CHANGE */

import UIKit

/**
Usage:

titleLabel.font = Typography.Title.font
Typography.Title.style(label: titleLabel)
*/
enum Typography: String
{
	// %CASE_DECLARATIONS%
	func style(label: UILabel)
	{
		let name = fontName
		let size = fontSize
		
		if let font = UIFont(name: name, size: size) {
			label.font = font
		}
	}
	
	var font: UIFont?
	{
		let name = fontName
		let size = fontSize
		
		return UIFont(name: name, size: size)
	}
	
	private var fontName: String
	{
		switch self
		{
			// %CASE_NAME_DESCRIPTIONS%
		}
	}
	
	private var fontSize: CGFloat
	{
		switch self
		{
			// %CASE_SIZE_DESCRIPTIONS%
		}
	}
}

@IBDesignable class TypographyLabel: UILabel
{
	/**
	IBDesignable doesn't support dropdowns, so we need to use a string unfortunately.
	*/
	@IBInspectable var typography: String = ""
	
	override var text: String? {
		didSet {
			updateFont()
		}
	}
	
	override func awakeFromNib()
	{
		super.awakeFromNib()
		
		updateFont()
	}
	
	override func prepareForInterfaceBuilder()
	{
		updateFont()
	}
	
	
	func updateFont()
	{
		guard self.typography != "" && self.text != nil && self.text?.characters.count != 0 else {
			return
		}
		
		if let typographyType = Typography(rawValue: self.typography) {
			self.font = typographyType.font
		}
	}
}
