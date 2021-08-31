import Path
import TM2Runestone

let root = Path.cwd
let tmThemesPath = root.join("Colorsublime-Themes/themes")
guard tmThemesPath.exists else {
	fatalError("Colorsublime-Themes/themes folder doesn't exist. Make sure to fetch git submodules.")
}

let outputPath = root.join("Themes")
if outputPath.exists {
	try outputPath.delete()
	print("Deleted previous output folder")
}
try outputPath.mkdir()
print("Created output folder \(outputPath)")

let bundledThemes: Set<String> = ["Dracula", "Gruvbox-N", "Solarized-light", "Solarized-dark", "Tomorrow", "Tomorrow_Night", "Tomorrow_Night_Blue", "Tomorrow_Night_Bright", "Tomorrow_Night_Eighties"]
var successCount = 0, failCount = 0, skipCount = 0

for path in tmThemesPath.ls() where path.extension.lowercased() == "tmtheme" {
	let filename = path.basename(dropExtension: true)
	guard !bundledThemes.contains(filename) else {
		print("Skipping \(filename)")
		skipCount += 1
		continue
	}
	do {
		let tmTheme = try TMTheme(contentsOf: path.url)
		print("Converting '\(tmTheme.name)'...")
		// In Runestone name is derived from the file name
		try convert(
			tmTheme: tmTheme,
			toRunestonetheme: outputPath.join("\(tmTheme.name).runestonetheme").url
		)
		successCount += 1
	} catch {
		print("Error converting \(filename).tmTheme: \(error)")
		failCount += 1
	}
}
print("Converted \(successCount) themes, failed \(failCount), skipped: \(skipCount)")
