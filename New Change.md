# YONO SBI Agentic AI Redesign Document

## Overview

This document outlines a hackathon-ready redesign concept for YONO SBI focused on customer acquisition, digital adoption, and long-term digital engagement through embedded agentic AI journeys. YONO SBI already positions itself as an all-in-one app for banking, payments, investments, loans, rewards, and lifestyle services, which gives SBI a wide product base but also creates a feature-heavy experience that can overwhelm users if not guided properly.[cite:46][cite:55]

The redesign approach is to transform YONO from a menu-driven banking app into an AI-led banking journey platform. Instead of placing one generic chatbot inside the app, the concept adds a contextual micro-agent on every important screen so the AI can guide, simplify, predict, and recover user journeys in real time.[cite:74][cite:98]

## Problem Statement

Banks today struggle with three connected problems: acquiring customers efficiently, getting them to adopt digital products after signup, and keeping them meaningfully engaged over time. Research on agentic AI in banking shows the strongest opportunities lie in faster onboarding, hyper-personalized journeys, next-best-action recommendation, and proactive financial support based on behavior and life events.[cite:67][cite:70][cite:84]

For YONO SBI specifically, official app positioning shows broad functional scope, but public feedback and redesign commentary point to friction in core journeys such as login, payment reliability, beneficiary setup, and navigation clarity.[cite:46][cite:55][cite:34][cite:35] This means the redesign should not focus only on visual polish; it should focus on outcome completion in high-frequency jobs such as sending money, activating UPI, paying bills, and discovering other SBI products.[cite:35][cite:93]

## Redesign Goal

The redesigned YONO SBI should act as an agentic financial companion that helps users complete their banking tasks with fewer steps, less confusion, and more trust. The AI layer should improve customer acquisition through conversational onboarding, increase digital adoption through guided first-use missions, and improve engagement through personalized financial recommendations and proactive re-engagement.[cite:23][cite:25][cite:63][cite:89]

A strong product framing for the hackathon is: **YONO SBI: From banking app to agentic financial companion.** This framing aligns directly with the hackathon themes of AI-led banking journeys, digital product adoption, intelligent financial interactions, and personalized engagement.[cite:84][cite:88]

## Core Product Principles

### 1. Task-first design

The app should prioritize the top user goals first: check balance, scan and pay, send money, pay bills, manage cards, and view spending. Secondary features such as rewards, lifestyle, loans, and investments should still exist, but they should be surfaced when contextually relevant rather than competing equally on the home screen.[cite:46][cite:55]

### 2. Screen-level AI instead of chatbot-only AI

Every major screen should include a small, embedded, task-aware AI capability. This follows the logic of agentic banking, where AI helps users complete tasks instead of acting as a passive Q&A layer.[cite:74][cite:98]

### 3. Next-best-action orchestration

The app should continually guide the user toward the most useful next step, such as activating UPI after account creation, setting up the first bill payment after a successful transfer, or exploring spending insights after a week of transactions. This is central to digital adoption and cross-feature engagement.[cite:63][cite:65][cite:73]

### 4. Trust-first AI behavior

In banking, AI should explain what it is doing, ask for consent before taking actions, and surface risk warnings clearly. Trust matters more than novelty in regulated financial flows.[cite:84][cite:88]

## Main Features

## 1. AI Acquisition Agent

This agent appears at the first app open and helps qualify the user intent. Instead of asking the user to explore a large app, it begins with a direct prompt such as: “What do you want to do today — open an account, activate UPI, manage salary, save money, or pay someone?” Agentic AI in banking is increasingly used to qualify users, personalize journeys, and move them into the right flow faster.[cite:75][cite:77][cite:84]

### Key capabilities

- Goal-based entry into the app.
- Suggests the right SBI account or service based on intent.
- Reduces drop-off by matching the first screen to the user’s objective.
- Starts the right onboarding flow immediately.

### Acquisition value

This helps customer acquisition because the user sees immediate relevance instead of a crowded interface. It also increases conversion by reducing early confusion and allowing SBI to segment users dynamically during the very first session.[cite:68][cite:77]

## 2. Conversational Onboarding Agent

This should be the flagship feature for the hackathon. The onboarding agent reads PAN or Aadhaar, extracts data, pre-fills forms, explains KYC steps in simple language, routes users based on their profile, and helps complete setup with fewer manual steps.[cite:23][cite:25][cite:76][cite:83]

### Key capabilities

- OCR for PAN and Aadhaar.
- Auto-fill for name, DOB, address, and ID numbers.
- Step-by-step conversational onboarding.
- Adaptive flows for student, salaried, senior citizen, or existing SBI customer.
- Real-time error explanation for failed fields or verification mismatch.
- Resume flow after abandonment.

### Acquisition value

Research on banking onboarding consistently shows speed, personalization, and fewer manual verification steps improve completion and reduce onboarding churn.[cite:25][cite:68][cite:71] This feature directly supports customer acquisition because unfinished onboarding is one of the biggest reasons potential users never become active customers.[cite:28][cite:68]

