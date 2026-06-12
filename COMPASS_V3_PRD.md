# COMPASS V3 — OFFLINE-FIRST AI BANKING ENGAGEMENT PLATFORM
### Product Requirements Document (PRD)
### Optimized for: Google Antigravity Agentic IDE
### Version: 3.0 | Status: Hackathon Build

---

## AGENT INSTRUCTIONS

> **Read this section first before taking any action.**

This document is the single source of truth for the Compass V3 Flutter application. You are building a privacy-first, offline-first AI banking engagement platform for the SBI Hackathon (Pillar 03 — Digital Engagement).

### Ground Rules for the Agent

- **Tech stack is fixed.** Flutter + Riverpod + Isar + llama.cpp. Do not substitute or suggest alternatives unless explicitly asked.
- **Offline-first is non-negotiable.** Every feature must work without internet. Cloud (Gemini) is an optional enhancement layer, never a dependency.
- **Privacy is a hard constraint.** The AI layer (llama.cpp) must never receive raw financial data. All financial inputs must be converted to signals before reaching the AI. See the Signal Engine section.
- **One task at a time.** Complete one feature fully (models → business logic → UI → state) before starting the next.
- **Medium detail level.** Build to architecture and data model specs. Do not over-engineer. Do not under-build.
- **Ask before assuming.** If a spec is ambiguous, ask one clarifying question before proceeding.

### Recommended Build Order

```
1. Project scaffold + folder structure
2. Isar database + all collection models
3. Signal Engine (core privacy layer)
4. Riverpod state setup
5. Feature 1: Goal Coach
6. Feature 2: Financial Health Score
7. Feature 3: Compass Journey
8. Feature 4: Weekly Story
9. Feature 5: Smart Nudges
10. Feature 6: Life Event Engine
11. Feature 7: Insights Center
12. Feature 8: Explainable AI layer
13. Feature 9: Privacy Dashboard
14. Feature 10: Achievement System
15. UI polish + micro interactions
16. Offline mode demonstration flow
17. Hackathon demo flow wiring
```

---

## 1. PRODUCT OVERVIEW

### 1.1 What is Compass?

Compass is a privacy-first, offline-first AI financial engagement platform embedded inside a banking application. It is designed to solve the fundamental problem of modern banking apps: users open the app, check their balance, make a payment, and leave. There is no engagement. There is no relationship. There is no reason to return.

Compass fixes this by transforming the banking app into an active financial companion. Instead of being a passive ledger, the app becomes a proactive coach that tracks goals, detects life events, generates weekly financial stories, delivers smart nudges, and builds a visual journey of the user's financial growth — all without ever exposing sensitive financial data to any external system.

### 1.2 Core Value Proposition

| Traditional Banking App | Compass |
|---|---|
| Reactive — user must initiate | Proactive — app reaches out |
| Data display | Behavioral intelligence |
| No memory of user progress | Full financial journey tracking |
| Cloud-dependent | 100% offline capable |
| No AI coaching | Local AI coach on-device |
| No privacy guarantees | Sensitive data never leaves device |

### 1.3 Hackathon Positioning

**Problem Statement:** SBI Pillar 03 — Digital Engagement

**How Compass solves it:**
- Understands behavioral patterns through the Signal Engine
- Tracks financial trends without exposing raw transactions
- Detects life events (travel, education, housing, income changes)
- Generates proactive engagement via nudges, stories, and coaching
- Builds long-term financial relationships through goal and achievement systems

**Biggest differentiator vs. other hackathon teams:**

Most teams will build: `Cloud AI + Chatbot`

Compass builds: `Local AI + Offline Intelligence + Privacy-First Engagement`

**One-line pitch:**
> *"Compass is an offline-first AI financial engagement platform that uses on-device intelligence, behavioral signals, goal coaching, and life-event awareness to continuously engage users — while ensuring sensitive data never leaves their device."*

---

## 2. PRODUCT PHILOSOPHY

### 2.1 The Engagement Problem

```
Traditional Banking App Flow:
─────────────────────────────
User Opens App
      ↓
Checks Balance
      ↓
Makes Payment
      ↓
Leaves
(No reason to return)
```

