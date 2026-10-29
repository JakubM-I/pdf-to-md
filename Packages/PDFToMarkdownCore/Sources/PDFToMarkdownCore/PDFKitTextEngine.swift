import Foundation
import PDFKit

/// Pierwsza, najprostsza implementacja: tekst warstwy PDF przez PDFKit,
/// bez rozpoznawania struktury. Punkt odniesienia dla kolejnych silników.
public struct PDFKitTextEngine: ConversionEngine {
    public init() {}

    public func convert(_ fileURL: URL, options: ConversionOptions) async throws -> ConversionResult {
        guard let document = PDFDocument(url: fileURL) else {
            throw ConversionError.cannotOpenDocument(fileURL)
        }
        guard !document.isLocked else {
            throw ConversionError.documentIsLocked
        }

        let pages = (0..<document.pageCount).compactMap { document.page(at: $0)?.string }
        let markdown = pages
            .map { TextCleanup.apply(to: $0, options: options) }
            .joined(separator: "\n\n")

        return ConversionResult(markdown: markdown, pageCount: document.pageCount)
    }
}
