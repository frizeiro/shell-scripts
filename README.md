# Mobile Utils
Some util tools to help mobile development.

## Clear Xcode Data
Script to clear the Xcode Data and free up disk space.

### What will this clean up?

- org.llvm.clang/ModuleCache
- Xcode Cache
- Derived Data
- Archives
- Core Simulator Cache
- Unavailable Simulators
- iOS Device Support
- Core Simulator Profiles

### How to use

```shell
git clone git@github.com:frizeiro/mobile-utils.git
cd mobile-utils
./clear-xcode.sh
```