## 3. Smart Start Adoption Engine

After signup, many banking apps lose users because they fail to create an early habit. The Smart Start engine creates a personalized first-7-days mission path that guides the user through the most valuable digital actions.[cite:63][cite:65][cite:89]

### Example mission path

1. Activate UPI.
2. Complete first scan-and-pay.
3. Add first beneficiary.
4. Pay one bill or recharge.
5. View spending insights.
6. Set one savings goal.

### Key capabilities

- Dynamic checklist based on customer profile.
- Progress tracker with completion rewards or trust markers.
- Personalized nudges if the user stops midway.
- Recommends the next SBI feature based on what has already been completed.

### Adoption value

This turns passive signups into active digital users. Research on AI-led customer lifecycle management in banking emphasizes next-best-action guidance and personalized lifecycle automation as key drivers of deeper product usage.[cite:63][cite:65]

## 4. Home Screen Agentic Layer

The home screen should become an action hub rather than a static dashboard. Instead of showing every product equally, the AI should surface personalized quick actions, suggested flows, pending tasks, and recent behaviors.[cite:85][cite:87]

### Key capabilities

- Shows likely next action, such as “Pay rent,” “Activate UPI,” or “Review this month’s spending.”
- Prioritizes frequent tasks above promotional clutter.
- Dynamically changes modules based on salary day, bill due date, and recent transfer behavior.
- Surfaces cross-feature prompts such as moving from spending to savings.

### Engagement value

This directly supports digital engagement because the app feels alive and relevant, not static. AI-driven personalized dashboards are becoming a major differentiator in banking UX, especially when driven by behavior and context rather than static segmentation.[cite:78][cite:85][cite:87]

## 5. AI-Powered Send Money Flow

The send-money journey is one of the most important screens in the app. Traditional bank flows often separate recipient addition, beneficiary setup, detail verification, and actual transfer into rigid steps, which creates friction.[cite:96][cite:99][cite:101]

The redesigned YONO flow should start with the real user goal: **send money**. The AI should make this journey faster, safer, and easier.

### Key capabilities

- Suggests recent and frequent recipients.
- Predicts whether the user wants UPI, IMPS, or bank transfer.
- Validates IFSC and account number format automatically.
- Fetches recipient details where possible.
- Suggests the most likely transfer amount based on past behavior.
- Explains charges, transfer speed, and warnings in plain language.
- Provides a simplified retry flow if payment fails.

### Engagement value

This improves repeated usage because transfers become easier over time. A smoother, more intelligent payment flow increases habit formation and trust in daily financial interactions.[cite:74][cite:103]

## 6. AI Beneficiary Assistant

Beneficiary addition is one of the strongest places to show good product thinking. Traditional banking flows often ask “Add beneficiary or make payment?” too early, before the user has enough context. UX commentary on banking transfer flows shows that this early decision increases cognitive load and does not match how users actually think during a transfer journey.[cite:93]

### Redesigned flow

1. User taps Send Money.
2. User enters UPI ID, mobile number, or account details.
3. AI validates and fetches recipient information.
4. User enters amount.
5. Before confirmation, AI asks: “Save this person for future payments?”
6. After payment, AI gives one-tap options to save, label, or repeat later.

### Key capabilities

- Duplicate beneficiary detection.
- Auto-suggest nickname like Rent, Family, or Vendor.
- Smart timing for save-beneficiary prompt.
- Risk alerts for mismatched or suspicious details.
- Beneficiary management with natural-language search.

### Adoption value

This helps both usability and engagement. It makes one of the most frustrating bank tasks feel more natural, while also improving repeat payment convenience for future sessions.[cite:93][cite:100]

## 7. Bill Pay and Recharge Agent

Many users install a banking app for one task and never discover other digital features. Bill pay is a powerful bridge feature because it converts a transactional user into a recurring user.

### Key capabilities

- Detects recurring billers from past behavior.
- Suggests setting autopay after the first manual payment.
- Reminds users before due dates.
- Groups bills by category such as electricity, mobile, OTT, DTH, insurance, or credit card.
- Explains why a bill amount changed this month.

### Adoption value

This increases digital product adoption by moving users from pure balance-checking or transfers into recurring digital payments. Recurring tasks improve app stickiness and long-term engagement.[cite:65][cite:89]

## 8. Financial Coach Agent

This agent turns YONO into a proactive financial guide rather than a passive transaction app. It should analyze spending, detect anomalies, explain changes, and recommend actions in natural language.[cite:72][cite:86][cite:87]

### Key capabilities

- “Where did my money go this month?” explanation.
- Budget suggestions based on spend categories.
- Salary-day planning prompts.
- Savings goal creation from spending patterns.
- Alerts for unusual expenses or recurring leaks.
- Product suggestions only when contextually useful.

### Engagement value

Research on AI-driven engagement in banking points to behavior-based advice and personalized financial support as strong drivers of retention and loyalty.[cite:78][cite:86][cite:87] This agent gives users a reason to return even when they are not actively making a payment.

