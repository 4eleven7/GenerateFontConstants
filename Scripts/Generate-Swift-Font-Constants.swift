#!/usr/bin/env xcrun swift

import Foundation

let DECLARATIONS = "// %CASE_DECLARATIONS%"
let NAME_DESCRIPTIONS = "// %CASE_NAME_DESCRIPTIONS%"
let SIZE_DESCRIPTIONS = "// %CASE_SIZE_DESCRIPTIONS%"

// Input and Output
var inputPath: String?
var outputPath: String?
var templatePath: String?

// Process the arguments
print("Process.arguments gave args:")
guard Process.arguments.count == 4 else {
	fatalError("We should have 3 arguments into the script")
}

// Arguments
func parseArguments(arguments: [String]) {
	for argument in arguments {
		if argument.lowercaseString.rangeOfString("template") != nil {
			templatePath = argument
		}
		else if argument.rangeOfString(".plist") != nil {
			inputPath = argument
		}
		else if argument.rangeOfString(".swift") != nil {
			outputPath = argument
		}
	}
}

// First argument is always the current script, discard it
var arguments = Process.arguments
arguments.removeAtIndex(0)
parseArguments(arguments)

guard inputPath != nil else {
	fatalError("Please supply font plist input path")
}

guard outputPath != nil else {
	fatalError("Please supply swift file output path")
}

guard templatePath != nil else {
	fatalError("Please supply template input path")
}

// Read the font file
var fontDict: [String: AnyObject]?
guard let fontInputPath = inputPath else {
	fatalError("We should have the input path of the font plist file")
}

if let dict = NSDictionary(contentsOfFile: fontInputPath) as? [String: AnyObject]
{
	print("fontDict \(dict)")
	fontDict = dict
}

print(fontDict)

// We now have all the fonts in fontDict
guard let fontDict = fontDict else {
	fatalError("We should have a dictionary of strings")
}

// Build case statements
func buildCaseStatements() -> [(casename: String, fontname: String, fontsize: String)] {
	var templateReplacements = [(casename: String, fontname: String, fontsize: String)]()
	for (key, value) in fontDict {
		print("key \(key) fontDict: \(value)")
		let camelCaseKey = camelCase(key)
		let casename = "case \(camelCaseKey)\n"
		let fontname = "case .\(camelCaseKey):\n\t\t\t\t\treturn \"\(value["Font"] as! String)\""
		let fontsize = "case .\(camelCaseKey):\n\t\t\t\t\treturn \"\(value["Size"] as! Int)\""
		templateReplacements += [(casename, fontname, fontsize)]
	}
	return templateReplacements
}

func camelCase(key: String) -> String {
	let words = key.componentsSeparatedByString(".")
	let camelCase = words.map({$0.capitalizedString})
	
	return camelCase.joinWithSeparator("")
}

let caseStatements = buildCaseStatements()
print("\(caseStatements)")

func caseDeclarations() -> String {
	var outputString = ""
	for caseStatement in caseStatements
	{
		if outputString == "" {
			outputString = caseStatement.casename
			continue
		}
		
		outputString += "\t\(caseStatement.casename)"
	}
	return outputString
}

func caseNameDescriptions() -> String {
	var outputString = ""
	for caseStatement in caseStatements
	{
		if outputString == "" {
			outputString = caseStatement.fontname
			continue
		}
		
		outputString += "\n\t\t\t\(caseStatement.fontname)"
	}
	return outputString
}

func caseSizeDescriptions() -> String {
	var outputString = ""
	for caseStatement in caseStatements
	{
		if outputString == "" {
			outputString = caseStatement.fontsize
			continue
		}
		
		outputString += "\n\t\t\t\(caseStatement.fontsize)"
	}
	return outputString
}

// Write to file
func writeOutputToFile() {
	guard let templatePath = templatePath,
		let outputPath = outputPath else {
		fatalError("We should have the outputPath and templatePath of the Localizable.strings")
	}
	
	if let templateData = NSData(contentsOfFile: templatePath),
		var templateString = NSString(data:templateData, encoding:NSUTF8StringEncoding) as String?
	{
		templateString = templateString.stringByReplacingOccurrencesOfString(DECLARATIONS, withString: caseDeclarations())
		
		templateString = templateString.stringByReplacingOccurrencesOfString(NAME_DESCRIPTIONS, withString: caseNameDescriptions())
		
		templateString = templateString.stringByReplacingOccurrencesOfString(SIZE_DESCRIPTIONS, withString: caseSizeDescriptions())
		
		if let data = templateString.dataUsingEncoding(NSUTF8StringEncoding) {
			data.writeToFile(outputPath, atomically: true)
		}
		
	}
}

writeOutputToFile()
