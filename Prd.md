# Sooubh AI â€” Product Requirements Document (PRD)

**Product Name:** Sooubh AI
**Version:** 1.0 â€” MVP (Hackathon Build)
**Prepared By:** Sourabh Singh
**Platform:** Flutter Mobile + Flutter Web
**Target Hackathon:** SBI Hackathon
**Document Status:** Draft â€” Pre-Build

---

## 1. Executive Summary

Sooubh AI is an **agentic engagement layer** built on top of YONO SBI. It does not replace the existing banking app â€” it wraps around it and makes it feel intelligent, proactive, and personalized. The core problem it solves is low digital adoption: most users open a banking app for one task and leave. Sooubh AI changes this by guiding users toward the next best action, surfacing unexplored features, and building financial habits through AI-driven nudges and insights.

The MVP targets three SBI hackathon pillars: **Customer Acquisition**, **Digital Adoption**, and **Digital Engagement**.

---

## 2. Problem Statement

### Current Behavior Pattern

Most banking app users follow this rigid loop:

1. Open app
2. Check balance or send money
3. Pay a bill (occasionally)
4. Close app

### Root Causes

- The app shows tools, but provides no direction on which tool to use next
- Users are unaware of features like UPI setup, KYC completion, SIPs, or debit card controls
- There is no personalized feedback loop â€” nothing tells a user they're improving or falling behind
- No emotional connection â€” goals, achievements, and financial health are invisible
- The first-time onboarding doesn't guide users to activate important services

### The Consequence

High churn rate post-install, low feature discovery, poor digital adoption, and low lifetime engagement per user.

---

## 3. Product Vision

> **YONO SBI gives banking tools. Sooubh AI makes users actually discover and use them.**

| Dimension | YONO SBI (Today) | Sooubh AI (Layer Added) |
|---|---|---|
| Nature | Transactional | Intelligent + Proactive |
| User Interaction | Reactive (user searches) | Proactive (AI suggests) |
| Feedback | Balance numbers | Financial Health Score |
| Onboarding | Static screens | AI-guided step-by-step journey |
| Discovery | Manual navigation | AI-driven feature nudges |
| Engagement | Transaction-based | Goal, mission, and story-based |

---

## 4. Hackathon Problem Fit

### 4.1 Customer Acquisition
Sooubh AI positions SBI as a smarter, more modern bank. New users get a personalized first impression through an AI-guided onboarding journey that reduces setup friction and builds immediate trust.

### 4.2 Digital Adoption
The app guides users through critical first-time actions:
- Enable UPI
- Complete KYC
- Set up account security
- Create a savings goal
- Explore investment services
- Activate dormant services

### 4.3 Digital Engagement
The app uses behavioral and emotional engagement loops to keep users coming back:
- Weekly Story summaries
- Financial Health Score with improvement tracking
- Goal progress notifications
- Personalized AI recommendations
- Mission-based discovery challenges

---

## 5. Core Principles

These principles govern every design and product decision in Sooubh AI:

1. **Layer, not replace** â€” The familiar banking structure stays intact. Sooubh AI adds a smart surface on top.
2. **Trust first** â€” Every interaction must feel safe, institutional, and polished. No playfulness that undermines credibility.
3. **Short and clear** â€” All AI-generated text must be brief. No paragraph-length suggestions. One action at a time.
4. **Context-aware** â€” The AI should behave differently based on what the user has and hasn't done, never suggesting irrelevant actions.
5. **Visually calm but intelligent** â€” The home screen must feel alive without feeling noisy. Clear hierarchy, consistent spacing, controlled information density.

---

## 6. Target Users

### Primary User: Existing SBI Customer (Digital-Ready)
- Has YONO SBI installed
- Uses it mainly for balance and transfers
- Has not explored savings tools, investments, or insurance
- Responds to personalized nudges and goal-setting
- Age: 22â€“42 | Income: Lower-middle to upper-middle class

### Secondary User: New SBI Account Holder
- Just opened an SBI account
- Has not completed full digital setup
- Needs guided onboarding to activate UPI, KYC, security settings
- First impression matters most