## 9. Life-Event and Behavior Trigger Engine

The hackathon brief specifically mentions proactive interaction based on behavior, financial patterns, and life events. This should be implemented as an event-driven orchestration system inside YONO.[cite:80][cite:82]

### Trigger examples

- Salary credited → suggest budget split and savings rule.
- Repeated rent payment → suggest recurring payment setup.
- Higher travel spend → suggest travel card or spending alert.
- College fees season → surface education planning tools.
- Inactivity for 7 days → send personalized resume journey.
- First salary account detected → propose savings or FD starter journey.

### Engagement value

This is one of the clearest examples of agentic AI because the app is not waiting for the user to search for features. It proactively initiates useful, timely, explainable journeys based on what it understands about the customer.[cite:78][cite:82][cite:85]

## 10. Contextual Support and Recovery Agent

A banking app should never leave users alone in failed or confusing states. The support agent should understand where the user is in the journey and help within that context rather than redirecting them to a generic FAQ.[cite:63][cite:88]

### Key capabilities

- Explains payment failure reasons simply.
- Offers retry, alternate route, or support escalation.
- Detects repeated login friction and suggests simpler authentication.
- Gives screen-specific help for UPI, cards, bills, onboarding, or beneficiary management.
- Recovers abandoned flows with one-tap resume.

### Engagement value

Better recovery means fewer lost users. In acquisition and digital adoption, many users do not fail because they are uninterested; they fail because the app leaves them stranded when something goes wrong.[cite:63][cite:68]

## Screen-by-Screen AI Layer

| Screen | AI role | Main user value |
|---|---|---|
| First Open | Acquisition Agent | Qualifies user intent and routes to the right journey [cite:75] |
| Onboarding | Conversational Onboarding Agent | Auto-fills, explains KYC, reduces drop-off [cite:23][cite:76] |
| Home | Next-Best-Action Agent | Shows most relevant task and product [cite:85] |
| Send Money | Transfer Agent | Predicts recipient, method, and amount |
| Add Beneficiary | Beneficiary Assistant | Validates details, smart save timing [cite:93] |
| Bills & Recharge | Recurring Payments Agent | Converts one-time user into recurring user [cite:89] |
| Insights | Financial Coach | Explains spending and suggests actions [cite:86] |
| Support/Error States | Recovery Agent | Fixes failure and resumes journey [cite:63] |

## End-to-End User Journey Example

### Journey: New user to engaged digital user

1. User opens YONO SBI and selects “I want to open an account and start UPI.”
2. Acquisition Agent routes the user to the right onboarding flow.[cite:75][cite:77]
3. Onboarding Agent scans PAN or Aadhaar, pre-fills details, and completes verification.[cite:23][cite:25]
4. After signup, Smart Start shows a checklist: activate UPI, make first payment, add beneficiary, and view spending.[cite:63][cite:65]
5. User sends first payment through the AI-powered transfer flow.
6. Beneficiary Assistant asks to save the payee only when the user is ready.[cite:93]
7. After a week, Financial Coach summarizes spending and suggests a savings goal.[cite:86][cite:87]
8. Home screen then promotes bill pay and other relevant SBI features, increasing adoption depth.[cite:85][cite:89]

This journey demonstrates the full hackathon theme: customer acquisition, digital onboarding, digital product adoption, personalized engagement, intelligent financial interaction, and AI-led banking journeys.[cite:84][cite:88]

## Success Metrics

The concept should be presented with outcome metrics, even if the prototype does not fully measure them yet.

### Acquisition metrics

- Onboarding completion rate.
- Time to account setup.
- Reduction in abandoned KYC journeys.
- First-session conversion into active account user.

### Adoption metrics

- UPI activation rate.
- First transaction completion.
- Bill pay activation.
- Beneficiary save rate.
- Number of SBI features adopted in first 7 days.

### Engagement metrics

- Weekly active users.
- Repeat transfer frequency.
- Bill autopay adoption.
- Financial insights usage.
- Return rate after AI nudges.

These metrics align with the hackathon’s focus on customer acquisition, product adoption, and long-term digital engagement.[cite:84][cite:89]

## Recommended Hackathon Scope

To keep the prototype sharp, the most effective scope is to design and demo these five parts deeply:

1. AI welcome and intent screen.
2. Conversational onboarding flow.
3. Smart home dashboard with next-best-action cards.
4. Send money plus beneficiary agent flow.
5. Financial coach plus personalized re-engagement screen.

This is enough to prove the complete value chain from acquisition to engagement without spreading the prototype too thin.

## Final Positioning

The final solution should be positioned as an embedded AI operating layer for YONO SBI. The differentiator is not a chatbot tab, but an invisible agentic layer across the entire app that helps the user complete the next banking task, discover more features, and return more often because the app becomes genuinely useful in daily life.[cite:74][cite:98]

A concise pitch line for the document is:

**YONO SBI redesigned with an agentic AI layer to acquire users faster, activate them sooner, and engage them longer through contextual, screen-by-screen financial journeys.**
