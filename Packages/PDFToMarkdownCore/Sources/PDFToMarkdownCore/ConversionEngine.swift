import Foundation

/// Silnik zamieniający dokument PDF na Markdown.
///
/// Aplikacja zna tylko ten protokół, więc implementację (PDFKit, Vision,
/// Foundation Models albo zewnętrzny proces) można wymienić bez zmian w UI.
public protocol ConversionEngine: Sendable {
    func convert(_ fileURL: URL, options: ConversionOptions) async throws -> ConversionResult
}

public struct ConversionOptions: Sendable, Equatable {
    /// Łączenie wyrazów przeniesionych łącznikiem na końcu linii ("kon-\nwersja").
    public var joinHyphenatedWords: Bool
    /// Zamiana twardych złamań linii wewnątrz akapitu na spacje.
    public var unwrapHardLineBreaks: Bool

    public init(joinHyphenatedWords: Bool = true, unwrapHardLineBreaks: Bool = true) {
        self.joinHyphenatedWords = joinHyphenatedWords
        self.unwrapHardLineBreaks = unwrapHardLineBreaks
    }
}

public struct ConversionResult: Sendable, Equatable {
    public var markdown: String
    public var pageCount: Int

    public init(markdown: String, pageCount: Int) {
        self.markdown = markdown
        self.pageCount = pageCount
    }
}

public enum ConversionError: Error, Equatable {
    case cannotOpenDocument(URL)
    case documentIsLocked
}
