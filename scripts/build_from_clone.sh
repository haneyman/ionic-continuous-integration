#!/bin/bash
# ====================* Heycoach Build Script ====================
# ============================================================****
# file clones the mobile repo and copies web assets into this project.
# read -s -p Password: PW

BASE="/Users/$USER/HC"
echo ===== BASE directory is $BASE
BASE="/Users/$USER/HC"
if [ -d $BASE ]; then
  echo base directory exists
  cd $BASE
else
  echo creating base directory...
  sudo mkdir $BASE
  cd $BASE
fi

SRC=$BASE"/mobile"
if [ -d $SRC ]; then
  cd $BASE
  echo clearing out previous build in $SRC...
  sudo rm -rf $SRC
else
  sudo mkdir $BASE
  cd $BASE
fi

echo base: $BASE
echo source: $SRC
#read  -n 1 -p "Directories set up properly?" ans

if [ -z ${BITBUCKET_USER} ]; then
#if [ ! -v BITBUCKET_USER ]; then
#  read  -n 1 -p "What is your bitbucket user?" BITBUCKET_USER
#elif [ -z "$BITBUCKET_USER" ]; then
  read  -p "What is your bitbucket user (set env var BITBUCKET_USER to avoid this)?" BITBUCKET_USER
else
  echo BITBUCKET_USER env variable set: $BITBUCKET_USER
fi

echo ===== pulling latest source from develop using user $BITBUCKET_USER...
#cd /Users/admin/repos
cd $BASE
echo ===== cloning to $SRC...
###git clone https://markphaney@bitbucket.org/heycoachapp/mobile.git $src
#sudo -i -u admin git clone git@bitbucket.org:heycoachapp/mobile.git
#git clone git@bitbucket.org:heycoachapp/mobile.git
#  git clone https://markphaney@bitbucket.org/heycoachapp/mobile.git
git clone https://$BITBUCKET_USER@bitbucket.org/heycoachapp/mobile.git
cd $SRC
pwd
###chmod -R 777 *
git checkout develop

echo ===== removing platform files...
cd $SRC
sudo rm -rf ./platforms
sudo rm -rf ./plugins
sudo rm -rf ./node_modules
#read  -n 1 -p "Source ready for adds?" version

# read  -n 1 -p "ready for npm install?" version
echo ===== Installing new npm modules...
sudo npm install
#read  -p "Npm installs done, proceed?" ans

echo ===== adding platforms...
echo =====    ios...go get some coffee...
mkdir www
sudo ionic platform add ios
#sudo ionic platform add android
#read  -n 1 -p "Source all good?" version
#sudo cordova plugin add cordova-ios-plugin-no-export-compliance
#read  -n 1 -p "added export plugin complete, proceed?" ans

#build ionic ios
echo ===== Building ionic ios...
cd $SRC
sudo ionic build ios
# read  -p "Ionic build ios complete, proceed?" ans

echo ===== committing version change to git...
git add config.xml
git commit -m "Incremented version in config.xml - automated build script build_from_clone.sh "
echo =====    pushing config.xml...
git push
# read  -n 1 -p "Ionic build ios complete, proceed?" ans

#read  -n 1 -p "Version?" version
cd $SRC
echo ===== Version is now:
grep -o 'ios-CFBundleVersion="[^"]*"' config.xml

#Adding the encryption flag to the ios project
PLISTPATH=$SRC/platforms/ios/Heycoach
echo ===== adding export to $PLISTPATH ...
cd $PLISTPATH
sudo /usr/libexec/PlistBuddy -c "Add :ITSAppUsesNonExemptEncryption bool false" Heycoach-Info.plist
# read -p 'did it update the plist?'

echo ===== updating ios project to not be automatic signing
sudo chmod -R 777 $SRC
cd $SRC/platforms/ios/Heycoach.xcodeproj
sudo sed -i '' 's/ProvisioningStyle = Automatic;/ProvisioningStyle = Manual;/' project.pbxproj
#use fastlane to build and deploy the app to TestFlight
read   -p "sed changed automatic?" ans
#read   -p "Copy Fastlane?" ans
echo ===== copying fastlane files into ionic generated ios project...
sudo cp -R $SRC/fastlane $SRC/platforms/ios

# read -p "Run Fastlane?" ans
echo ===== running fastlane build...
cd $SRC/platforms/ios
sudo fastlane beta

