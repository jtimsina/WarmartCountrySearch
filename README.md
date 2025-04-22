# WarmartCountrySearch

**WarmartCountrySearch** is an iOS application built using Swift and the MVVM architecture. The app fetches a list of countries from a remote API and allows users to view and filter them in a clean, user-friendly interface.

## Features

- Fetch country list from a REST API
- MVVM architectural pattern
- Reusable networking layer
- Error handling and loading feedback
- Unit and UI testing support

## Project Structure

- `Models/` – Contains data models like `Country.swift`
- `ViewModels/` – Business logic and data formatting (`CountryViewModel.swift`)
- `Networking/` – Networking layer (`NetworkManager.swift`, `APIEndpoints.swift`, `NetworkError.swift`)
- `Base.lproj/` – Storyboards including `Main.storyboard` and `LaunchScreen.storyboard`
- `Assets.xcassets/` – App icon and color assets
- `WarmartCountrySearchTests/` – Unit tests and mock data for country API
- `WarmartCountrySearchUITests/` – UI test cases

## Getting Started

### Prerequisites

- Xcode 14 or later
- iOS 15.0+ target

### Setup

1. Clone the repository or unzip the project
2. Open `WarmartCountrySearch.xcodeproj` in Xcode
3. Run the app on the simulator or device

### Testing

- Unit tests: Located in `WarmartCountrySearchTests`
- UI tests: Located in `WarmartCountrySearchUITests`

Run tests using the Xcode test navigator (`⌘ + U`).

## screenshots and recording


https://github.com/user-attachments/assets/f4ee5162-afb4-4172-bf18-a471ab85e08f

![Simulator Screenshot - iPhone 16 Pro - 2025-04-22 at 10 07 52](https://github.com/user-attachments/assets/219bb69f-45b1-42b5-91c6-d23e2fc211fa)
![Simulator Screenshot - iPhone 16 Pro - 2025-04-22 at 10 07 44](https://github.com/user-attachments/assets/6fd1e396-0902-4774-af4f-c83478731cac)

