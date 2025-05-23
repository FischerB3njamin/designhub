# designhub

**designhub** ist eine moderne Social-Media-App auf Basis von Flutter, die speziell für Designer:innen und Kreative entwickelt wurde. Die App ermöglicht es, Designarbeiten zu veröffentlichen, Feedback zu erhalten, sich mit Gleichgesinnten zu vernetzen und bei kreativen Herausforderungen schnelle Hilfe aus der Community zu erhalten.

## Features

- Erstellen, Anzeigen und Löschen von Design-Posts mit Bild, Titel und Hashtags  
- Suchen von Posts und SOS-Anfragen (case-insensitive)  
- Speichern und Verwalten von Lieblingsdesigns  
- SOS-Posts zur schnellen Community-Hilfe veröffentlichen  
- 1:1-Chats bei SOS-Reaktionen starten  
- Benutzerprofile anzeigen und bearbeiten  
- Kuratierte Inhalte und News aus der Designwelt  
- Echtzeit-Aktualisierungen mit `Provider` und `ChangeNotifier`  
- Bild-Uploads via Firebase Storage  
- Datenspeicherung in Firebase Firestore  

## Technologiestack

- **Flutter & Dart**  
- **Firebase**: Auth, Firestore, Storage, Messaging  
- **State Management**: Provider  
- **UI & UX**: Google Fonts, PhotoView, Custom Widgets  
- **Image Handling**: cached_network_image, image_picker, flutter_image_compress  
- **Weitere Packages**: flutter_svg, app_settings, link_text  

## Installation & Testzugang

Es gibt keine öffentliche Live-Demo.  
Wenn du die App testen möchtest, kontaktiere mich gerne per E-Mail unter **blblamda@mail.de**.  
Ich lade dich dann zu **TestFlight (iOS)** oder zum **Android-Beta-Test** ein.

## Screenshots

Hier ein Einblick in die Benutzeroberfläche und Funktionen der App:

| Startseite | Design-Post | SOS-Funktion |
|------------|-------------|---------------|
| ![Home](assets/images/logo.png) | ![Post](assets/images/logo_text.png) | ![SOS](assets/images/screenshot_sos.png) |

## App Demo (Video)

Hier ein kurzer Einblick in das Nutzererlebnis von **designhub**:

- **Startseite & Feed**
  
  ![Home Video](assets/videos/demo_home.gif)

- **Neuen Post erstellen**
  
  ![Create Post](assets/videos/demo_create_post.gif)

- **SOS-Funktion & Chat**
  
  ![SOS](assets/videos/demo_sos_chat.gif)

> **Hinweis:** Die Videos sollten im Ordner `assets/videos/` liegen und idealerweise als optimierte `.gif` oder `.mp4` bereitgestellt werden. Markdown unterstützt direkt nur GIFs. Für `.mp4` kannst du alternativ einen Link zu einem Hosting-Dienst (z. B. GitHub Releases, Dropbox, Streamable) angeben:

[▶️ App-Demo als MP4 ansehen](https://yourhost.com/designhub-demo.mp4)