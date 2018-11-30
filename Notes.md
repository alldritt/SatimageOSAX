# Codesigning Notes

The Codesigning performed by Xcode is not sufficient to get this app working on Mojave (macOS 10.14).  You have to 
force the replacement of the signature within the embedded scripting additions

```
codesign -s "Developer ID Application: Mark Alldritt (Z7S6X96M3X)" --force --deep ~/Desktop/LNSOSAX.app/
```