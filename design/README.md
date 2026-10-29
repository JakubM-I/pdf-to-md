# Projekt wizualny (MagicPath)

MagicPath służy wyłącznie do projektowania wyglądu. Jego komponenty (React + TypeScript)
**nie są** częścią aplikacji. Traktujemy je jako źródło prawdy o wyglądzie, a widoki
przenosimy ręcznie do SwiftUI.

## Zasady przenoszenia do SwiftUI

- Każdy ekran lub komponent z MagicPath ma odpowiadający mu widok w `App/`.
  W komentarzu nad widokiem podajemy nazwę lub link komponentu w MagicPath.
- Kolory, odstępy i typografię z motywu MagicPath zapisujemy jako tokeny
  (kolory w Asset Catalog, stałe w `App/DesignSystem/`), a nie jako wartości wpisane na sztywno w widokach.
- Tam, gdzie macOS ma natywny odpowiednik (pasek narzędzi, panel boczny, arkusze,
  `fileImporter`, systemowe kontrolki), używamy go zamiast odtwarzać webowy wygląd 1:1.
  Liczy się zgodność z wytycznymi Apple Human Interface Guidelines.

## Zawartość katalogu

- `README.md`: ten plik.
- Zrzuty lub eksporty ekranów z MagicPath (PNG) mogą trafiać do `design/screens/`
  jako materiał referencyjny.
