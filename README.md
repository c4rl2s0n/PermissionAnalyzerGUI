# permission_analyzer_gui

My Template for Flutter Projects

## required executables:
* adb
* tshark
* unzip
* ...?
## Brainstorming
* get ip location from https://www.geodatatool.com/en/?ip=3.160.226.226

## Setup
To use this template for a new project, copy the
* folders
    * lib
    * assets
* files
  * *.yaml
to the new Project.

Then, replace all occurrences of permission_analyzer_gui with your project_name (snake_case) and PermissionAnalyzerGui with ProjectName (CamelCase). (Strg+Shift+R in AndroidStudio)


To recompile the localization package, use 'flutter gen-l10n' from the command line.
To recompile the database models, user 'dart run build_runner build' from the command line.


# TODO:
* Time-sensitive analysis
  * live view with current connection highlights and screen recordings in second window
* Only show entries from the same level in analysis (different applications or same level within an application)
* do not set show=true for all groups by default!
* add option for grouped connections/endpoints
* allow to change number of testRuns for created scenario, only perform the missing tests. Do not change recording/duration/...
* add Firewall filters to constellation settings
* (secondary...) rename constellations(?)