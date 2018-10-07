# SatimageOSAX

SatimageOSAX is an application providing access to the [Satimage](http://www.satimage.fr/software/en/downloads/downloads_companion_osaxen.html) scripting additions on macOS Mojave systems.

As described in the [Mojave Brings In Big Security Changes](https://latenightsw.com/mojave-brings-in-big-security-changes/) blog post (see the Farewell Scripting Additions section), AppleScript scripting additions (OSAXen) are no longer supported in macOS Mojave.  This presents a serious problem for older scripts which depend on the popular suite of Satimage scripting additions.

The SatimageOSAX app makes it possible to continue using Satimage scripting additions with minimal changes to your scripts.  Once SatimageOSAX is installed, you only need to add a single line to the beginning of your script:

```
use application "SatimageOSAX"```

That's it.  Now the SatimageOSAX application is used to handle all the Satimage scripting addition commands for your script.  Please note that this will be slower than before, but your script will run.

Here's a full example using the Satimage `uppercase` command:

```
use scripting additionsuse application "SatimageOSAX"uppercase "Hello Again!"
```

## WARNING

**I strongly encourage you not to rely on SatimageOSAX as a long term solution.**

I suspect Apple will remove the functionality on which SatimageOSAX depends in future versions of macOS.  SatimageOSAX is also slower than any other solution.  You should find alternative means of accomplishing what the Satimage scripting additions did for you in the past.  The Script Debugger support forum provides a [list of AppleScript libraries](https://forum.latenightsw.com/t/documentation-links/1485) you can use.  And then there is AppleScript Objective-C which gives you access to all the feature of Apple's Foundation framework (and other Objective-C frameworks).

## SUPPORT

If you have questions concerning SatimageOSAX please post them on the [Script Debugger Support Forum](https://forum.latenightsw.com/c/applescript) or [MacScripter.net](http://MacScripter.net).  Bugs can be filed as issues with the [GitHub repository](https://github.com/alldritt/SatimageOSAX).

## LICENSE

SatimageOSAX is licensed under the MIT license (see the LICENSE file for details).

## SOURCE CODE

Source code for SatimageOSAX is available on [GitHub](https://github.com/alldritt/SatimageOSAX).  Pull requests are welcome.


