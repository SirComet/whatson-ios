# What'sOn

[![Language](https://img.shields.io/badge/Swift-5.1-brightgreen.svg)](http://swift.org)
[![Xcode](https://img.shields.io/badge/Xcode-11.3-brightgreen.svg)](https://developer.apple.com/download/more/)

## How to run the project

* Download Xcode 11 or greater (In order to fetch dependencies with Swift Package Manager)

* Create a new file to store your ApiKey with the following content.

```swift
// /WhatsOn/Core/Network/ApiKey.swift

struct ApiKey {
    static var value: String {
        "your_api_key_here"
    }
}
```