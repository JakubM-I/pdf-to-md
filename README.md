# PDF to Markdown

Natywna aplikacja na macOS (SwiftUI) do konwersji plików PDF na czysty Markdown.
Działa w pełni lokalnie i korzysta z frameworków Apple: PDFKit, Vision, a w przyszłości Foundation Models.

Analiza problemów, które aplikacja ma rozwiązywać: [docs/analiza-potrzeb.md](docs/analiza-potrzeb.md).

## Wymagania

- macOS 26 lub nowszy
- Xcode 26 lub nowszy, ustawiony jako aktywny i z zaakceptowaną licencją:
  ```bash
  sudo xcode-select -s /Applications/Xcode.app/Contents/Developer
  sudo xcodebuild -license accept
  ```
- [XcodeGen](https://github.com/yonaskolb/XcodeGen): `brew install xcodegen`

## Szybki start

```bash
make project   # generuje PDFToMarkdown.xcodeproj z project.yml
make open      # otwiera projekt w Xcode
make test      # testy logiki konwersji
make run       # buduje i uruchamia aplikację
```

Plik `.xcodeproj` nie jest w repozytorium. Źródłem prawdy jest `project.yml`,
a projekt generujemy ponownie po każdej zmianie struktury (nowe pliki, ustawienia, targety).

## Struktura

```
App/                         Aplikacja SwiftUI (widoki, cykl życia, entitlements)
Packages/PDFToMarkdownCore/  Logika konwersji jako pakiet Swift, testowana bez UI
design/                      Zasady pracy z projektami z MagicPath
docs/                        Analizy i dokumentacja
project.yml                  Definicja projektu Xcode (XcodeGen)
```

## Architektura konwersji

Aplikacja korzysta tylko z protokołu `ConversionEngine`. Implementacje:

| Silnik | Status | Opis |
| --- | --- | --- |
| `PDFKitTextEngine` | jest | Tekst warstwy PDF i porządkowanie (łączenie wyrazów przeniesionych łącznikiem, scalanie linii w akapity) |
| Vision | planowany | OCR skanów, rozpoznawanie struktury dokumentu (akapity, listy, tabele) |
| Foundation Models | planowany | Lokalny model do korekty nagłówków i opisów obrazów |
