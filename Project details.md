Compass — Privacy-First YONO-Style Banking App with AI Layer

1) Product Vision

Compass is a privacy-first mobile banking experience inspired by the YONO SBI app UI/UX pattern, but rebuilt as a hackathon prototype with a new AI engagement layer on top. The app should feel like a realistic banking clone, while demonstrating how an AI companion can improve digital engagement without exposing sensitive financial data.

The product is designed for the SBI hackathon track: Pillar 03 — Digital Engagement

Core Idea

Instead of making AI read raw banking data, Compass converts banking activity into privacy-safe behavioral signals and uses those signals to generate proactive engagement, guidance, and financial wellness nudges.


---

2) Product Goals

Primary Goals

Build a YONO-style banking app clone in Flutter.

Add a Compass AI layer that improves customer engagement.

Keep the system privacy-first by design.

Use Firebase as the backend for auth, database, storage, and analytics-like event tracking.

Use Gemini or Grok for AI reasoning and content generation.


Hackathon Goals

Show a believable banking UI.

Show AI that is proactive, not just chat-based.

Show life-event awareness, goal tracking, and financial nudges.

Demonstrate that the AI layer could be integrated into an existing YONO ecosystem.



---

3) Product Positioning

What this app is

A mobile app clone of the YONO-style banking interface.

A bank-ready AI engagement layer.

A prototype that demonstrates future integration with an existing banking app.


What this app is not

Not a real banking app.

Not a payment processing system.

Not a live transaction app.

Not a KYC or onboarding production platform.

Not a full YONO replacement.



---

4) Privacy Principles

Privacy is the most important design constraint.

Non-Negotiable Rules

AI never receives raw account numbers.

AI never receives exact balances.

AI never receives full transaction descriptions.

AI never receives card numbers, CVV, PIN, or sensitive secrets.

AI never receives exact salary values unless the user explicitly enables it.

AI works on signals, categories, patterns, and events.


Examples of Privacy-Safe Signals

income_event_detected

spending_up_in_food_category

bill_due_soon

goal_progress_increasing

travel_event_detected

savings_consistency_improved


Privacy Control Levels

Level 1: Minimal

Only generic wellness and trend signals.

Level 2: Standard

Category-level insights.

Level 3: Personalized

More detailed personalization, but still no raw sensitive exposure.


---

5) Final Feature Set

These are the features to build for the hackathon. They are ordered from most important to least important.

Feature 1: Compass Home Insight Card

A hero card on the home screen that shows one privacy-safe AI insight.

Purpose

This is the first AI touchpoint in the app.

Example Insights

Your savings consistency has improved recently.

A travel-related event was detected.

Your spending pattern changed this month.

You are making steady progress toward your goal.


Privacy Rule

Never show:

exact salary

exact balance

exact transaction amount


Why it matters

This is the simplest and strongest way to prove digital engagement.


---

Feature 2: Financial Health Score

A simple score that summarizes the user's financial behavior.

Sections

Savings

Spending

Goals

Consistency

Financial stability


Example

Financial Health: 84/100

Trend: Improved by 5 points this month


AI Explanation

The AI explains the score in plain language, based on safe signals.

Why it matters

This gives the app a clear reason to exist beyond a generic banking UI.


---

Feature 3: Life Event Detection

The app detects life events from safe behavioral patterns.

Supported Events

First salary pattern

Travel pattern

Marriage-related pattern

Home purchase pattern

New baby pattern

Education-related pattern

Overspending pattern

Goal progress pattern


Example

Instead of saying:

You booked a flight to Goa for ₹8,420


Say:

A travel-related event was detected


Why it matters

This is the most hackathon-relevant feature for Digital Engagement.


---

Feature 4: Goal Coach

A goal tracking module with AI nudges.

Example Goals

Emergency fund

Trip fund

Bike purchase

Higher education

Family support fund


AI Behavior

tracks progress

suggests savings nudges

gives reminders

shows milestone progress


Why it matters

It creates long-term engagement.


---

Feature 5: Agent Timeline

A chronological activity feed showing what the AI has noticed and done.

Example Timeline

Income pattern detected

Savings suggestion generated

Travel event identified

Budget recommendation prepared

Goal review completed


Why it matters

This makes the system feel like an agent, not a chatbot.


---

Feature 6: Personalized Recommendations Feed

A feed of AI-generated suggestions.

Example Recommendations

Build emergency fund

Reduce spending in food category

Set up bill reminders

Increase monthly savings target

Review unused subscriptions


AI Explanation

Each recommendation must include a short “why this was suggested” note.


---

Feature 7: Explainable AI Chat

A limited chat surface for clarification.

Purpose

Not a general chatbot. Only for explaining insights.

Allowed Prompts

