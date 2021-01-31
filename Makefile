build:
	 swift build -c release
	 cp .build/release/xccodecov .

xcodeproj:
	swift package generate-xcodeproj