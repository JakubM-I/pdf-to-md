DEVELOPER_DIR ?= /Applications/Xcode.app/Contents/Developer
export DEVELOPER_DIR

SCHEME := PDFToMarkdown
DERIVED := build/DerivedData

.PHONY: project build test test-core open run clean

project: ## Generuje PDFToMarkdown.xcodeproj z project.yml
	xcodegen generate

build: project ## Buduje aplikację (Debug)
	xcodebuild -project $(SCHEME).xcodeproj -scheme $(SCHEME) -configuration Debug \
		-derivedDataPath $(DERIVED) build

test-core: ## Testy pakietu PDFToMarkdownCore
	swift test --package-path Packages/PDFToMarkdownCore

test: test-core

open: project ## Otwiera projekt w Xcode
	open $(SCHEME).xcodeproj

run: build ## Buduje i uruchamia aplikację
	open $(DERIVED)/Build/Products/Debug/$(SCHEME).app

clean:
	rm -rf build $(SCHEME).xcodeproj Packages/PDFToMarkdownCore/.build
