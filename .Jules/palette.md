## 2024-06-02 - Form Validation Accessibility
**Learning:** This application uses a custom inline form validation pattern where error messages are toggled via `display: none` to `display: block`. Screen readers won't announce these state changes automatically.
**Action:** Always include `aria-live="polite"` on the inline error message containers that are dynamically revealed by JavaScript. Additionally, explicitly pair all `<label>` elements with their inputs using `for` attributes to ensure robust screen reader context.
