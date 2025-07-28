# Koch App

Dies ist ein Flutter-Projekt für eine plattformübergreifende Koch-App für Android und iOS.

## Erste Schritte

Dieses Projekt dient als Ausgangspunkt für eine Flutter-Anwendung.

### Voraussetzungen

Um dieses Projekt zu kompilieren und auszuführen, benötigen Sie:
- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- Einen konfigurierten Editor (wie [Android Studio](https://developer.android.com/studio) oder [Visual Studio Code](https://code.visualstudio.com/))

### Installation

1. **Klonen Sie das Repository:**
   ```bash
   git clone <URL_DES_REPOSITORIES>
   cd koch_app
   ```

2. **Installieren Sie die Abhängigkeiten:**
   ```bash
   flutter pub get
   ```

3. **Führen Sie die App aus:**
   Öffnen Sie einen Emulator oder schließen Sie ein physisches Gerät an und führen Sie dann den folgenden Befehl aus:
   ```bash
   flutter run
   ```

## Nächste Schritte (Firebase-Integration)

Die aktuelle Version verwendet statische Beispieldaten. Um eine dynamische Datenspeicherung zu ermöglichen, müssen Sie Firebase in Ihr Projekt integrieren.

1. **Erstellen Sie ein Firebase-Projekt:**
   - Gehen Sie zur [Firebase-Konsole](https://console.firebase.google.com/).
   - Erstellen Sie ein neues Projekt.

2. **Fügen Sie Firebase zu Ihrer App hinzu:**
   - Folgen Sie den Anweisungen in der Firebase-Konsole, um Ihre Android- und iOS-Apps zu registrieren.
   - Laden Sie die Konfigurationsdateien `google-services.json` (für Android) und `GoogleService-Info.plist` (für iOS) herunter und platzieren Sie sie in den entsprechenden Verzeichnissen.

3. **Fügen Sie die Firebase-Abhängigkeiten hinzu:**
   - Fügen Sie die folgenden Pakete zu Ihrer `pubspec.yaml`-Datei hinzu:
     ```yaml
     dependencies:
       firebase_core: ^2.1.0
       cloud_firestore: ^4.0.0
       firebase_auth: ^4.0.0
     ```
   - Führen Sie `flutter pub get` erneut aus.

4. **Initialisieren Sie Firebase:**
   - Aktualisieren Sie Ihre `lib/main.dart`-Datei, um Firebase zu initialisieren, bevor die App ausgeführt wird:
     ```dart
     import 'package:firebase_core/firebase_core.dart';

     void main() async {
       WidgetsFlutterBinding.ensureInitialized();
       await Firebase.initializeApp();
       runApp(const MyApp());
     }
     ```

Nach diesen Schritten können Sie `cloud_firestore` verwenden, um Ihre Rezepte in der Cloud zu speichern und abzurufen.
