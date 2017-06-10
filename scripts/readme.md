Scripts for automated building of an Ionic 2+ project.

build_from_clone.sh
  1) creates a new directory
  2) clones source code of Ionic project from bitbucket
  3) removes platform files, plugins, node_modules (which shouldn't be checked in anyways, but just in case)
  4) npm install
  5) adds cordova platforms
  6) ups the version number in config.xml (now handled as a npm module https://www.npmjs.com/package/cordova-build-increment)
  7) add encryption flag to the ios project
  8) update the ios project to not use automatic signing <---not working
  9) copies in fastlane files into the ios project
  10) runs fastlane to deploye to testflight
  
