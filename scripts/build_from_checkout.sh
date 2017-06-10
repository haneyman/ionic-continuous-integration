#!/bin/bash
# ********************* Build Script CHECKOUT ********************
#    V 1.0  6/9/17
#
# ****************************************************************
# Checks out the latest from git repo, rebuilds the ios/android projects, TBD
# read -s -p Password: PW

BASE="/Users/$USER/HC"
echo ===== BASE directory is $BASE
BASE="/Users/$USER/HC"
if [ -d $BASE ]; then
  echo  ===== base directory exists
  cd $BASE
else
  echo  ===== base should be: $BASE
  echo  ===== standard base directory is missing, do you need to call build_from_clone.sh ?
  exit 1
fi

SRC=$BASE"/mobile"
if [ -d $SRC ]; then
  cd $BASE
#  echo clearing out previous build in $SRC...
  echo  ===== Source directory confirmed: $SRC
  echo  ===== It is currently NOT being altered, relying on git checkout.
#  sudo rm -rf $SRC
else
  echo  ===== source should be: $SRC
  echo  ===== standard source directory is missing, do you need to call build_from_clone.sh ?
fi

echo  ===== base: $BASE
echo  ===== source: $SRC
#read  -n 1 -p "Directories set up properly?" ans

#if [ -z ${BITBUCKET_USER} ]; then
#if [ ! -v BITBUCKET_USER ]; then
#  read  -n 1 -p "What is your bitbucket user?" BITBUCKET_USER
#elif [ -z "$BITBUCKET_USER" ]; then
#  read  -p "What is your bitbucket user (set env var BITBUCKET_USER to avoid this)?" BITBUCKET_USER
#else
#  echo  ===== BITBUCKET_USER env variable set: $BITBUCKET_USER
#fi

echo  ===== pulling latest source from develop...
#cd /Users/admin/repos
cd $SRC
echo  ===== pulling to $SRC...
git fetch
git status
#read -p "git fetched, look good?"
echo  ===== Checking out: develop
git checkout develop
#clear out any local changes
git checkout -- .
git status
#read -p "git checkout of develop, status should be clean, yah?"
git pull
git status
read -p "git pulled and should still be clean, look good?"

#install npm modules
read -p "Ready for ionic build ios?"
echo ===== Installing new npm modules...
sudo npm install
read  -p "Npm installs done, proceed?" ans

#build ionic ios
echo ===== Building ionic ios...
cd $SRC
sudo ionic build ios
read  -p "Ionic build ios complete, proceed?" ans

echo ===== committing version change to git...
#git add config.xml
#git commit -m "Incremented version in config.xml - automated build script build_from_checkout.sh "
#echo =====    pushing config.xml...
#git push
#read -p "version bumped, proceed?" ans

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