```
Compass Flow:
─────────────────────────────
User Opens App
      ↓
Receives Personalized Insight
      ↓
Reviews Goal Progress
      ↓
Reads Weekly Financial Story
      ↓
Takes a Recommended Action
      ↓
Financial Health Improves
      ↓
Returns Regularly
(Habit formed)
```

### 2.2 The Core Engagement Loop

The entire product is designed around one repeating loop:

```
        ┌──────────────────────────────────────┐
        │                                      │
     GOAL ──→ PROGRESS ──→ INSIGHT ──→ ACTION  │
        ↑                                  ↓   │
      STORY ←── ACHIEVEMENT ←─────────────┘   │
        │                                      │
        └──────────────────────────────────────┘
```

Every feature in Compass exists to keep users inside this loop. The loop drives habit, and habit drives engagement.

---

## 3. OFFLINE-FIRST ARCHITECTURE

### 3.1 Offline Principle

**The application must remain fully functional without any internet connection.**

A user with zero network connectivity must be able to:
- View and create financial goals
- Receive AI-generated insights and nudges
- View their weekly financial story
- Browse their financial journey timeline
- Access and use all AI coaching features
- View their Financial Health Score
- Use the Privacy Dashboard

Internet connectivity is an enhancement, not a requirement.

### 3.2 Architecture Layers

```
┌─────────────────────────────────────┐
│           Flutter UI Layer          │
│  (Screens, Widgets, Animations)     │
├─────────────────────────────────────┤
│        Riverpod State Layer         │
│  (Providers, Notifiers, State)      │
├─────────────────────────────────────┤
│       Business Logic Layer          │
│  (Use Cases, Services, Validators)  │
├─────────────────────────────────────┤
│          Signal Engine              │
│  (Raw data → Privacy signals)       │
├─────────────────────────────────────┤
│      Local Database (Isar)          │
│  (Goals, Journey, Insights, etc.)   │
├─────────────────────────────────────┤
│      Local AI (llama.cpp)           │
│  (On-device inference, no network)  │
└─────────────────────────────────────┘
              ↕ Optional
┌─────────────────────────────────────┐
│      Gemini Enhancement Layer       │
│  (Cloud AI, only when user opts in) │
└─────────────────────────────────────┘
```

### 3.3 Flutter Project Folder Structure

```
lib/
├── main.dart
├── app/
│   ├── app.dart
│   └── router.dart                  # GoRouter setup
├── core/
│   ├── constants/
│   ├── theme/
│   ├── utils/
│   └── extensions/
├── data/
│   ├── database/
│   │   ├── isar_service.dart        # Isar initialization
│   │   └── collections/             # All Isar collection models
│   └── repositories/                # Data access layer
├── domain/
│   ├── models/                      # Pure Dart models
│   ├── services/
│   │   ├── signal_engine.dart       # Core privacy layer
│   │   ├── ai_service.dart          # llama.cpp bridge
│   │   └── gemini_service.dart      # Optional cloud layer
│   └── use_cases/                   # One file per use case
├── features/
│   ├── home/
│   ├── goals/
│   ├── journey/
│   ├── insights/
│   ├── weekly_story/
│   ├── health_score/
│   ├── achievements/
│   ├── privacy_dashboard/
│   └── profile/
└── providers/                       # All Riverpod providers
```

---

## 4. DATA STORAGE — ISAR DATABASE

### 4.1 Why Isar

Isar is the chosen database over SQLite or Hive because:
- Pure Flutter/Dart — no native code bridging complexity
- Extremely fast read/write for mobile (ACID compliant)
- Works entirely offline with no setup
- Supports complex queries with type safety
- Better suited for structured relational-style data than Hive

### 4.2 Collections (Data Models)

#### Collection: `UserProfile`
Stores the user's identity and preferences. Created once during onboarding.

| Field | Type | Description |
|---|---|---|
| `id` | int | Isar auto-generated ID |
| `userId` | String | Unique user identifier |
| `name` | String | Display name |
| `avatarPath` | String? | Local path to avatar image |
| `privacyLevel` | Enum | `standard`, `strict`, `custom` |
| `cloudEnhancementEnabled` | bool | Whether Gemini is opted in |
| `onboardingComplete` | bool | Tracks first-run state |
| `createdAt` | DateTime | Profile creation timestamp |

---

#### Collection: `Goal`
Stores each financial goal and its real-time progress state.

