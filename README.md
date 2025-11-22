## To repozytorium zawiera dokumentację również w języku polskim, która znajduje się poniżej.

# EN / GoGymSync – Shared Training Session Module

This module is responsible for handling shared training sessions in the GoGymSync / GoGymSimple application.
It allows creating sessions, joining users, and sharing data in real-time.

# 🚀 Features

## Training Sessions
	•	Creating a session with a unique code.
	•	Users can join sessions.
	•	Roles: host and participant.
	•	Real-time monitoring of session status.

## Lobby
	•	Displaying online users.
	•	Live updates.
	•	Host can start the session.

## Notes
	•	Add, edit, and delete notes.
	•	Instant synchronization among all participants.

## Session Ending
	•	Host can end the session.
	•	Automatic removal of session, users, and notes.

# 📋 Requirements

## Functional Requirements
	1.	Creating a training session
	
		•	Users can create a new training session.
		•	The system generates a unique session code.
		•	The session creator becomes the host.

	2.	Joining a session
	
		•	Users can join an existing session using its code.
		•	The system verifies that the session exists.
		•	New users are assigned the participant role.

	3.	Session Lobby
	
		•	Displays a live list of users.
		•	Shows user roles (host, participant).
		•	Updates session status (waiting, active, ended) in real time.

	4.	Session Management
	
		•	Host can start or end the session.
		•	Ending the session deletes all session data and subcollections (users, notes).

	5.	Shared Notes
	
		•	Participants can add notes.
		•	Participants can edit and delete their own notes.
		•	Notes synchronize in real-time for all participants.

	6.	Real-Time Synchronization
	
		•	All data (lobby, notes, session status) is synchronized live via Firebase Firestore.

## Non-Functional Requirements
	1.	Scalability
	
		•	Modular architecture (Clean Architecture).
		•	Ability to swap Data Source (e.g., local or REST API).

	2.	Testability
	
		•	DataSource and Repository abstractions allow unit testing.
		•	Business logic separated from UI.

	3.	Performance
	
		•	Efficient use of Firestore snapshots.
		•	Minimal resource usage for real-time updates.

	4.	Security
	
		•	Data protected by Firestore Security Rules.
		•	firebase_options.dart ignored in the repository.

	5.	Usability
	
		•	Responsive and simple UI.
		•	Intuitive control over roles and session status.

	6.	Portability
	
		•	App runs on Android, iOS, Web, Windows, macOS (Flutter).

# 🧩 Architecture

The project follows Clean Architecture (Layer First):

<img width="407" height="430" alt="Image" src="https://github.com/user-attachments/assets/cb63525f-d317-4d80-914d-698d5ffa13bb" />

## presentation → domain → data
	•	data – Firebase Remote Data Source + repository implementations
	•	domain – use cases + entities + repository abstractions
	•	presentation – pages, controllers, UI logic
	•	core – dependency injection, theme, tools (e.g., session code generator)

# 🔧 Technologies
	•	Flutter
	•	Firebase Firestore
	•	GetIt (DI)
	•	Streams (real-time updates)

# 📡 Future Plans
	•	Share session results via QR code / link
	•	Chat in the lobby
	•	Integration with user training plans
	•	Trainer–participant mode
	•	Statistics and analytics after the session

**────────────────────────**

# PL / GoGymSync – moduł wspólnych sesji treningowych

Moduł odpowiedzialny za obsługę wspólnej sesji treningowej w aplikacji GoGymSync / GoGymSimple.
Pozwala tworzyć sesje, dołączać użytkowników i współdzielić informacje w czasie rzeczywistym.

# 🚀 Funkcje

## Sesje treningowe
	•	Tworzenie sesji z unikalnym kodem.
	•	Dołączanie użytkowników.
	•	Role: host i participant.
	•	Monitorowanie statusu sesji na żywo.

## Lobby
	•	Lista użytkowników online.
	•	Aktualizacja w czasie rzeczywistym.
	•	Start sesji przez hosta.

## Notatki
	•	Dodawanie, edytowanie i usuwanie notatek.
	•	Natychmiastowa synchronizacja między uczestnikami.

## Zakończenie sesji
	•	Możliwość zakończenia przez hosta.
	•	Automatyczne usunięcie sesji + użytkowników + notatek.

# 📋 Wymagania

## Wymagania funkcjonalne (Functional Requirements)
	1.	Tworzenie sesji treningowej
	
		•	Użytkownik może utworzyć nową sesję treningową.
		•	System generuje unikalny kod sesji.
		•	Twórca sesji otrzymuje rolę host.
      
	2.	Dołączanie do sesji
	
		•	Użytkownik może dołączyć do istniejącej sesji podając kod.
		•	System weryfikuje istnienie sesji.
		•	Nowi użytkownicy otrzymują rolę participant.
      
	3.	Lobby sesji
	
		•	Wyświetlanie listy użytkowników w czasie rzeczywistym.
		•	Pokazywanie ról (host, participant).
		•	Aktualizacja statusu sesji (waiting, active, ended).
      
	4.	Zarządzanie sesją
	
		•	Host może rozpocząć lub zakończyć sesję.
		•	Po zakończeniu sesji usuwa się cała sesja i wszystkie podkolekcje (użytkownicy, notatki).
      
	5.	Notatki współdzielone
	
		•	Uczestnicy mogą dodawać notatki.
		•	Uczestnicy mogą edytować i usuwać własne notatki.
		•	Notatki synchronizują się w czasie rzeczywistym dla wszystkich uczestników.
      
	6.	Realtime Synchronization
	
		•	Wszystkie dane (lobby, notatki, status sesji) są synchronizowane na żywo dzięki Firebase Firestore.

## Wymagania niefunkcjonalne (Non-Functional Requirements)
	1.	Skalowalność
	
		•	Architektura modularna (Clean Architecture).
		•	Możliwość podmiany Data Source (np. lokalne lub REST API).
      
	2.	Testowalność
	
		•	Abstrakcje DataSource i Repository umożliwiają testy jednostkowe.
		•	Logika biznesowa oddzielona od UI.
      
	3.	Wydajność
	
		•	Efektywne użycie snapshotów Firestore.
		•	Minimalne zużycie zasobów przy aktualizacji w czasie rzeczywistym.
      
	4.	Bezpieczeństwo
	
		•	Dane chronione regułami Firestore Security Rules.
		•	firebase_options.dart ignorowany w repozytorium.
      
	5.	Użyteczność
	
		•	UI responsywne i proste w obsłudze.
		•	Intuicyjne sterowanie rolami i statusami sesji.
      
	6.	Portowalność
	
		•	Aplikacja działa na Android, iOS, Web, Windows, macOS (Flutter).

# 🧩 Architektura

Projekt oparty jest o Clean Architecture (Layer First): 

<img width="407" height="430" alt="Image" src="https://github.com/user-attachments/assets/cb63525f-d317-4d80-914d-698d5ffa13bb" />

## presentation  →  domain  →  data
	•	data – Firebase Remote Data Source + implementacje repo
	•	domain – use case’y + encje + abstrakcje repo
	•	presentation – strony, kontrolery, UI logic
	•	core – DI, theme, narzędzia (generator kodów sesji)

# 🔧 Technologie
	•	Flutter
	•	Firebase Firestore
	•	GetIt (DI)
	•	Streamy (real-time updates)
	
# 📡 Plany rozwoju
	•	Udostępnianie wyników sesji (QR / link)
	•	Chat w lobby
	•	Integracja z treningami użytkowników
	•	Tryb trener–uczestnicy
	•	Statystyki i analizy po sesji
