## 2024-08-11 - Form Labels and Dynamic Error Announcements
**Learning:** Custom form validation error messages in this app are dynamically toggled via `display: none` without notifying screen readers, and many forms lack proper `<label for="...">` associations.
**Action:** Always add `aria-live="polite"` to dynamically toggled inline error elements and ensure all `<label>` elements have `for` attributes mapping to input IDs.