| Field | Type | Description |
|---|---|---|
| `id` | int | Isar auto-generated ID |
| `goalId` | String | UUID |
| `name` | String | e.g., "Emergency Fund", "Goa Trip" |
| `category` | Enum | `emergency`, `travel`, `education`, `vehicle`, `housing`, `custom` |
| `targetAmount` | double | Final target in ₹ |
| `currentProgress` | double | Amount saved so far |
| `milestonePercentages` | List\<int\> | e.g., `[25, 50, 75, 100]` |
| `milestonesReached` | List\<int\> | Milestones already celebrated |
| `isCompleted` | bool | Whether goal is achieved |
| `isPrimary` | bool | Whether shown prominently on Home |
| `createdAt` | DateTime | When goal was created |
| `completedAt` | DateTime? | When goal was marked complete |
| `aiLastCoachMessage` | String? | Last coaching message from local AI |

---

#### Collection: `JourneyEvent`
Stores significant financial life events. This is the journey timeline, not a transaction log.

| Field | Type | Description |
|---|---|---|
| `id` | int | Isar auto-generated ID |
| `eventId` | String | UUID |
| `eventType` | Enum | See Signal Types below |
| `title` | String | Human-readable title |
| `description` | String | Short explanation of the event |
| `iconKey` | String | Maps to a local icon asset |
| `timestamp` | DateTime | When event was recorded |
| `relatedGoalId` | String? | Foreign key if event ties to a goal |

---

#### Collection: `Insight`
Stores AI-generated insights, each attached to a signal source.

| Field | Type | Description |
|---|---|---|
| `id` | int | Isar auto-generated ID |
| `insightId` | String | UUID |
| `text` | String | The full insight text shown to user |
| `category` | Enum | `savings`, `goal`, `spending`, `health`, `life_event` |
| `confidenceScore` | double | 0.0–1.0, how confident AI is |
| `reasonText` | String | Explanation: why this insight was generated |
| `suggestedAction` | String | What the user should do next |
| `signalSource` | String | Which signal triggered this insight |
| `isRead` | bool | Whether user has seen it |
| `generatedAt` | DateTime | When insight was created |

---

#### Collection: `WeeklyStory`
Stores the generated weekly financial story.

| Field | Type | Description |
|---|---|---|
| `id` | int | Isar auto-generated ID |
| `storyId` | String | UUID |
| `weekStartDate` | DateTime | Monday of the story's week |
| `headline` | String | Main story title |
| `bodyText` | String | Full AI-generated story narrative |
| `summary` | String | 1–2 sentence TLDR |
| `healthScoreDelta` | int | Health score change this week |
| `topGoalProgress` | String | Best-performing goal this week |
| `streakInfo` | String | Streak highlight if any |
| `achievementHighlight` | String? | If an achievement was unlocked |
| `generatedAt` | DateTime | When story was created |

---

#### Collection: `Achievement`
Stores all earned badges, milestones, and streaks.

| Field | Type | Description |
|---|---|---|
| `id` | int | Isar auto-generated ID |
| `achievementId` | String | UUID |
| `type` | Enum | `badge`, `milestone`, `streak` |
| `key` | String | e.g., `goal_starter`, `30_day_streak` |
| `title` | String | Display name |
| `description` | String | What it means |
| `iconKey` | String | Local icon asset reference |
| `isUnlocked` | bool | Whether the user has earned it |
| `unlockedAt` | DateTime? | When it was earned |

---

#### Collection: `FinancialHealthSnapshot`
Stores weekly health score snapshots for trend tracking.

| Field | Type | Description |
|---|---|---|
| `id` | int | Isar auto-generated ID |
| `snapshotId` | String | UUID |
| `score` | int | 0–100 composite score |
| `savingsSubScore` | int | Sub-score for savings behavior |
| `consistencySubScore` | int | Sub-score for payment consistency |
| `goalSubScore` | int | Sub-score for goal progress |
| `spendingSubScore` | int | Sub-score for spending patterns |
| `stabilitySubScore` | int | Sub-score for financial stability |
| `aiExplanation` | String | Why the score is what it is |
| `aiImprovementTip` | String | What the user can do to improve |
| `recordedAt` | DateTime | When snapshot was taken |

---

## 5. AI ARCHITECTURE

### 5.1 Primary AI — llama.cpp (On-Device)

