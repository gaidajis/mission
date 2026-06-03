## 2024-05-18 - [ARIA Live for Dynamically Toggled Elements]
**Learning:** In vanilla JS apps without complex state management (like React), validation error messages are often hard-coded in the HTML and toggled using `display: none` / `display: block` via inline styles or classes. Screen readers don't always pick up these changes unless the container is marked appropriately.
**Action:** Always add `aria-live="polite"` directly to the error message elements that are dynamically shown/hidden via CSS, ensuring that screen readers will announce the error when it becomes visible.
