# CLAUDE.md

Natywna aplikacja macOS (SwiftUI) konwertująca PDF na Markdown. Komunikacja z użytkownikiem i dokumentacja po polsku, a kod i identyfikatory po angielsku (komentarze mogą być po polsku).

## Polecenia

- `make project`: regeneracja `PDFToMarkdown.xcodeproj` z `project.yml`. Uruchamiaj po dodaniu lub usunięciu plików i zmianie ustawień. Nie edytuj `.xcodeproj` ręcznie, bo nie jest w gicie.
- `make test`: testy pakietu `PDFToMarkdownCore` (Swift Testing, `swift test`).
- `make build`: build aplikacji przez `xcodebuild`.
- `Makefile` ustawia `DEVELOPER_DIR` na `/Applications/Xcode.app`, więc działa także wtedy, gdy `xcode-select` wskazuje na Command Line Tools.

## Architektura

- `Packages/PDFToMarkdownCore`: cała logika konwersji, bez zależności od SwiftUI. Nowa logika trafia tutaj i ma testy.
- `App/`: tylko UI i integracja z systemem (pliki, sandbox, menu).
- UI zna wyłącznie protokół `ConversionEngine`. Nowy silnik (Vision, Foundation Models) to nowa implementacja protokołu, a nie zmiana w widokach.
- Cel: macOS 26+, Swift 6 (strict concurrency). Tylko frameworki Apple. Zewnętrzne zależności dodajemy dopiero po uzgodnieniu.
- Aplikacja działa w sandboxie: dostęp do plików wyłącznie przez pliki wybrane przez użytkownika (security-scoped URL).

## Wygląd (MagicPath)

MagicPath to źródło projektu wizualnego, a nie kodu. Komponentów React z MagicPath nie dodajemy do repozytorium. Przenosimy je ręcznie na SwiftUI, preferując natywne kontrolki macOS i wytyczne HIG. Szczegóły w `design/README.md`.

## Kontekst produktowy

`docs/analiza-potrzeb.md` opisuje problemy użytkowników: tabele, wielokolumnowość, nagłówki i stopki, przenoszenie wyrazów łącznikiem, obrazy jako osobne pliki zamiast base64, LaTeX, hierarchię nagłówków i prywatność. Decyzje funkcjonalne odnoś do tej listy.
