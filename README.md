# Car Regonition

Welcome to the **Car Regonition** project. It's an internal application made for detecting cars and showing informations about them.

## Team

* [Julia Wolszczak](mailto:julia.wolszczak@netguru.co) - Project Manager
* [Michał Kwiecień](mailto:michal.kwiecien@netguru.co) - iOS Developer
* [Michał Warchał](mailto:michal.warchal@netguru.co) - iOS Developer
* [Anna-Mariia Shkarlinska](mailto:anna-mariia.shkarlinska@netguru.co) - iOS Developer

## Tools & Services

* Tools:
	* Xcode 10.1 with latest iOS stable SDK (12.0) and Swift 4.2
	* [Carthage](https://github.com/Carthage/Carthage) 0.29 or higher
	* [CocoaPods](https://github.com/CocoaPods/CocoaPods) 1.5 or higher
* Services:
	* [JIRA](https://netguru.atlassian.net/secure/RapidBoard.jspa?rapidView=584&view=detail)
	* [Bitrise](https://www.bitrise.io/app/c1dd582bc9a1724d)
	* [HockeyApp - staging](https://rink.hockeyapp.net/apps/835da3422b11431181aa26898a1ac418)

## Configuration

### Prerequisites

- [Bundler](http://bundler.io) (`gem install bundler`)
- [Homebrew](https://brew.sh)
- [Carthage](https://github.com/Carthage/Carthage) (`brew install carthage`)
- [CocoaPods](https://cocoapods.org) (`brew install cocoapods`)

### Instalation

1. Clone repository:

	```bash
	# over https:
	git clone https://github.com/netguru/car-recognition-ios
	# or over SSH:
	git@github.com:netguru/car-recognition-ios.git
	```

2. Install required Gems:

	```bash
	bundle install
	```

3. Run Carthage:

	```bash
	carthage bootstrap --platform iOS --cache-builds
	```

4. Download `.env` file from project's 1password vault and paste it into the root project's directory.

5. Install pods through Bundler:

	```bash
	bundle exec pod install
	```

6. Open `Car Recognition.xcworkspace` file and build the project.


## Coding guidelines

- Respect Swift [API Design Guidelines](https://swift.org/documentation/api-design-guidelines/)
- The code must be readable and self-explanatory - full variable names, meaningful methods, etc.
- Don't leave any commented-out code.
- Write documentation for every method and property accessible outside the class. For example well documented method looks as follows:

	```swift
	/// Tells the magician to perform a given trick.
	///
	/// - Parameter trick: The magic trick to perform.
	/// - Returns: Whether the magician succeeded in performing the magic trick.
	func perform(magicTrick trick: MagicTrick) -> Bool {
		// body
	}
	```

## Related repositories

- [Android](https://github.com/netguru/car-recognition-android)
- [Machine Learning](https://github.com/netguru/car-recognition-ml)
