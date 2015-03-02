# fpm-scriptable change log

### v1.0.2

* Added --logfile option for logging to a file
* Updated the App class to accept arguments as a parameter to the run method so that it can be called independently from the executable. The executable will now handle parsing the command line options and passing them to the App class.

### v1.0.1

* Removed color output from log show method as it was not honoring the --nocolor option properly
* Updated exit value handling so the executable returns a proper exit value when an error is encountered
* Updated logging in the FPM::Scriptable::Script class
* Added option --nobanner for disabling the display of the application banner
* Simplified the executable library setup
* Updated how supporting classes are loaded

### v1.0

* Initial application release