The on-device AI engine powers all core intelligence features. It runs locally using the llama.cpp Flutter plugin and requires no internet.

**Responsibilities:**
- Generating goal coaching messages and encouragement
- Producing weekly financial story narratives
- Writing smart nudge copy
- Explaining financial health score changes
- Generating insights from signals
- Summarizing journey timeline events

**All inference happens locally. No data leaves the device.**

#### Recommended Local Models

| Model | Size | Speed | Quality | Use Case |
|---|---|---|---|---|
| TinyLlama 1.1B | ~700MB | Fastest | Basic | MVP / demo builds |
| **Phi-3 Mini 3.8B** | ~2.2GB | Balanced | Good | **Recommended default** |
| Gemma 2B | ~1.4GB | Medium | Good reasoning | Alternative |

**Default model: Phi-3 Mini.** Best balance of speed, quality, and size for a hackathon demo on a mid-range Android device.

### 5.2 Secondary AI — Gemini (Optional Cloud Enhancement)

Gemini is activated only when:
1. The device has an active internet connection
2. The user has explicitly enabled "Cloud Enhancement" in Settings

**Gemini is used for:**
- Deep financial pattern analysis across longer timeframes
- Long-form financial coaching and planning
- Advanced life event interpretation

**Everything else — including all demo-critical features — runs on llama.cpp locally.**

### 5.3 AI Prompt Design Principles

All prompts sent to the local AI must follow these rules:

1. **Never include amounts, balances, or transaction data.** Use signals only.
2. **Keep prompts short and focused.** One output per prompt. No multi-task prompts.
3. **Always specify the output format.** e.g., "Respond in 2 sentences. Be positive and encouraging."
4. **Include the user's first name** for personalization.
5. **Reference the signal, not the raw data.** e.g., "The user's savings consistency has improved this month" not "The user saved ₹8,000."

---

## 6. THE SIGNAL ENGINE

### 6.1 What It Is

The Signal Engine is the privacy core of Compass. It sits between the raw financial data layer and the AI layer. Its job is to translate sensitive financial information into abstract behavioral signals before anything reaches the AI.

**The AI never sees:**
- Transaction amounts
- Account balances
- Specific merchant names
- Payment dates or bill amounts

**The AI only sees:**
- Behavioral patterns
- Trend directions
- Goal states
- Life event categories

### 6.2 Signal Translation Examples

| Raw Financial Data (NEVER sent to AI) | Abstracted Signal (Sent to AI) |
|---|---|
| "Salary credited ₹58,000 on 1st June" | `income_pattern_detected` |
| "Spent ₹14,500 on food this month" | `food_spending_trend_increased` |
| "Account balance ₹1,20,000" | `savings_consistency_improved` |
| "Missed EMI payment" | `bill_due_unmet` |
| "Booked flight tickets" | `travel_event_detected` |
| "College fee payment made" | `education_event_detected` |

### 6.3 Supported Signal Types

```dart
enum SignalType {
  income_pattern,          // Regular income behavior detected
  goal_progress,           // A goal has made measurable progress
  goal_completed,          // A goal has reached 100%
  travel_event,            // Travel-related spending pattern detected
  education_event,         // Education-related payment detected
  housing_event,           // Housing/rent-related payment detected
  savings_improved,        // Month-over-month savings increased
  spending_increased,      // Spending trend is rising
  spending_decreased,      // Spending trend is falling
  health_score_changed,    // Financial health score moved significantly
  streak_created,          // User has started a new behavioral streak
  streak_broken,           // An existing streak was interrupted
  bill_due,                // A recurring bill is approaching due date
  achievement_unlocked,    // User earned a new badge or milestone
}
```

### 6.4 Signal Engine Flow

```
Raw Financial Data
       ↓
[Signal Engine]
       ↓
  Privacy Check  ──→  If raw data detected → STRIP & ABSTRACT
       ↓
Signal Object Created
  { type, timestamp, context: "abstract only" }
       ↓
Stored in Isar
       ↓
AI Receives Signal (never raw data)
       ↓
AI Generates Response
```

---

## 7. FEATURE SPECIFICATIONS

### Feature 1: Goal Coach

**Purpose:** Keep users emotionally engaged with their financial goals through continuous AI coaching.

**Supported Goal Categories:**
- Emergency Fund
- Travel Goal
- Vehicle Goal (Bike / Car)
- Education Goal
- Home / Housing Goal
- Custom Goal (user-defined)