### Bank-Side User: Digital Banking Team (Web Dashboard)
- Views adoption funnels and engagement analytics
- Monitors AI recommendation effectiveness
- Tracks journey completion and drop-off rates

---

## 7. MVP Scope

### In Scope (MVP)

| Feature | Priority | Notes |
|---|---|---|
| Home Screen with AI Insight Card | P0 | Core engagement entry point |
| Financial Health Score | P0 | Simple 0â€“100 score with breakdown |
| Next Best Action Engine | P0 | Top 3 suggested actions |
| Weekly Story | P0 | Engagement recap card |
| Goal Tracker (create + view) | P1 | Emotional engagement hook |
| Services Discovery Screen | P1 | Feature categories with Sooubh AI chat |
| Smart Onboarding Journey | P1 | Step-by-step new user flow |
| Accounts Screen (spending view) | P1 | Financial control and clarity |
| Menu / Settings / Profile | P2 | Completeness screen |
| Flutter Web Companion Dashboard | P2 | Bank-facing analytics view |
| AI Discovery Engine | P2 | Unused feature nudges |

### Out of Scope (MVP)
- Live API integration with SBI core banking
- Real payment processing
- Actual KYC verification
- Biometric authentication
- Backend infrastructure or data storage

---

## 8. Screens â€” Detailed Requirements

### 8.1 Home Screen

**Purpose:** Create the first engagement moment and make the user feel the app understands them.

**UI Components:**

| Component | Description | Priority |
|---|---|---|
| Balance Card | Account balance, masked view, quick reveal toggle | P0 |
| Quick Actions | Send, Pay, Scan, Request â€” icon row | P0 |
| Financial Health Score | Circular progress ring, score number, one-line status | P0 |
| Sooubh Insight Card | AI-generated observation (e.g., "You saved â‚¹400 more this week") | P0 |
| Weekly Story | Horizontal card with tap-to-view animation | P0 |
| AI Actions | Vertical list of 2â€“3 next best action suggestions with CTAs | P0 |
| Active Goal | Progress bar, goal name, amount saved vs. target | P1 |

**Behavioral Rules:**
- The AI Insight Card must change based on user activity â€” not static placeholder text
- Weekly Story must only appear after the first 7 days of usage (demo: show as sample)
- AI Actions must prioritize incomplete onboarding steps if user is new
- Balance Card shows last 4 digits of account by default; full number on tap (with biometric prompt in production)

**Design Constraints:**
- Maximum 6 visible sections without scroll
- Vertical scroll only
- Each card must have consistent horizontal padding (16px minimum)
- Color palette must follow SBI's blue primary with Sooubh AI's teal accent layer

---

### 8.2 Accounts Screen

**Purpose:** Help users understand their money, spending behavior, and financial trajectory.

**UI Components:**

| Component | Description | Priority |
|---|---|---|
| Account Summary | Account type, number (masked), available balance, account status | P0 |
| Transaction History | Scrollable list with category icon, merchant name, amount, date | P0 |
| Spending Overview | Donut chart or bar chart breaking spending by category | P1 |
| Goal Tracker | Goal name, target amount, saved amount, progress bar | P1 |
| Savings Insights | AI-generated note on spending trends | P1 |

**Behavioral Rules:**
- Transaction list should support filter by date, type, and category
- Spending chart must have category labels (Food, Transport, Bills, etc.)
- Savings Insights text must be short (max 2 lines) and actionable

---

### 8.3 Services Screen

**Purpose:** The digital adoption engine â€” help users discover services they've never tried.

**UI Components:**

| Component | Description | Priority |
|---|---|---|
| Sooubh Search Bar | Smart search across all services, auto-suggests | P0 |
| Sooubh AI Chat Button | Floating or pinned CTA to open conversational assistant | P0 |
| Payments Section | UPI, Bill Pay, Recharge, FASTag | P0 |
| Accounts Section | Open FD, RD, PPF, Savings Account | P1 |
| Investments Section | SIP, Mutual Funds, NPS, Stocks | P1 |
| Loans Section | Home Loan, Personal Loan, Car Loan | P1 |
| Insurance Section | Life, Health, Motor, Travel | P1 |

