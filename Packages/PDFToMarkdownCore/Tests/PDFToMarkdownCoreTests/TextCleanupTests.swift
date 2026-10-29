import Testing
@testable import PDFToMarkdownCore

@Suite struct TextCleanupTests {
    @Test func joinsWordsHyphenatedAtLineEnd() {
        #expect(TextCleanup.joinHyphenatedWords("kon-\nwersja") == "konwersja")
    }

    @Test func keepsHyphenBeforeCapitalLetter() {
        #expect(TextCleanup.joinHyphenatedWords("Bielsko-\nBiała") == "Bielsko-\nBiała")
    }

    @Test func unwrapsLinesWithinParagraphButKeepsParagraphs() {
        let input = "Pierwsza linia\ndruga linia\n\nNowy akapit"
        #expect(TextCleanup.unwrapHardLineBreaks(input) == "Pierwsza linia druga linia\n\nNowy akapit")
    }

    @Test func respectsDisabledOptions() {
        let options = ConversionOptions(joinHyphenatedWords: false, unwrapHardLineBreaks: false)
        #expect(TextCleanup.apply(to: "kon-\nwersja", options: options) == "kon-\nwersja")
    }
}