**What the AI Coach Does:**

| Trigger | AI Action |
|---|---|
| Goal created | Welcome message + first step suggestion |
| Progress milestone reached (25/50/75%) | Celebration + encouragement |
| Goal completed | Achievement celebration + next goal suggestion |
| No progress for 7 days | Gentle nudge + re-engagement message |
| Setback detected (progress decreased) | Empathetic explanation + recovery plan |

**Riverpod State:**
- `GoalListNotifier` — manages list of all goals
- `ActiveGoalCoachNotifier` — manages current coaching session for a goal
- `GoalProgressNotifier` — tracks real-time progress per goal

---

### Feature 2: Financial Health Score

**Purpose:** Give users a single, understandable number that represents their overall financial wellness.

**Scoring Formula (Composite — 100 points):**

| Dimension | Weight | What It Measures |
|---|---|---|
| Savings Rate | 25pts | Month-over-month savings growth |
| Consistency | 20pts | Regular payment and savings behavior |
| Goal Progress | 25pts | Active goal advancement |
| Spending Control | 15pts | Spending trend direction |
| Stability | 15pts | Absence of financial stress signals |

**Output Format:**
```
84 / 100
Good Standing
▲ +5 This Month
```

**AI Explanation Layer:**
Every score change triggers three AI-generated explanations:
1. "Why did my score change?" — cause analysis
2. "What helped / hurt my score?" — factor breakdown
3. "How can I improve?" — actionable next steps

---

### Feature 3: Compass Journey

**Purpose:** Build a visual, emotionally resonant timeline of the user's financial growth. This is not a transaction history — it is a personal financial story.

**Journey Event Types:**

| Event Key | Display Title | Icon |
|---|---|---|
| `goal_created` | New Goal Started | 🎯 |
| `goal_milestone` | Milestone Reached | ⭐ |
| `goal_completed` | Goal Achieved! | 🏆 |
| `achievement_unlocked` | Achievement Earned | 🏅 |
| `savings_improved` | Savings on the Rise | 📈 |
| `travel_event` | Travel Journey Planned | ✈️ |
| `weekly_story_generated` | Weekly Story Ready | 📖 |
| `health_score_improved` | Health Score Improved | 💚 |
| `streak_created` | New Streak Started | 🔥 |

**UI:** Vertical scrollable timeline. Most recent events at top. Each card shows title, description, timestamp, and icon. Tappable to expand for AI context.

---

### Feature 4: Weekly Financial Story *(Hero Feature)*

**Purpose:** Create a Spotify Wrapped-style weekly recap that makes users excited to open the app every Monday.

**Generation Trigger:** Every Monday, automatically generate a new story using last week's signal data.

**Story Structure:**

```
┌─────────────────────────────────┐
│  YOUR WEEK IN REVIEW            │
│  Week of June 9 – June 15       │
├─────────────────────────────────┤
│  Financial Health   ▲ +3        │
│  Travel Goal        ▲ +8%       │
│  Savings Streak     ✓ Maintained│
│  Achievement        🏅 Unlocked  │
├─────────────────────────────────┤
│  [AI-Generated narrative text]  │
│  2–3 paragraph personal story   │
│  written by on-device AI        │
└─────────────────────────────────┘
```

**Tone:** Personal, warm, celebratory. Not corporate. Not data-heavy. Think Duolingo recap, not bank statement.

**Offline:** Story is generated using signals from the local Isar database. Phi-3 Mini writes the narrative. No internet required.

---

### Feature 5: Smart Nudges

**Purpose:** Deliver timely, positive micro-messages that guide users toward better financial behavior.

**Nudge Examples:**

```
"You're ahead of pace on your Travel Goal. Keep it up!"
"50% milestone reached — you're halfway there!"
"Only one milestone left on your Emergency Fund."
"Your financial health score improved this week."
"You've maintained your savings streak for 14 days."
"Your Bike Goal needs a little attention this week."
```

**Nudge Rules:**
- Always positive or constructive in tone
- Maximum 20 words
- One clear action or acknowledgment per nudge
- Never mention specific amounts
- Delivered via local notification or in-app banner