**Behavioral Rules:**
- Services that the user has never interacted with should display a "New" or "Try it" badge
- Services not yet activated by the user should show an activation CTA instead of a navigation CTA
- Sooubh AI Chat should open a modal with pre-populated suggested questions based on user profile

---

### 8.4 Menu Screen

**Purpose:** User control, settings, security, and support â€” the completeness layer.

**UI Components:**

| Component | Description | Priority |
|---|---|---|
| Profile | Name, account number, profile photo placeholder | P0 |
| Settings | Notification preferences, language, theme | P0 |
| Security Center | PIN change, biometrics, device management, login history | P0 |
| Help & Support | FAQs, chat support, call back request | P1 |
| Rewards | Points balance, available offers, referral program | P1 |
| Offers | Personalized banking and partner offers | P2 |
| Locator | ATM and branch map finder | P2 |
| Sooubh AI Assistant | Quick access to AI journey assistant | P1 |

---

## 9. Agentic AI Features â€” Detailed Specifications

### 9.1 Next Best Action Engine

**What it does:** Identifies the single most impactful banking action for each user at any point in time.

**Logic (simplified for MVP demo):**
```
IF KYC not complete â†’ suggest "Complete KYC"
ELSE IF UPI not enabled â†’ suggest "Enable UPI"
ELSE IF no savings goal â†’ suggest "Create Emergency Fund"
ELSE IF no investment product â†’ suggest "Start your first SIP"
ELSE IF recurring deposit available â†’ suggest "Create RD with idle balance"
ELSE â†’ suggest "Review your spending this week"
```

**Display:** Shown as 2â€“3 action cards on the Home Screen with an icon, a one-line suggestion headline, a one-line explanation, and a "Do it now" CTA button.

**Constraints:**
- Maximum 3 actions displayed at once
- Each action must have a clear, low-friction path to complete it
- Actions must disappear once completed (state tracked locally in MVP)

---

### 9.2 Smart Onboarding Journey

**What it does:** Guides new users through a structured first-week setup experience.

**Journey Steps:**

| Step | Action | Trigger |
|---|---|---|
| 1 | Set up app PIN / biometrics | Day 0 â€” first launch |
| 2 | Enable UPI | Day 0 â€” after PIN setup |
| 3 | Add nominee | Day 1 â€” morning nudge |
| 4 | Secure your account (2FA, alerts) | Day 1 â€” evening nudge |
| 5 | Create your first financial goal | Day 2 |
| 6 | Explore savings and investment tools | Day 3â€“7 |

**Display:** Progress bar at the top of the Home Screen for the first 7 days, showing "X of 6 steps completed."

---

### 9.3 Financial Health Score

**What it does:** Gives users a single wellness number so they have a reason to return and improve.

**Score Range:** 0 to 100

**Score Components (equal weight in MVP):**

| Factor | Description |
|---|---|
| Savings Consistency | Regular savings behavior detected |
| Spending Discipline | Spending within historical average |
| Goal Progress | Active goals with positive progress |
| Investment Activity | At least one investment product active |
| Bill Payment Behavior | Bills paid on time, no missed payments |

**Display:** Circular ring on the Home Screen with the score number centered. Below the ring: a one-line status ("Good â€” keep it up" / "Needs attention"). Tap to expand breakdown view.

**Demo Logic for MVP:** Score is seeded from dummy data to demonstrate visual behavior.

---

### 9.4 Goal Coach

**What it does:** Lets users create and track financial goals, creating emotional investment in the app.

**Predefined Goal Templates:**
- Emergency Fund (â‚¹50,000 recommended minimum)
- Travel Fund (custom target)
- Education Fund (custom target)
- Wedding Fund (custom target)
- Home Down Payment (custom target)

