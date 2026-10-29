import Foundation

/// Czyste funkcje porządkujące surowy tekst wyciągnięty z PDF.
public enum TextCleanup {
    public static func apply(to text: String, options: ConversionOptions) -> String {
        var result = text.replacingOccurrences(of: "\r\n", with: "\n")
        if options.joinHyphenatedWords {
            result = joinHyphenatedWords(result)
        }
        if options.unwrapHardLineBreaks {
            result = unwrapHardLineBreaks(result)
        }
        return result.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    /// "kon-\nwersja" → "konwersja". Działa tylko, gdy po łączniku następuje mała litera.
    public static func joinHyphenatedWords(_ text: String) -> String {
        text.replacing(/(\p{L})-\n(\p{Ll})/) { "\($0.1)\($0.2)" }
    }

    /// Pojedyncze złamania linii zamienia na spację; puste linie (granice akapitów) zostają.
    public static func unwrapHardLineBreaks(_ text: String) -> String {
        text
            .split(separator: /\n[ \t]*\n/)
            .map { paragraph in
                paragraph
                    .split(separator: "\n")
                    .map { $0.trimmingCharacters(in: .whitespaces) }
                    .joined(separator: " ")
            }
            .joined(separator: "\n\n")
    }
}