**Delivery Triggers:**
- Goal milestone reached
- Streak milestone (7 days, 14 days, 30 days)
- Health score change
- Weekly story generated
- Goal approaching deadline
- No app open in 3 days (re-engagement)

---

### Feature 6: Life Event Engine

**Purpose:** Detect significant life moments from behavioral signals and surface them meaningfully in the journey and coaching layers.

**Detectable Life Events:**

| Event | Detection Signal | Response |
|---|---|---|
| Travel planning | `travel_event` signal | Add journey event + offer travel goal coaching |
| Income change | `income_pattern` shift | Update health score + congratulate or coach |
| Goal achievement | `goal_completed` | Unlock achievement + generate story highlight |
| Savings milestone | `savings_improved` streak | Add journey event + suggest next goal |
| Education payment | `education_event` | Add journey event + offer education goal |
| Housing payment | `housing_event` | Add journey event + offer housing goal |

**Privacy Rule:** Life events are detected from abstract signals only. Raw transaction data is never stored or exposed in event records.

---

### Feature 7: Insights Center

**Purpose:** A centralized hub where users can browse all AI-generated insights, events, recommendations, and health trends.

**Tabs / Sections:**
1. **Insights** — AI-generated behavioral observations
2. **Events** — Recent life events detected
3. **Recommendations** — Actionable suggestions
4. **Achievements** — Recent badges and milestones
5. **Health Trends** — Score over time chart

**Each Insight Card Must Show:**
- Insight text (main content)
- Confidence indicator (low / medium / high)
- Reason ("Why am I seeing this?")
- Suggested action ("What should I do?")
- Category tag (savings / goals / spending / health)

---

### Feature 8: Explainable AI

**Purpose:** Every single AI output in Compass must be explainable. The user should never receive an AI result without understanding where it came from.

**The Three Explainability Questions — answered for every AI result:**

| Question | Example Answer |
|---|---|
| Why am I seeing this? | "Your savings consistency improved for 3 weeks in a row." |
| What caused this? | "You made regular savings transfers every week this month." |
| What should I do next? | "Consider increasing your Emergency Fund contribution by a small amount." |

**Implementation:** Every `Insight`, `WeeklyStory`, `HealthSnapshot`, and coaching message has an associated `reasonText` and `suggestedAction` field in the Isar model. These are populated at generation time and displayed in the UI.

---

### Feature 9: Privacy Dashboard

**Purpose:** Build user trust by being radically transparent about what Compass can and cannot access.

**What Compass CAN Access:**
- User's financial goals and progress
- User's stated preferences and categories
- Behavioral signals (abstract patterns only)
- Achievement and streak state

**What Compass CANNOT Access (ever):**
- PIN, password, MPIN
- CVV, card number
- OTP codes
- Account credentials
- Specific transaction amounts (these are converted to signals and discarded)

**UI:** Two-panel layout. Left: "Compass Can See" with green checkmarks. Right: "Compass Never Sees" with red X marks. Simple, scannable, reassuring.

---

### Feature 10: Achievement System

**Purpose:** Gamify financial progress to drive habit formation and return visits.

**Achievement Categories:**

| Category | Examples |
|---|---|
| Goal Milestones | Goal Starter, 50% Milestone, Goal Champion |
| Streaks | 7 Day Streak, 30 Day Streak, Consistency King |
| Savings | First Saver, Consistent Saver, Savings Superstar |
| Engagement | Story Reader, Journey Explorer |

**Achievement Unlock Flow:**
1. Signal triggers achievement check
2. Achievement condition evaluated
3. If met: `isUnlocked = true`, `unlockedAt` set in Isar
4. Journey event created: `achievement_unlocked`
5. Celebration animation triggered in UI
6. Smart nudge generated

---

## 8. UI/UX SPECIFICATIONS

### 8.1 Design Principles

- **Clean and minimal.** No information overload. One primary action per screen.
- **Trustworthy.** Looks like a serious financial product, not a gamified toy.
- **Premium.** Dark theme preferred. High contrast. Sharp typography.
- **Warm.** Despite being a banking app, language and micro-copy should feel human.

### 8.2 Screen Inventory

