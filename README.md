# Voice Medication Coach

Voice Medication Coach is a comprehensive Flutter application designed to empower users in managing their medication schedules, tracking their mood, and interacting with an intelligent AI assistant for health-related queries. It serves as a personal health companion, offering robust features for medication adherence, progress visualization, and personalized guidance to ensure optimal well-being.

## Key Features & Pages

The application is structured around several key screens, each serving a distinct purpose to provide a seamless user experience:

*   **`SplashScreen`**: The initial screen displayed upon launching the application, handling any necessary setup or loading before the main content is presented.
*   **`OnboardingScreen`**: Guides new users through the application's core features, benefits, and initial setup, ensuring a smooth start.
*   **`HomeScreen`**: The central dashboard providing users with an overview of their medication schedule, upcoming reminders, and quick access to other primary features.
*   **`MyMedicationsScreen`**: Displays a comprehensive list of all medications the user is currently prescribed or has recorded within the application.
*   **`AddEditMedicationScreen`**: Facilitates the process of adding new medications or modifying details of existing ones, including dosage, frequency, and specific instructions.
*   **`RemindersScreen`**: Manages and presents all medication reminders, allowing users to set custom alerts and notifications to ensure timely medication intake.
*   **`MoodTrackerScreen`**: Enables users to log and track their mood over time, providing insights into their emotional well-being and its correlation with medication adherence.
*   **`SummaryChartScreen`**: Visualizes medication adherence, mood trends, and other health metrics through intuitive charts and graphs, helping users understand their progress.
*   **`AssistantChatScreen`**: Offers an interactive interface where users can communicate with an AI assistant to ask health-related questions, seek advice, or get information about their medications.
*   **`GuidelinesScreen`**: Provides valuable information, best practices, and health guidelines related to medication usage and general well-being.
*   **`ProfileScreen`**: Allows users to view and update their personal information, health details, and application preferences.
*   **`SettingsScreen`**: Contains various application settings and configurations, enabling users to customize their experience, manage notifications, and more.

## Getting Started

Follow these simple steps to set up and run the Voice Medication Coach application on your local machine.

### Prerequisites

*   **Flutter SDK**: Ensure you have Flutter installed. If not, please follow the instructions on the [official Flutter website](https://flutter.dev/docs/get-started/install) to set it up for your operating system.

### Installation

1.  **Clone the Repository**:
    Open your terminal or command prompt and clone the project repository using Git:
    ```bash
    git clone https://github.com/hetviipatel/Voice_Medi_Coach.git
    ```
2.  **Navigate to the Project Directory**:
    Change your current directory to the cloned project folder:
    ```bash
    cd voice_medication_coach
    ```
3.  **Install Dependencies**:
    Fetch all the necessary Dart and Flutter packages by running:
    ```bash
    flutter pub get
    ```

### Running the Application

1.  **Connect a Device or Start an Emulator/Simulator**:
    Make sure you have an Android emulator, iOS simulator, or a physical device connected and recognized by Flutter. You can check connected devices with:
    ```bash
    flutter devices
    ```
2.  **Run the Application**:
    Once a device is ready, run the application using the following command:
    ```bash
    flutter run
    ```
    This will build and launch the application on your selected device or emulator.
