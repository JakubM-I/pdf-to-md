Konwersja PDF do Markdown to obecnie jeden z najpopularniejszych tematów w środowiskach związanych z RAG (Retrieval-Augmented Generation), bazami wiedzy (Obsidian, Logseq, Notion) oraz pracą z dokumentacją techniczną i naukową.  
PDF z założenia jest formatem graficznym (współrzędne elementów na stronie), a nie semantycznym, przez co odtworzenie struktury Markdown wiąże się ze specyficznymi wyzwaniami.

### **Czego użytkownikom najbardziej brakuje i na co narzekają**

Dyskusje na forach technicznych (m.in. Reddit: r/ObsidianMD, r/Rag, r/LocalLLaMA, GitHub) wskazują na zestaw powtarzających się problemów:

#### **1\. Rozpadające się tabele (najczęstszy ból)**

> * **Złożone komórki:** Markdown obsługuje wyłącznie proste, prostokątne siatki. Narzędzia gubią się przy scalonych komórkach (*rowspan*, *colspan*), wielowierszowych opisach wewnątrz jednej kratki oraz tabelach bez widocznych obramowań.  
> * **Brak elastyczności wyjścia:** Użytkownicy często wolą, aby skomplikowana tabela została wygenerowana jako HTML \<table\> lub wyciągnięta jako surowy JSON/CSV, zamiast być na siłę spłaszczana do uszkodzonego Markdowna.

#### **2\. Kolejność czytania w układach wielokolumnowych**

> * Standardowe konwertery (oparte na prostym parsowaniu tekstu) często czytają PDF od lewej do prawej poziomo przez całą szerokość strony, łącząc sąsiadujące akapity z dwóch różnych kolumn w jeden bełkotliwy ciąg tekstu.

#### **3\. Zaśmiecanie tekstu powtarzalnymi nagłówkami i stopkami**

> * Powtarzające się na każdej stronie numery stron, tytuły rozdziałów, data czy metadane dokumentu trafiają w środek Markdowna – często przerywając zdanie lub akapit w połowie. Konwertery rzadko potrafią inteligentnie je wycinać.

#### **4\. Hard-wrapy i przenoszenie wyrazów (dzielenie słów)**

> * W PDF każda linijka wizualna często kończy się znakiem nowej linii, a długie słowa są dzielone łącznikiem (np. kon- / wersja). Wiele narzędzi przenosi te twarde entery bezpośrednio do Markdowna, co niszczy płynność akapitu w czytnikach.

#### **5\. Nieprawidłowa obsługa obrazów i wykresów**

> * **Pliki base64 vs katalog zasobów:** Użytkownicy narzekają na narzędzia wstrzykujące wyekstrahowane grafiki jako gigantyczne ciągi znaków Base64 wprost do pliku .md. Psuje to wydajność edytorów, rozdyma pliki tekstowe i uniemożliwia lokalne przeszukiwanie notatek. Standardem, którego brakuje, jest automatyczny eksport do podkatalogu (np. \_assets/) i czyste linkowanie relatywne.  
> * **Brak rozpoznawania wykresów:** Zwykły zrzut ekranu wykresu jest mało przydatny dla LLM – brakuje automatycznego generowania opisów alternatywnych (*alt-text*) lub konwersji do formatu Mermaid.js.

#### **6\. Wzory matematyczne (LaTeX)**

> W dokumentach naukowych wzory bywają traktowane jako zwykły tekst (rozpadają się na losowe symbole Unicode) lub jako bitmapy. Użytkownicy oczekują czystego rozpoznawania równań do formatu LaTeX ($...$ i   
> $$...$$

> * ).

#### **7\. Błędna hierarchia nagłówków**

> * Ponieważ PDF nie zawiera znaczników \<h1-h6\>, narzędzia estymują nagłówki na podstawie wielkości fontu. Efekt: wytłuszczone zdanie w tekście bywa oznaczane jako \#\#, a właściwy podrozdział ląduje jako zwykły tekst.

#### **8\. Dylemat: Prywatność vs Koszt i Sprzęt**

> * **Chmura (LLM):** Narzędzia oparte na API (np. LlamaParse, Mistral OCR, Claude) radzą sobie ze strukturą najlepiej, ale rodzą obawy o prywatność (wrażliwe dane firmowe, umowy, finanse) oraz generują wysokie koszty przy setkach stron.  
> * **Narzędzia lokalne:** Zaawansowane rozwiązania open-source (np. Marker, MinerU) wymagają mocnego GPU z kilkoma/kilkunastoma GB VRAM i skomplikowanego środowiska Python/CUDA, z kolei lekkie narzędzia na CPU często dają zbyt prymitywne rezultaty.

### **Na co użytkownicy zwracają uwagę przy wyborze**

| Kryterium | Oczekiwania użytkowników |
| :---- | :---- |
| **Zachowanie struktury** | Prawidłowe rozpoznanie 2 kolumn, przypisów dolnych (\[^1\]), tabel i list zagnieżdżonych. |
| **Model działania** | 100% offline/lokalnie (bezpieczeństwo danych) vs API w chmurze (maksymalna precyzja bez obciążania własnego PC). |
| **Jakość OCR** | Bezproblemowe radzenie sobie ze skanami niskiej jakości, starym drukiem i pismem odręcznym. |
| **Prędkość i zużycie zasobów** | Czas przetwarzania pliku 100-stronicowego oraz czy narzędzie nie wymaga 16 GB VRAM. |
| **Czystość kodu wynikowego** | Brak zbędnych znaczników HTML tam, gdzie wystarczy standardowy Markdown (CommonMark / GFM). |
| **Integracja z ekosystemem** | Gotowość pliku do wrzucenia do Obsidian, bazy wektorowej RAG czy Notion bez ręcznego czyszczenia. |

### **Czołowe narzędzia używane obecnie**

> 1. **Nowoczesne narzędzia lokalne (Layout-Aware / AI):**  
   * **Docling (od IBM):** Jeden z najszybciej zyskujących popularność projektów open-source; świetnie radzi sobie ze strukturą, tabelami i układem stron.  
   * **Marker / MinerU:** Wyspecjalizowane w dokumentach akademickich, formułach matematycznych (LaTeX) i zaawansowanym OCR układu wielokolumnowego.  
   * **MarkItDown (od Microsoft):** Lekkie narzędzie pythonowe do konwersji wielu formatów (w tym PDF) do Markdown, dobre do prostszych zadań bez używania ciężkich modeli wizyjnych.  
> 2. **Zaawansowane usługi chmurowe i modele Vision:**  
   * **Mistral OCR:** Dedykowany model OCR wypuszczony przez Mistral AI; uważany obecnie przez wielu za referencyjny pod kątem precyzji odwzorowania formatowania i wzorów.  
   * **LlamaParse (od LlamaIndex):** Parser w chmurze zoptymalizowany ściśle pod RAG i tabele.  
   * **Bezpośrednie Vision LLM (Gemini 2.5 Flash, Claude Sonnet):** Przesyłanie stron jako obrazów z promptem wymuszającym wyplucie czystego Markdowna.  
> 3. **Klasyczne narzędzia CLI / Regułowe:**  
   * **Pandoc \+ pdftotext / Poppler:** Bardzo szybkie, ale radzą sobie dobrze jedynie z prostym tekstem jednokolumnowym pozbawionym skomplikowanych tabel.