Why am I seeing this?

How is my score calculated?

How can I improve this goal?

Why was this recommendation shown?


Not Allowed

Sensitive account queries

unsupported banking operations

raw data disclosure



---

Feature 8: Privacy Control Center

A settings screen where users control AI depth.

Controls

insight detail level

personalization level

event tracking permission

goal tracking permission

chat explanation mode


Why it matters

This is the strongest privacy-first differentiator.


---

6) App Structure

The app should feel like a modern banking app with familiar navigation.

Bottom Navigation

Home

Compass

Goals

Timeline

Profile


Alternative Naming

If you want a more YONO-like structure, use:

Home

AI

Goals

Activity

Profile



---

7) Screen List

Screen 1: Splash Screen

App logo

subtle loading animation

privacy-first branding text


Screen 2: Onboarding

welcome message

privacy explanation

choose personalization level

demo consent toggle


Screen 3: Home Dashboard

account summary placeholders

Compass Insight Card

quick actions

goal progress preview


Screen 4: Compass Dashboard

AI insights feed

financial health score

recommended actions

event highlights


Screen 5: Life Events Screen

event cards

event detail view

recommended next action


Screen 6: Goals Screen

goals list

progress bars

AI suggestions

milestone badges


Screen 7: Agent Timeline

chronological activity feed

expandable cards

explainable AI notes


Screen 8: Recommendations Screen

suggestion cards

reason labels

dismiss/save actions


Screen 9: AI Explain Chat

limited question-and-answer mode

privacy-safe explanations only


Screen 10: Privacy Control Center

personalization options

data visibility toggles

consent management



---

8) UI Direction

Design Style

Clean banking UI

premium but simple

white background with deep blue accents

soft cards

rounded corners

clear hierarchy

minimal clutter

professional typography


Visual Pattern

balance cards

insight cards

progress chips

trend indicators

icon-led cards

subtle animations


Important UI Note

This should look like a realistic banking app clone, but not an exact copy of proprietary YONO assets.


---

9) Flutter Architecture

Suggested Project Structure

