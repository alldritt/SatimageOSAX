# ASToolbox

ASToolboxOSAX provides access to the [AppleScript Toolbox](https://astoolbox.wordpress.com) scripting additions on macOS Mojave (and later) macOS systems.

As described in the [Mojave Brings In Big Security Changes](https://latenightsw.com/mojave-brings-in-big-security-changes/) blog post (see the Farewell Scripting Additions section), AppleScript scripting additions (OSAXen) are no longer supported in macOS Mojave.  This presents a serious problem for older scripts which depend on the AppleScript Toolbox scripting addition.

## Installation

1. [Download](https://s3.amazonaws.com/latenightsw.com/ASToolboxOSAX 1.0.dmg) and mount the ASToolboxOSAX disk image
2. Copy the ASToolboxOSAX application to your Applications folder.
3. Make sure that you launch the ASToolboxOSAX application once manually.  macOS will ask for permission to run the application because it was downloaded from the internet.

## Usage

The ASToolboxOSAX app makes it possible to continue using the AppleScript Toolbox scripting additions with minimal changes to your scripts.  Once ASToolboxOSAX is installed, you only need to add these lines to the beginning of your script:

```
use scripting additions 
use application "ASToolboxOSAX"

```

That's it.  Now the ASToolboxOSAX application is used to handle all the AppleScript Toolbox scripting addition commands for your script.  Please note that this will be slower than before, but your script will run.

Here's a full example using the ASToolboxOSAX `AST URL decode ` command:

```
use scripting additions
use application "ASToolboxOSAX"

AST URL decode "Hello%20World%21"
```

## Backwards Compatibility

ASToolboxOSAX can be used on macOS 10.12 (Sierra) and above.  When using ASToolboxOSAX on pre-Mojave systems, I suggest removing the AppleScript Toolbox scripting additions from your system to avoid conflicts.

## WARNING

**I STRONGLY encourage you not to rely on ASToolboxOSAX as a long term solution.**

I suspect Apple will remove the functionality on which ASToolboxOSAX depends in future versions of macOS.  You should find alternative means of accomplishing what the AppleScript Toolbox scripting additions did for you in the past.  The Script Debugger support forum provides a [list of AppleScript libraries](https://forum.latenightsw.com/t/documentation-links/1485) you can use.  And then there is AppleScript Objective-C which gives you access to all the feature of Apple's Foundation framework (and other Objective-C frameworks).

## Support

If you have questions concerning ASToolboxOSAX please post them on the [Script Debugger Support Forum](https://forum.latenightsw.com/c/applescript) or [MacScripter.net](http://MacScripter.net).  Bugs can be filed as issues with the [GitHub repository](https://github.com/alldritt/SatimageOSAX).

## License

ASToolboxOSAX is licensed under the MIT license (see the LICENSE file for details).  The [AppleScript Toolbox](https://astoolbox.wordpress.com) scripting additions is included with permission by 

## Source Code

Source code for ASToolboxOSAX is available on [GitHub](https://github.com/alldritt/SatimageOSAX).  Pull requests are welcome.


