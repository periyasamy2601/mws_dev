#!/bin/bash
# Build direcotry
buildFolder="build"

# Check for build directory, if found delete it using the rm command and create new build directory ##
[ -d "$buildFolder" ] && rm -r "$buildFolder"; mkdir "$buildFolder"

# Install dependencies
# npm install -g @loopback/cli
npm install

# To make the build of the application
npm run rebuild

# Copy package.json file to the build directory
cp package*.json $buildFolder/

# Check firebase.*.json file exist or not
if ls firebase*.json 1> /dev/null 2>&1; then
  # Copy firebase.*.json file to the build directory
  cp firebase*.json "$buildFolder/"
fi

# Copy pm2.config.js file to the build directory
cp pm2.config.js $buildFolder/

# Copy dist directory to the build directory
cp -r release/ $buildFolder/dist

# Copy pulbic directory to the build directory
cp -rf public/ $buildFolder/public

# Remove test folder
rm -rf $buildFolder/__tests__

# Make the logs directory fot the logger service
mkdir $buildFolder/logs/

# To make a copy of migrate script to build directory
cp migrate.sh $buildFolder/

# Cleanup directory
rm -rf dist release