**Goal Card Components:**
- Goal name + emoji indicator
- Target amount
- Saved amount
- Progress bar (percentage)
- Estimated completion date
- Suggested monthly contribution

**User Flow:**
1. Tap "Create Goal" on Home Screen or Accounts Screen
2. Select goal type or enter custom goal
3. Set target amount and timeline
4. Sooubh AI suggests a monthly savings amount
5. Goal appears on Home Screen and Accounts Screen

---

### 9.5 Weekly Story

**What it does:** Shows a short recap of the user's financial week in a visually engaging card format. Creates a "living" feeling and drives weekly return behavior.

**Story Card Sequence (tap through):**

| Slide | Content |
|---|---|
| 1 | "Your week at a glance" â€” header with week date range |
| 2 | "You saved â‚¹X this week" â€” savings highlight |
| 3 | "Your top spending: [category]" â€” spending insight |
| 4 | "Goal progress: X% closer to [goal name]" â€” goal update |
| 5 | "Your financial score moved from X to Y" â€” score trend |
| 6 | "Sooubh tip: [single actionable suggestion]" â€” AI recommendation |

**Display:** Horizontal swipeable card stack on the Home Screen, shown every Monday.

---

### 9.6 AI Discovery Engine

**What it does:** Detects services the user has never activated and proactively recommends them.

**Discovery Logic (MVP simulation):**
- Tag each service category as: `explored` / `partially activated` / `never opened`
- Show "Not Yet Explored" badge on services the user hasn't visited
- AI nudge card on Home Screen once a week: "You haven't tried [feature] â€” many users like you use it for [benefit]"

**Target Services for Discovery:**
- Auto-Save (recurring transfer to savings)
- Debit Card Controls (block / unblock, spending limits)
- SIP Setup (systematic investment plan)
- Insurance products
- Credit-linked offers and pre-approved loans

---

## 10. AI Behavior Guidelines

### How Sooubh AI Should Act

| Behavior | Rule |
|---|---|
| Tone | Helpful, concise, banking-professional â€” not casual or emoji-heavy |
| Text Length | Maximum 2 lines for any AI-generated surface text |
| Frequency | Maximum 1 proactive nudge per screen visible at a time |
| Personalization | Base suggestions on user's completion state and activity history |
| Context | Never suggest an action the user has already completed |
| Fallback | If no personalization data is available, suggest the most universally useful action (enable UPI) |

### What Sooubh AI Must NOT Do
- Act like a generic chatbot with long paragraph responses
- Overwhelm the user with more than 3 suggestions at once
- Replace or hide core banking functions
- Use language that sounds like advertising copy
- Interrupt the user during an active transaction flow

---

## 11. Flutter Build Plan

### 11.1 Mobile App (Primary Deliverable)

**Framework:** Flutter (Dart)
**Minimum SDK:** Android 6.0 (API 23) / iOS 13
**State Management:** Provider or Riverpod
**Navigation:** Named routes with transition animations

**Screen Navigation Flow:**
```
Splash â†’ Onboarding (new user) / Home Screen (returning user)
Home Screen â†” Accounts Screen â†” Services Screen â†” Menu Screen
Home Screen â†’ Goal Creation Flow
Home Screen â†’ Weekly Story Modal
Services Screen â†’ Sooubh AI Chat Modal
```

**Build Order (Hackathon Priority):**
1. Design system setup (colors, typography, spacing tokens in Flutter ThemeData)
2. Home Screen (skeleton + all 6 components)
3. Services Screen (categories + search + chat stub)
4. Accounts Screen (transaction list + spending chart)
5. Smart Onboarding Flow (6-step guided journey)
6. Menu Screen
7. Goal Creation Flow

---

### 11.2 Flutter Web Companion Dashboard (Secondary Deliverable)

**Purpose:** Bank-facing analytics view to show judges the enterprise value of the product.

**Dashboard Sections:**

