## 2024-05-15 - Dynamic inline form error announcements
**Learning:** In vanilla JS apps that rely on CSS `display: none` to toggle inline error messages, screen readers might miss them when they appear.
**Action:** Always add `aria-live="polite"` to dynamically toggled inline error messages to ensure they are announced to screen reader users.
