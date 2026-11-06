<div align="center">

# 🎓 Quiz App

### A modern, dual-app quiz platform built with Flutter & Firebase

[![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev/)
[![Firebase](https://img.shields.io/badge/firebase-%23039BE5.svg?style=for-the-badge&logo=firebase)](https://firebase.google.com/)
[![Firestore](https://img.shields.io/badge/Firestore-%23FFCA28.svg?style=for-the-badge&logo=firebase&logoColor=black)](https://firebase.google.com/docs/firestore)
[![Android](https://img.shields.io/badge/Android-3DDC84?style=for-the-badge&logo=android&logoColor=white)](https://www.android.com/)
[![iOS](https://img.shields.io/badge/iOS-000000?style=for-the-badge&logo=ios&logoColor=white)](https://www.apple.com/ios/)

A robust ecosystem for creating, taking, and evaluating quizzes — with a clean
student experience and powerful administrator tooling.

</div>

---

> [!IMPORTANT]
> **🚧 Project Status: Work in Progress.**
> This project is **not yet complete**. The **Results module** has not been finished, so quiz result calculation, scoring, and performance analytics are still under development. Some screens and features shown below may be partial or subject to change.

---

## **Introduction**

The **Quiz App** is a robust, dual-application ecosystem designed to streamline the process of quiz creation, management, and evaluation. Built with **Flutter** and **Firebase**, it provides a seamless experience for both administrators and students. The project is split into two main components:

1. **Quiz Student**: A public-facing mobile application for students to participate in quizzes and track their progress.
2. **Quiz Admin**: A private, high-level management tool for administrators to design quizzes and analyze results.

---

## **Features**

### **🎓 Quiz Student (Public)**
*   **Secure Authentication**: Full login, signup, and email verification flow powered by Firebase Auth.
*   **Code-Based Access**: Students join specific quizzes using unique, admin-generated codes.
*   **Interactive Quiz Engine**: A clean, distraction-free interface for taking quizzes with real-time progress tracking.
*   **Performance Analytics** *(in progress)*: Post-quiz results with answer breakdowns — the results module is not yet complete.
*   **Account Management**: Secure password reset and profile management features.

### **🛠️ Quiz Admin (Private)**
*   **Dynamic Quiz Builder**: Intuitive interface for creating complex quizzes with multiple question types.
*   **Centralized Dashboard**: Quick access to all management tools, including quiz history and real-time results.
*   **Advanced Analytics**: View and analyze student performance across all quizzes.
*   **Database Integration**: Real-time synchronization with Cloud Firestore for instant updates.

---

## **Screenshots**

### 🎓 Quiz Student App

| Login | Create Account | Verify Email |
|:---:|:---:|:---:|
| <img src="images/SLogin.png" width="220" /> | <img src="images/SCreateAccount.png" width="220" /> | <img src="images/SVerification.png" width="220" /> |
| *Sign in securely* | *Register a new account* | *Email verification* |

| Student Dashboard | Join Quiz by Code | Taking a Quiz |
|:---:|:---:|:---:|
| <img src="images/StudentDashboard.png" width="220" /> | <img src="images/enterquizcode.png" width="220" /> | <img src="images/Squestion2.png" width="220" /> |
| *Overview of available quizzes* | *Enter an admin-generated code* | *Answer questions in real time* |

| Quiz Results |
|:---:|
| <img src="images/STestresult.png" width="220" /> |
| *Results screen (module in progress)* |

### 🛠️ Quiz Admin App

| Admin Dashboard | Create a New Quiz | Quiz History |
|:---:|:---:|:---:|
| <img src="images/AdminDashboard.png" width="220" /> | <img src="images/createnewquiz.png" width="220" /> | <img src="images/Quizhistory.png" width="220" /> |
| *Centralized management hub* | *Build quizzes with multiple questions* | *Browse and review past quizzes* |

> **Note:** All screenshots live in the [images/](images/) folder.

---

## **Tech Stack**

| Layer | Technology |
|:---|:---|
| **Framework** | Flutter (Dart) |
| **Authentication** | Firebase Auth (Email, Google Sign-In) |
| **Database** | Cloud Firestore (real-time sync) |
| **Platforms** | Android, iOS, Web, macOS, Windows, Linux |

---

## **The Process**

Building this project involved several key stages:

1. **Requirement Analysis**: Identifying the distinct needs of students (ease of use) vs. admins (powerful tools).
2. **Architectural Design**: Deciding on a dual-app structure sharing a unified Firebase backend for data consistency.
3. **UI/UX Development**: Creating a minimalist yet functional design using Flutter's Material Design components.
4. **Backend Integration**: Implementing Firebase Authentication for security and Firestore for real-time data management.

### **Challenges & Learning**
*   **Real-time Synchronization**: Managing state across multiple devices during a live quiz.
*   **Security Rules**: Configuring Firestore security rules to ensure students can only access quizzes they are authorized for.
*   **Deep Linking**: (Future Improvement) Implementing deep links for even faster quiz access.

---

## **Room for Improvement**
*   [ ] **Complete the Results Module**: Finish end-to-end result calculation, scoring, and reporting.
*   [ ] **Leaderboards**: Implement a competitive ranking system for students.
*   [ ] **Multimedia Questions**: Support for images and videos within quiz questions.
*   [ ] **Offline Mode**: Enable quiz taking without a stable internet connection using local caching.
*   [ ] **Export Results**: Add functionality to export student performance data to CSV/PDF.

---

## **Setup Instructions**

### **Prerequisites**
*   [Flutter SDK](https://docs.flutter.dev/get-started/install) installed on your machine.
*   A [Firebase Project](https://console.firebase.google.com/) set up.

### **Installation**

1. **Clone the repository:**
    ```bash
    git clone https://github.com/CoderShaji/QuizApp.git
    cd QuizApp
    ```

2. **Setup Quiz Student:**
    ```bash
    cd quiz_student
    flutter pub get
    ```

3. **Firebase Configuration:**
    *   Add your `google-services.json` (for Android) and `GoogleService-Info.plist` (for iOS) to the respective directories in `quiz_student`.

4. **Run the application:**
    ```bash
    flutter run
    ```

---

<div align="center">

Made with ❤️ using Flutter & Firebase

</div>
