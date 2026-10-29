import PDFToMarkdownCore
import SwiftUI
import UniformTypeIdentifiers

/// Tymczasowy ekran: wybór pliku i podgląd wyniku.
/// Docelowy wygląd powstanie na podstawie projektów z MagicPath (zob. design/).
struct ContentView: View {
    @State private var markdown = ""
    @State private var errorMessage: String?
    @State private var isImporterPresented = false
    @State private var isConverting = false

    private let engine: any ConversionEngine = PDFKitTextEngine()

    var body: some View {
        Group {
            if markdown.isEmpty {
                ContentUnavailableView {
                    Label("Brak dokumentu", systemImage: "doc.richtext")
                } description: {
                    Text(errorMessage ?? "Wybierz plik PDF, aby zamienić go na Markdown.")
                } actions: {
                    Button("Wybierz PDF…") { isImporterPresented = true }
                        .disabled(isConverting)
                }
            } else {
                ScrollView {
                    Text(markdown)
                        .font(.body.monospaced())
                        .textSelection(.enabled)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                }
            }
        }
        .toolbar {
            Button("Otwórz", systemImage: "folder") { isImporterPresented = true }
        }
        .fileImporter(isPresented: $isImporterPresented, allowedContentTypes: [.pdf]) { result in
            guard case .success(let url) = result else { return }
            Task { await convert(url) }
        }
    }

    private func convert(_ url: URL) async {
        isConverting = true
        defer { isConverting = false }

        let didAccess = url.startAccessingSecurityScopedResource()
        defer { if didAccess { url.stopAccessingSecurityScopedResource() } }

        do {
            markdown = try await engine.convert(url, options: ConversionOptions()).markdown
            errorMessage = nil
        } catch {
            markdown = ""
            errorMessage = "Nie udało się przekonwertować pliku: \(error.localizedDescription)"
        }
    }
}

#Preview {
    ContentView()
}