lib/
  main.dart
    app.dart
      core/
          theme/
              constants/
                  utils/
                      privacy/
                        features/
                            auth/
                                onboarding/
                                    home/
                                        compass/
                                            goals/
                                                timeline/
                                                    recommendations/
                                                        chat/
                                                            profile/
                                                              models/
                                                                services/
                                                                  widgets/

                                                                  Recommended State Management

                                                                  Choose one:

                                                                  Riverpod

                                                                  Provider

                                                                  Bloc


                                                                  For a hackathon, Riverpod is a strong choice because it stays clean and scalable.


                                                                  ---

                                                                  10) Firebase Architecture

                                                                  Firebase Services to Use

                                                                  Firebase Authentication

                                                                  Cloud Firestore

                                                                  Firebase Storage

                                                                  Firebase Cloud Functions

                                                                  Firebase Analytics-like event logs (only if needed for prototype)


                                                                  Firestore Collections

                                                                  users

                                                                  name

                                                                  email

                                                                  personalizationLevel

                                                                  privacySettings

                                                                  createdAt


                                                                  financialSignals

                                                                  userId

                                                                  signalType

                                                                  category

                                                                  severity

                                                                  timestamp


                                                                  goals

                                                                  userId

                                                                  goalName

                                                                  targetPercent

                                                                  progressPercent

                                                                  status


                                                                  events

                                                                  userId

                                                                  eventType

                                                                  title

                                                                  descriptionSafe

                                                                  timestamp


                                                                  recommendations

                                                                  userId

                                                                  title

                                                                  reason

                                                                  actionLabel

                                                                  status


                                                                  timeline

                                                                  userId

                                                                  eventType

                                                                  message

                                                                  createdAt


                                                                  aiSessions

                                                                  userId

                                                                  promptType

                                                                  responseType

                                                                  privacyLevel



                                                                  ---

                                                                  11) AI Design

                                                                  AI Responsibilities

                                                                  The AI should:

                                                                  generate insight text

                                                                  explain recommendations

                                                                  summarize safe patterns

                                                                  classify life events

                                                                  produce next-best-action suggestions

                                                                  maintain a continuous engagement narrative


                                                                  AI Must Not Do

                                                                  directly expose raw banking data

                                                                  directly return private transaction details

                                                                  request secrets

                                                                  perform real money movement


                                                                  AI Input Format

                                                                  Use structured safe signals like:

                                                                  {
                                                                        "signal": "spending_up_in_food_category",
                                                                          "privacyLevel": "standard",
                                                                            "goalProgress": 72,
                                                                              "event": "travel_detected"
                                                                  }

                                                                  AI Output Format

                                                                  {
                                                                        "insight": "Food-related spending is higher than usual this month.",
                                                                          "recommendation": "Set a weekly spending limit.",
                                                                            "reason": "This can help maintain your savings target.",
                                                                              "confidence": 0.84
                                                                  }


                                                                  ---

                                                                  12) Demo Data Strategy

                                                                  Since this is a hackathon prototype, create realistic mock data.

                                                                  Demo Scenarios

                                                                  1. Salary-type income pattern detected


                                                                  2. Travel event detected


                                                                  3. Spending spike in food category


                                                                  4. Goal progress rising slowly


                                                                  5. Bill due soon


                                                                  6. Savings consistency improving



                                                                  Demo User Profiles

                                                                  Student

                                                                  Salaried employee

                                                                  Young professional

                                                                  Family user


                                                                  This makes the UI more believable.


                                                                  ---

                                                                  13) Key User Journeys

                                                                  Journey 1: Home Open

                                                                  User opens app

                                                                  sees Compass Insight Card

                                                                  taps it

                                                                  views reason and suggested action


                                                                  Journey 2: Life Event

                                                                  AI detects travel event

                                                                  user sees event card

                                                                  app suggests guidance and next steps


                                                                  Journey 3: Goal Tracking

                                                                  user creates a goal

                                                                  AI monitors progress

                                                                  AI gives nudges when pace is slow


                                                                  Journey 4: Privacy Settings

                                                                  user adjusts personalization level

                                                                  AI response depth changes accordingly



                                                                  ---

                                                                  14) Hackathon MVP Scope

                                                                  Must Build

                                                                  Flutter banking-style UI

                                                                  Home Dashboard

                                                                  Compass Insight Card

                                                                  Goals screen

                                                                  Timeline screen

                                                                  AI-generated insight cards

                                                                  Firebase auth + Firestore

                                                                  Privacy settings


                                                                  Good to Have

                                                                  Explainable AI chat

                                                                  recommendation feed

                                                                  subtle animations

                                                                  charts


                                                                  Avoid for MVP

                                                                  real payments

                                                                  real UPI integration

                                                                  real bank login

                                                                  card management

                                                                  loan processing

                                                                  live financial connections



                                                                  ---

                                                                  15) Suggested AI Flow

                                                                  Step 1

                                                                  A backend function receives a safe signal.

                                                                  Step 2

                                                                  The signal is mapped into a privacy-safe prompt.

                                                                  Step 3

                                                                  Gemini or Grok generates insight text.

                                                                  Step 4

                                                                  The result is stored in Firestore.

                                                                  Step 5

                                                                  The Flutter app fetches and displays the insight.


                                                                  ---

                                                                  16) Suggested Prompt Style for AI

                                                                  Use prompts like:

                                                                  > You are Compass, a privacy-first banking engagement agent. Generate a short, helpful, plain-language insight from the following safe behavioral signal. Do not expose any raw transaction details, exact balances, account numbers, or sensitive private values. Keep the response concise, friendly, and banking-professional.




                                                                  ---

                                                                  17) Build Order

                                                                  Phase 1

                                                                  set up Flutter project

                                                                  theme and navigation

                                                                  onboarding

                                                                  home dashboard UI


                                                                  Phase 2

                                                                  Compass insight card

                                                                  goals module

                                                                  timeline UI

                                                                  recommendation cards


                                                                  Phase 3

                                                                  Firebase auth

                                                                  Firestore schema

                                                                  mock data integration

                                                                  privacy settings screen


                                                                  Phase 4

                                                                  AI integration via cloud functions

                                                                  generated insights

                                                                  explainable chat

                                                                  final polish



                                                                  ---

                                                                  18) Final Hackathon Story

                                                                  Compass is a privacy-first AI engagement layer for a banking app. Instead of exposing raw financial data to AI, Compass converts activity into safe signals and uses them to deliver proactive, explainable, and personalized customer engagement. It feels like an intelligent YONO-style banking experience, but designed with trust and privacy at the center.


                                                                  ---

                                                                  19) Locked Decisions So Far

                                                                  Project name: Compass

                                                                  Focus: Digital Engagement

                                                                  App style: YONO-style banking clone

                                                                  Platform: Flutter mobile app

                                                                  Backend: Firebase

                                                                  AI: Gemini or Grok

                                                                  Privacy principle: no raw sensitive data to AI



                                                                  ---

                                                                  20) Next Build Step

                                                                  Implement the app in this order:

                                                                  1. Home screen and navigation


                                                                  2. Compass Insight Card


                                                                  3. Goals screen


                                                                  4. Timeline screen


                                                                  5. Privacy settings


                                                                  6. Firebase backend


                                                                  7. AI response flow


                                                                  
                                                                  }
                                                                  }