| # | Screen | Primary Purpose |
|---|---|---|
| 1 | Splash | Brand intro |
| 2 | Onboarding | Name, first goal, privacy level setup |
| 3 | Home | Primary goal + insight + quick access |
| 4 | Goals | All goals list + create new |
| 5 | Journey | Timeline of financial events |
| 6 | Insights | Insights center (all tabs) |
| 7 | Weekly Story | Full story view |
| 8 | Financial Health | Score breakdown + trends |
| 9 | Privacy Dashboard | Trust transparency screen |
| 10 | Profile | Settings, preferences, cloud toggle |

### 8.3 Home Screen Layout Order

```
1. Greeting (name + time-of-day)
2. Primary Goal Card (progress + AI coaching message)
3. Compass Insight Card (today's AI insight)
4. Weekly Story Banner (tap to read)
5. Financial Health Score (compact view)
6. Quick Actions Row
7. Recent Achievements
8. Recent Journey Events (last 3)
```

### 8.4 Bottom Navigation

```
[Home]  [Goals]  [Journey]  [Insights]  [Profile]
```

### 8.5 Required Micro-Interactions

Every one of these must be implemented — they are demo differentiators:

| Interaction | Trigger |
|---|---|
| Milestone celebration | Goal reaches 25 / 50 / 75 / 100% |
| Achievement unlock animation | New badge earned |
| Card expand animation | Any card tapped |
| Progress bar animation | Goal progress updated |
| Health score counter animation | Score screen opened |
| Weekly story reveal animation | Story card opened |
| Page transition animation | Navigation between screens |
| Pull-to-refresh | Any scrollable list |
| Haptic feedback | All primary CTA button taps |

---

## 9. HACKATHON DEMO FLOW

This is the exact flow that must work flawlessly during the demo presentation. Build and test this flow end to end before finalizing the app.

```
Step 1:  User opens app → Splash → Home screen
Step 2:  Primary Goal is shown with progress + AI coaching message
Step 3:  Compass Insight card is visible — tap to expand and see reason + action
Step 4:  Weekly Story banner — tap to open full story (AI-generated narrative)
Step 5:  Financial Health Score — show score + AI explanation
Step 6:  Navigate to Journey — scroll through timeline events
Step 7:  Trigger achievement unlock animation (either live or via demo seed data)
Step 8:  Open Privacy Dashboard — explain "never sees" column
Step 9:  Open an Insight — show Explainable AI fields (why / what / next)
Step 10: Turn off internet → demonstrate ALL features still work (offline proof)
```

**Demo Seed Data:** Preload the following to make the demo visually rich:
- 2 active goals (one at 65%, one at 30%)
- 1 completed goal
- 8+ journey events
- 3 insights (1 savings, 1 goal, 1 health)
- 1 weekly story (current week)
- Health score: 82/100 (+4 this week)
- 3 achievements unlocked
- 1 active streak: 14 days

---

## 10. ANTIGRAVITY WORKFLOW REFERENCES

> Store these as `.agent/workflows/` files for reuse across build sessions.

### Suggested Workflow Files

```
.agent/workflows/
├── 01-scaffold-project.md
├── 02-isar-collections.md
├── 03-signal-engine.md
├── 04-riverpod-setup.md
├── 05-goal-coach-feature.md
├── 06-health-score-feature.md
├── 07-journey-feature.md
├── 08-weekly-story-feature.md
├── 09-smart-nudges.md
├── 10-insights-center.md
├── 11-achievements.md
├── 12-privacy-dashboard.md
├── 13-micro-interactions.md
├── 14-demo-seed-data.md
└── 15-offline-demo-flow.md
```

### `.antigravity-rules` Suggested Content

```
# Compass V3 — Agent Rules

stack: Flutter + Riverpod + Isar + llama.cpp
theme: dark, premium banking
ai_model: phi3_mini (local), gemini (optional)

rules:
- Never use SQLite. Always use Isar.
- Never pass raw financial data to AI. Use signals only.
- All features must work offline. No feature may require network.
- Use GoRouter for navigation.
- Use Riverpod (code generation) for all state.
- One provider file per feature.
- All Isar collections in lib/data/database/collections/
- All signals defined in lib/domain/services/signal_engine.dart
- Complete one feature fully before starting next.
- Ask before creating new packages not listed in PRD.
```

---

*Document Version: 3.0*
*Platform: Google Antigravity (Gemini 3.5 Flash)*
*Build Target: Flutter 3.x, Android (Play Store Ready)*
*Hackathon: SBI — Pillar 03 Digital Engagement*
