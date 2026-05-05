# Mission

> **A global peer-to-peer micro-task marketplace** — connect people who need something done anywhere in the world with locals who can make it happen.

[![Live Demo](https://img.shields.io/badge/Live%20Demo-GitHub%20Pages-brightgreen?style=for-the-badge&logo=github)](https://gaidajis.github.io/mission)
[![License: CC BY-NC 4.0](https://img.shields.io/badge/License-CC%20BY--NC%204.0-lightgrey.svg?style=for-the-badge)](./LICENSE)
[![Tech](https://img.shields.io/badge/Tech-Vanilla%20JS%20%2F%20HTML5%20%2F%20CSS3-orange?style=for-the-badge)](https://developer.mozilla.org/en-US/docs/Web/JavaScript)

---

## 📖 Overview

**Mission** is a zero-dependency, client-side web application that simulates a global errand and task marketplace. Users can post missions — real-world requests ranging from sourcing a rare product abroad to live-streaming a local market — and local providers around the world can accept and fulfil them.

The app runs entirely in the browser using `localStorage` as its persistence layer, making it instantly deployable as a static site with no backend or database required. A rich set of seed data pre-populates the platform with realistic missions across 5 continents, giving a production-like experience from the moment the page loads.

---

## ✨ Features

### For Requesters
- Post a mission with a title, description, category, budget, currency, location, and deadline
- Track mission status: `open` → `in_progress` → `completed`
- Message providers directly within a mission thread
- Leave reviews and ratings for providers after task completion

### For Providers
- Browse all open missions across 7 categories with full-text search
- Filter and sort missions by: **Latest**, **Nearest**, **Highest Budget**, or **Ending Soon**
- Accept missions and communicate with requesters via the in-app messaging system
- Build a reputation profile through completed tasks and user reviews

### General
- Dual-role accounts (Requester, Provider, or Both)
- Smooth page transitions with CSS fade animations
- Toast notification system for user feedback
- Initials-based SVG avatar generation (no image uploads needed)
- Responsive layout suitable for desktop and mobile browsers
- Demo accounts with pre-seeded data for instant exploration

---

## 🌍 Mission Categories

| Category | Icon | Description |
|---|---|---|
| **Social** | 💬 | Conversations, translations, local advice |
| **Transport** | 🚗 | Rides, pickups, logistics coordination |
| **Delivery** | 📦 | Ship goods from one country to another |
| **Goods** | 🛍️ | Source and purchase specific items locally |
| **Social Animals** | 🐾 | Pet sitting, dog walking, animal care |
| **Repairs** | 🔧 | Fix electronics, household items, vehicles |
| **Special** | ⭐ | Photography, scouting, unique one-off tasks |

---

## 🗂️ Project Structure

```
mission/
├── index.html        # Landing page — hero, value proposition, featured missions
├── login.html        # Authentication — login and registration forms
├── app.html          # Core marketplace — mission feed, filters, search, post-mission modal
├── profile.html      # User profile — stats, posted missions, completed tasks, reviews
├── request.html      # Mission detail — full description, messages, accept/complete actions
├── app.js            # Shared application logic — data layer, auth, utils, seed data
├── style.css         # Global stylesheet — dark theme, animations, component styles
├── .github/          # GitHub Actions workflows (e.g. Pages deployment)
├── .nojekyll         # Disables Jekyll processing for GitHub Pages
└── LICENSE           # CC BY-NC 4.0
```

---

## 🏗️ Architecture

Mission is a **single-page-application-style** multi-page static site. All pages share one JavaScript file (`app.js`) which is loaded globally and provides:

### Data Layer
All data is stored in and retrieved from the browser's `localStorage` under three keys:

| Key | Content |
|---|---|
| `mission_users` | Array of registered user objects |
| `mission_requests` | Array of mission/request objects |
| `mission_session` | ID string of the currently logged-in user |

### Auth System
- **Registration**: Creates a new user, saves to `localStorage`, and starts a session
- **Login**: Validates email + password against stored users and writes a session key
- **`requireAuth()`**: Guards pages that require a logged-in user; redirects to `login.html` if no session is found

### Seed Data
On first load, `seedIfEmpty()` populates the app with:
- **5 demo user accounts** across Tokyo, Lagos, Paris, Mumbai, and Berlin (all with password `demo123`)
- **20 realistic seed missions** spanning 15+ cities across 6 continents, with dynamic deadline dates recalculated relative to the current date

---

## 🚀 Getting Started

### Prerequisites
None. The app requires only a modern web browser (Chrome, Firefox, Safari, Edge).

### Option 1 — Open Directly
Clone the repo and open `index.html` in your browser:

```bash
git clone https://github.com/gaidajis/mission.git
cd mission
open index.html   # macOS
# or: xdg-open index.html (Linux)
# or: start index.html (Windows)
```

### Option 2 — Local Static Server (Recommended)
To avoid any browser file-protocol restrictions, serve the files locally:

```bash
# Using Node.js
npx serve .

# Using Python
python -m http.server 8080

# Using VS Code
# Install the "Live Server" extension, then right-click index.html → "Open with Live Server"
```

Then navigate to `http://localhost:3000` (or the port shown in your terminal).

### Option 3 — Live Demo
The app is continuously deployed to GitHub Pages:

👉 **[https://gaidajis.github.io/mission](https://gaidajis.github.io/mission)**

---

## 🔐 Demo Accounts

Use any of these pre-seeded accounts to explore the app immediately:

| Name | Email | Password | Role | Location |
|---|---|---|---|---|
| Maria Santos 🇯🇵 | `maria@demo.com` | `demo123` | Both | Tokyo, Japan |
| James Okafor 🇳🇬 | `james@demo.com` | `demo123` | Provider | Lagos, Nigeria |
| Léa Moreau 🇫🇷 | `lea@demo.com` | `demo123` | Requester | Paris, France |
| Arjun Mehta 🇮🇳 | `arjun@demo.com` | `demo123` | Both | Mumbai, India |
| Sophie Müller 🇩🇪 | `sophie@demo.com` | `demo123` | Provider | Berlin, Germany |

> ⚠️ All data is stored in your browser's `localStorage`. Clearing browser storage or opening in a private/incognito window will reset the data and re-seed on next load.

---

## 🧩 Key Functions Reference

| Function | Location | Description |
|---|---|---|
| `seedIfEmpty()` | `app.js` | Populates localStorage with demo users and missions on first load |
| `requireAuth()` | `app.js` | Redirects unauthenticated users to `login.html` |
| `getRequests(filters)` | `app.js` | Fetches and filters/sorts missions from storage |
| `saveRequest(req)` | `app.js` | Upserts a mission object to storage |
| `addMessage(requestId, senderId, text)` | `app.js` | Appends a chat message to a mission thread |
| `addReview(userId, reviewerId, rating, comment)` | `app.js` | Adds a review to a user's profile |
| `formatDeadline(isoDate)` | `app.js` | Returns human-readable deadline (e.g. "3 days left", "Overdue") |
| `showToast(message)` | `app.js` | Displays a dismissible notification banner |
| `pageTransition(targetUrl)` | `app.js` | Triggers CSS fade-out before navigating to a new page |
| `getInitialsAvatar(name, color)` | `app.js` | Generates an inline SVG avatar from a user's initials |

---

## 🛠️ Tech Stack

| Layer | Technology |
|---|---|
| Markup | HTML5 (semantic, accessible) |
| Styling | CSS3 (custom properties, flexbox, grid, animations) |
| Logic | Vanilla JavaScript (ES6+, no frameworks, no build tools) |
| Persistence | Browser `localStorage` |
| Deployment | GitHub Pages (static hosting) |

---

## 🔄 Deployment

The project is deployed automatically via **GitHub Pages** from the `main` branch root. Any push to `main` is immediately reflected at the live URL.

To deploy your own fork:
1. Fork this repository
2. Go to **Settings → Pages**
3. Set Source to `Deploy from a branch` → `main` → `/ (root)`
4. Your instance will be live at `https://<your-username>.github.io/mission`

---

## 📜 License

This project is licensed under the **Creative Commons Attribution-NonCommercial 4.0 International (CC BY-NC 4.0)** license.

**Commercial use is strictly prohibited.** You are free to share and adapt this work for non-commercial purposes with appropriate attribution.

See [LICENSE](./LICENSE) for full terms.

---

## 👤 Author

**Kyparissis Gkaintatzis**
© 2026 — All rights reserved.

---

*Built as a concept prototype for a global micro-task and errand marketplace.*
