
# Card Organizer App

**Card Organizer App** is a Flutter mobile application that allows users to organize cards into folders based on suits (Hearts, Spades, Diamonds, Clubs). The app uses **SQLite** for local storage and supports **CRUD operations** for cards and folders.  

---

## Features

- **Four default folders**: Hearts, Spades, Diamonds, Clubs.  
- **Add cards** to folders (limit: 3–6 cards per folder).  
- **Delete cards** via long press.  
- **Dynamic display** of cards in a grid view.  
- **Uses SQLite** for storing folders and cards locally.  
- **Supports local images or online image URLs**.  

---

## Screens

1. **Home Screen**
   - Displays all folders.
   - Shows folder name.
   - Navigate to folder detail screen.  

2. **Folder Detail Screen**
   - Shows cards in a grid.
   - Add new card using "+" button.
   - Delete card via long press.
   - Enforces folder card limits (3–6 cards).  

---

## Project Structure

```
lib/
├─ db/
│  └─ database_helper.dart
├─ models/
│  ├─ folder_model.dart
│  └─ card_model.dart
├─ repositories/
│  ├─ folder_repository.dart
│  └─ card_repository.dart
├─ screens/
│  ├─ home_screen.dart
│  └─ folder_detail_screen.dart
└─ main.dart
assets/
├─ hearts/
├─ spades/
├─ diamonds/
└─ clubs/
pubspec.yaml
```

---

## Usage

- Tap a folder to see its cards.  
- Press `+` to add a new card.  
- Long press a card to delete it.    

---