| Section | KPI Shown |
|---|---|
| User Engagement Overview | Active users, daily opens, session duration |
| AI Recommendation Tracker | Total suggestions shown, acceptance rate, top actions |
| Digital Adoption Funnel | UPI enabled %, KYC completed %, first investment % |
| Journey Completion | Onboarding step-by-step drop-off rates |
| Feature Discovery | Most-explored and least-explored service categories |
| Financial Health Trends | Average health score over time, improvement rate |

**Design:** Clean, data-dense dashboard. SBI blue palette. Table + chart layout.

---

## 12. Design System

### Color Palette

| Role | Color | Usage |
|---|---|---|
| Primary Brand | SBI Blue `#22409A` | Headers, primary buttons, icons |
| AI Accent | Sooubh Teal `#00897B` | AI insight cards, health score ring, nudge highlights |
| Surface | Off-white `#F5F6FA` | Screen backgrounds |
| Card Background | White `#FFFFFF` | All card containers |
| Text Primary | Charcoal `#1A1A2E` | Headings, body text |
| Text Secondary | Cool Gray `#6B7280` | Subtitles, metadata |
| Success | Green `#22C55E` | Goal completion, payment success |
| Warning | Amber `#F59E0B` | Nudges, incomplete setup |
| Error | Red `#EF4444` | Failed transactions, security alerts |

### Typography

| Level | Usage | Weight |
|---|---|---|
| H1 | Screen title | Bold (700) |
| H2 | Section heading | SemiBold (600) |
| Body | Card content, descriptions | Regular (400) |
| Caption | Metadata, timestamps | Regular (400), smaller size |
| CTA | Buttons | SemiBold (600) |

### Component Library (Flutter Widgets)

- `SooubhCard` â€” base card with consistent radius, shadow, and padding
- `InsightChip` â€” short AI-generated text badge
- `HealthScoreRing` â€” animated circular progress widget
- `GoalProgressBar` â€” linear progress indicator with label
- `ActionButton` â€” primary CTA with loading state
- `WeeklyStoryModal` â€” swipeable modal sheet

---

## 13. Demo Strategy for Hackathon

### What to Demo

| Demo Segment | Duration | Focus |
|---|---|---|
| Cold open | 30 sec | "Most users only check balance â€” Sooubh AI changes that" |
| Home Screen walkthrough | 60 sec | Show Health Score, AI Insight Card, Next Best Actions |
| Smart Onboarding flow | 45 sec | New user guided journey â€” 6 steps |
| Weekly Story | 30 sec | Swipeable story cards on Home Screen |
| Goal Creation | 30 sec | Create Emergency Fund, see it appear on Home Screen |
| Services Discovery | 30 sec | Show unactivated service badges + Sooubh Chat stub |
| Web Dashboard | 45 sec | Show bank-side analytics view, adoption funnel |
| Close | 30 sec | "YONO SBI gives banking tools. Sooubh AI makes users actually use them." |

**Total Demo Time:** ~5 minutes

### Supporting Materials for Repository

- `README.md` with product overview, problem statement, and feature list
- `/mockups/` folder with generated screen images (home, accounts, services, menu)
- `/web-dashboard/` â€” Flutter web build or screenshots
- `PITCH.md` â€” one-page hackathon pitch document

---

## 14. Success Metrics (Post-Hackathon / Production Vision)

| Metric | Definition | Target (90 days) |
|---|---|---|
| Daily Active Users (DAU) | Users opening app daily | +35% vs. baseline |
| Feature Discovery Rate | Users trying a service for the first time | +50% of new users |
| Onboarding Completion | Users completing all 6 onboarding steps | >65% completion |
| UPI Activation Rate | New users enabling UPI within 7 days | >80% |
| Weekly Story View Rate | Users viewing their weekly story | >40% weekly open rate |
| Goal Creation Rate | Users creating at least one goal | >30% of active users |
| Financial Health Score Improvement | Score increase over 30 days | +8 points average |

---

## 15. Risks and Mitigations

| Risk | Likelihood | Impact | Mitigation |
|---|---|---|---|
| AI suggestions feel irrelevant | Medium | High | Hardcode smart demo data; use rule-based logic in MVP |
| UI feels complex on first open | Medium | High | Limit Home Scr
