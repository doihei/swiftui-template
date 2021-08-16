
bootstrap:
	bundle config set path 'vendor/bundle'
	bundler install
	brew install mint
	mint bootstrap
	make carthage-install
	make xcodegen
	make pod-install
carthage-install:
	mint run Carthage carthage bootstrap --platform iOS --cache-builds --use-xcframeworks
pod-install:
	bundle exec pod install
xcodegen:
	mint run xcodegen
	make pod-install
template-install:
	sh scripts/xcode/install-xcode-template.sh
update-carthage:
	mint run Carthage carthage update --platform iOS --cache-builds --use-xcframeworks
