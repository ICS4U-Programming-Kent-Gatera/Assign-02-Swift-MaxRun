/**
 * My program reads from an input file, and writes the max run of input to an output file.
 *
 * @author  Kent Gatera
 * @version 1.0
 * @since   2024-Apr-14
 */

import Foundation

func main() {
    let inputFilePath = "input.txt"
    let outputFilePath = "output.txt"
    
    do {
        // Read from input file
        let inputFileContent = try String(contentsOfFile: inputFilePath, encoding: .utf8)
        let lines = inputFileContent.components(separatedBy: .newlines)
        
        // Write to output file
        let fileURL = URL(fileURLWithPath: outputFilePath)
        let outputFileHandle = try FileHandle(forWritingTo: fileURL)
        
        // FOr every line in the input,
        for line in lines {
            let result = runCalc(line)
            if result[0] == 999 {
                // We write output of that line.
                try! outputFileHandle.write("No recurring characters in this line.\n".data(using: .utf8)!)
            } else {
                let maxRunChar = Character(UnicodeScalar(result[1])!)
                let maxRunLength = result[0]
                let outputString = "The max run is '\(maxRunChar)' and '\(maxRunLength)' characters long.\n"
                try! outputFileHandle.write(outputString.data(using: .utf8)!)
            }
        }
        
        // Close output file
        outputFileHandle.closeFile()
        print("Output written to \(outputFilePath)")
    } catch {
        // Handle file reading/writing errors
        print("Error: \(error)")
    }
}

func runCalc(_ str: String) -> [Int] {
    var maxRun = 0
    var runChar: Character = "0"
    let len = str.count
    var iter = 0
    
    while iter < len {
        let currentLetter = str[str.index(str.startIndex, offsetBy: iter)]
        var charRun = 1
        
        // Count consecutive identical characters
        var nextIndex = str.index(str.startIndex, offsetBy: iter + 1)
        while nextIndex < str.endIndex && str[nextIndex] == currentLetter {
            charRun += 1
            iter += 1
            nextIndex = str.index(str.startIndex, offsetBy: iter + 1)
        }
        
        // Update maximum run length if the current run is longer
        if charRun > maxRun && charRun > 1 {
            maxRun = charRun
            runChar = currentLetter
        } else if charRun == 1 && runChar == "0" {
            maxRun = 999
        }
        
        iter += 1
    }
    
    return [maxRun, Int(runChar.asciiValue ?? 0)]
}

// Call the main function
main()
