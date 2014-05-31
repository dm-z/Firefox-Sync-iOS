Firefox-sync-for-iOS
===============

Fork from https://github.com/mozilla-services/ios-sync-client

A standalone iOS client for Firefox Sync. 

Compatibility
-------------

This code is known to compile with Xcode 5.0.2 with the iOS 6.1 SDK under OS X 10.9.1.

Build Instructions
------------------

The project is completely self-contained and does not depend on external sources. To build, simply clone the project and then open the Sources/SyncClient.xcodeproject project in Xcode. You should be able to just hit run to build and run in the iPhone Simulator.

Plans on improving
------------------

1. ~~Add support for 4-inch displays~~
2. ~~Change custom graphics to native iOS7 interface.~~
3. Add external browsers to open menu (Chrome, Safari etc.)
4. Add cocoapods.
5. Remove old frameworks/change for new ones.
6. Maybe iPad version.

Project stopped, because Mozilla changed sync logic. Now sync works through Mozilla accounts.
