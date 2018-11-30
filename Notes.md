# Codesigning Notes

The Codesigning performed by Xcode is not sufficient to get this app working on Mojave (macOS 10.14).  You have to 
force the replacement of the signature within the embedded scripting additions

```
codesign -s "Developer ID Application: Mark Alldritt (Z7S6X96M3X)" --force --deep ~/Desktop/LNSOSAX.app/
```

**UPDATE**

For the LNSOSAX, this does not work because the embedded scripting additions where never codesigned.  For the app 
to work on Mojave, each of the embedded scription additions must be codesigned using the above command.  Then, the entire
app needs to be codesigned.
