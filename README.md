# 🏘️ PropIndex — Premium Real Estate Experience

[![Aesthetics](https://img.shields.io/badge/Design-Premium-FF5A5F?style=for-the-badge)](https://github.com/)
[![Tech Stack](https://img.shields.io/badge/Stack-Alpine.js%20%7C%20Tailwind-38B2AC?style=for-the-badge)](https://github.com/)
[![License](https://img.shields.io/badge/License-MIT-blue?style=for-the-badge)](LICENSE)

PropIndex is a high-fidelity, cinematic real estate platform designed for the modern era. Moving beyond clinical property listings, PropIndex focuses on a humanized approach to finding spaces that feel like soulmates.

---

## ✨ Key Features

### 💎 High-Fidelity UI/UX
- **Fluid Navigation**: A scroll-responsive floating glassmorphism navbar that adapts from transparent to a blur-pill state.
- **Bento-Grid Architecture**: Modern discovery grids for residential, commercial, and luxury collections.
- **Micro-interactions**: Shimmer effects, liquid underlines, and staggered animations using Alpine.js.

### 🏠 Comprehensive Real Estate Modules
- **Dynamic Search**: High-performance search interface with AI-driven property valuation tools.
- **Premium Mega Menu**: Contextual navigation for Finance, Insights, Services, and Property discovery.
- **Mobile-First Design**: Immersive, full-screen mobile menu with staggered transitions.

### 🛠️ Integrated Tools
- **Finance Suite**: Home loan assistance, EMI calculators, and stamp duty estimators.
- **Insights Engine**: Weekly market pulses, research reports, and locality reviews.
- **Home Services**: Interior design, packers & movers, and property management integrations.

---

## 🚀 Tech Stack

- **Core**: HTML5 Semantic Structure
- **Styling**: [Tailwind CSS](https://tailwindcss.com/) (Custom Design Tokens)
- **Logic**: [Alpine.js](https://alpinejs.dev/) (Lightweight State Management)
- **Typography**: [Outfit](https://fonts.google.com/specimen/Outfit) & [Inter](https://fonts.google.com/specimen/Inter)
- **Animation**: Native CSS Keyframes & Tailwind Transitions

---

## 📂 Project Structure

```bash
propindex/
├── index.html                # Main Landing Page
├── buy-property.html         # Residential Discovery
├── commercial.html           # Commercial Portfolio
├── finance/                  # EMI, Loans, and Valuation tools
├── services/                 # Interior, Packers & Movers
├── assets/                   # Images, Icons, and Scripts
├── tailwind.config.js        # Design System Tokens
└── distribute_menu.ps1       # Navigation Sync Script
```

---

## 🛠️ Getting Started

### Prerequisites
- A modern web browser.
- (Optional) Node.js & Tailwind CLI if you wish to modify the design tokens.

### Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/propindex.git
   ```
2. Open `index.html` in your browser.

### Synchronization
If you update the navigation in `index.html`, run the distribution script to sync changes across all pages:
```powershell
.\distribute_mobile_menu.ps1
```

---

## 🎨 Design Language

PropIndex follows the **Studio 2.0** design philosophy:
- **Primary**: `#FF5A5F` (Humanized Red)
- **Surface**: High-blur translucency (`backdrop-blur-3xl`)
- **Radius**: `2.5rem` (Super Rounded)
- **Motion**: Cubic-bezier based easing (`0.16, 1, 0.3, 1`)

---

## 🤝 Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## 📄 License

Distributed under the MIT License. See `LICENSE` for more information.

---

<p align="center">
  Built with ❤️ by the Ashish Saini (LiveALYX)
</p>
