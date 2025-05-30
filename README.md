# 🧬 DNA Analyse app

# Introduction

This application is developed using Flutter as the programming language and Supabase as the database. However, neither Gemini nor Supabase APIs are actively used. Instead, it simulates real data through a locally prepared JSON file and displays it using the FutureBuilder widget.

The app is compatible with iOS, Android, macOS, and Chrome platforms.
It supports dynamic app icon switching on Apple devices and includes both light and dark theme modes.

With l10n (localization) integration, the app supports English and Turkish languages.

The core functionality of the app revolves around providing personalized genetic health analysis, nutritional and fitness insights, and AI-powered health recommendations based on user input.

⸻

# ✨Features

## 🧠 Dashboard
- Displays a summary of user’s general health, including:
- Genetic analysis results
- Health risk ratios
- Cardiovascular, neurological, metabolic, and immune system risk assessments

## 📑 DNA Analysis Report
- During registration, users enter:
- DNA sequence
- Full name, age, weight, height
- Current medications, medical history
- Blood type and gender
- These inputs are used to generate a comprehensive DNA analysis report.

## 🤖 AI Chat (Gemini Integration)
- A built-in AI chat page allows users to ask questions.
- Responses are provided via Gemini (simulated, no real-time API).

## 🧬 Genetic Profile
Displays:
- DNA overview and raw genetic data
- Traits like taste perception, circadian rhythm, color vision, muscle strength, pain sensitivity, and immune system data

## 🧪 Health Risk Profile
Provides:
- Risk ratio visualization
- Genetic risk factors
- A detailed Radar Chart (Spider Web Graph) visualizing key health metrics such as:
- Body Mass Index (BMI)
- Sleep Quality
- Blood Pressure
- Blood Sugar
- Cholesterol

## 🥗 Nutrition Profile
Highlights:
	•	Personalized metabolism type and rate
	•	Custom diet plans and health recommendations
	•	Detailed vitamin and mineral analysis
	•	Suggestions for weight loss or gain
	•	Preventive health tips

## 💪 Fitness Profile
	•	Displays user’s:
	•	Muscle strength, endurance, flexibility
	•	Fitness goals with recommended training programs
	•	Muscle fiber composition analysis for custom exercise planning

## 💊 Medication Suggestions
	•	Post-analysis:
	•	Suggests relevant medications or precautions
	•	Tapping on a medication opens AI-powered descriptions of its use and details

## ⏰ Medication Tracking Page
	•	Lists all suggested medications
	•	Includes:
	•	Medication time
	•	Notes
	•	Reminders
	•	Users can also manually add new medications as needed

## Preview

<p>
<img src="assets/Preview/image1.jpeg" width="270"/> <img src="assets/Preview/image2.jpeg" width="270"/>
<img src="assets/Preview/image3.jpeg" width="270"/> <img src="assets/Preview/image4.jpeg" width="270"/>
<img src="assets/Preview/image5.jpeg" width="270"/> <img src="assets/Preview/image6.jpeg" width="280"/>
</p>

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

