# GenerateFontConstants    
Script, written in Swift 2.0, which generates a constants file to enable compile time checking and a more Swift way of defining typography rules across your app.

#### Also available: [Localization](https://github.com/devedup/GenerateI18NConstants)

## What it does
👍 Define typography rules to keep consistency across your app.    
👏 Uses IBDesignable.  
✊ Allows compile time checking  of your font styles.  
🙏 More Swifty syntax. `Typography.Title.font` instead of `UIFont(name: "Helvetica-Bold", size: 48)`.    
💪 Automatically style a label using the `.style(...)` method.    

## What it doesn't do
❌ Kerning and linespacing  -  yet!  

### Usage
Retrieves a UIFont for a specific style.   
``titleLabel.font = Typography.Title.font``

Sets a UIFont on a label for the specific style.   
``Typography.Title.style(label: titleLabel)``

### Installation
* Add a run script in 'Build Phases' to the target that executes the script below.
* Add the Typography.plist to the input files section of the build phase script.
* Add the Templates/TypographyTemplate.swift to the input files section of the build phase script.
* Add Typography.swift to the output file location for where your constants will be generated.
* Build your project.

### Build Script
````
SCRIPT_FILE="${SRCROOT}/Scripts/Generate-Swift-Font-Constants.swift"
echo "Running a custom build phase script: $SCRIPT_FILE"

${SCRIPT_FILE} "${SCRIPT_INPUT_FILE_0}" "${SCRIPT_INPUT_FILE_1}" "${SCRIPT_OUTPUT_FILE_0}"
echo "End of script"

scriptExitStatus=$?
echo "DONE with script: ${SCRIPT_FILE} (exitStatus=${scriptExitStatus})\n\n"
exit "${scriptExitStatus}"
````

### Authors   
[Daniel Love](https://github.com/4eleven7)  
[David Casserly](https://github.com/devedup)

### Contribute
1. Fork
1. Create your feature branch (git checkout -b my-new-feature)
1. Commit your changes (git commit -am 'Add some feature')
1. Push to the branch (git push origin my-new-feature)
1. Create new Pull Request

### License
GenerateFontConstants is available under the MIT license. See the LICENSE file for more info.
