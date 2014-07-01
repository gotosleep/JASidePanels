XBUILD=/Applications/Xcode.app/Contents/Developer/usr/bin/xcodebuild
PROJECT_ROOT=.
PROJECT=$(PROJECT_ROOT)/JASidePanels.xcodeproj
TARGET=JASidePanelsStatic

all: libJASidePanelsStatic.a

libJASidePanelsStatic-i386.a:
	$(XBUILD) -project $(PROJECT) -target $(TARGET) -sdk iphonesimulator -configuration Release clean build
	-mv $(PROJECT_ROOT)/build/Release-iphonesimulator/lib$(TARGET).a $@

libJASidePanelsStatic-armv7.a:
	$(XBUILD) -project $(PROJECT) -target $(TARGET) -sdk iphoneos -arch armv7 -configuration Release clean build
	-mv $(PROJECT_ROOT)/build/Release-iphoneos/lib$(TARGET).a $@

libJASidePanelsStatic-armv7s.a:
	$(XBUILD) -project $(PROJECT) -target $(TARGET) -sdk iphoneos -arch armv7s -configuration Release clean build
	-mv $(PROJECT_ROOT)/build/Release-iphoneos/lib$(TARGET).a $@

libJASidePanelsStatic.a: libJASidePanelsStatic-i386.a libJASidePanelsStatic-armv7.a libJASidePanelsStatic-armv7s.a
	lipo -create -output $@ $^

clean:
	-rm -f *.a *.dll
