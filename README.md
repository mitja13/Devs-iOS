
# Devs App Example 
List Github Developers by Language 

Devs is an iOS app that lists all Github developers by programming language. It also serves as Swift and GraphQL API source code example, written in Swift 3.2.

![Devs](http://i.imgur.com/pHUWu8f.gif)

(Tested on iOS 10.x and 11.x, Xcode 8 and 9 beta-4)

## Build Instructions

1. Download the [Devs for iOS Source Code](https://github.com/mitja13/Devs-iOS/archive/master.zip) or   
```
git clone https://github.com/mitja13/Devs-iOS.git
```

2. Install dependency frameworks (only Apollo GraphQL client)
```
pod install
```

3. Create github access token. In Github Settings/Personal access tokens generate new token with scopes `user/read:user` and `user/read:email`. Copy the generated token to Info.plist (and Info-Blue.plist) row in `GithubAccessToken`.

4. Open `Devs.xcworkspace` in Xcode, don’t use Devs.xcodeproj (as will not properly build dependencies)

5. Build and Run

## Have a Question?

[Contact me](mailto:hello@mitja.co) if you need help, or have suggestions.
