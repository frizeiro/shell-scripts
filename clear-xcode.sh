#!/bin/sh

echo ""
echo "Disk space summary before:"
df -h
echo ""

echo "Stoping Xcode..."
killall Xcode

echo "Clearing Module Cache..."
rm -rf "$(getconf DARWIN_USER_CACHE_DIR)org.llvm.clang/ModuleCache"
rm -rf "$(getconf DARWIN_USER_CACHE_DIR)org.llvm.clang.$(whoami)/ModuleCache"

echo "Clearing Xcode Cache..."
rm -rf ~/Library/Caches/com.apple.dt.Xcode/*

echo "Clearing Derived Data..."
rm -rf ~/Library/Developer/Xcode/DerivedData/*

echo "Clearing Archives..."
rm -rf ~/Library/Developer/Xcode/Archives/*

echo "Clearing Simulators Caches..."
rm -rf ~/Library/Developer/CoreSimulator/Caches/*
xcrun -k
xcrun simctl delete unavailable

echo ""
echo "You will now be able to delete iOS support folders from PHYSICAL DEVICES that are no longer in use."
read -p "Press enter to continue"
open ~/Library/Developer/Xcode/iOS\ DeviceSupport

echo ""
echo "You will now be able to delete iOS support folders from SIMULATORS that are no longer in use."
read -p "Press enter to continue"
open /Library/Developer/CoreSimulator/Profiles/Runtimes/

echo ""
read -p "It's all done. Press enter to finish."

echo ""
echo "Disk space summary after:"
df -h
echo ""
