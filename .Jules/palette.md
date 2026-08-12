## 2024-05-24 - Accessibility for vanilla JS forms
**Learning:** In vanilla JS apps, form validation error messages that toggle visibility using `display: none` need `aria-live="polite"` so screen readers can announce them when they appear. Also, it's critical to associate `<label>` with their respective form inputs using `for` attributes to ensure screen reader support.
**Action:** Always add `aria-live="polite"` to dynamically toggled inline error messages, and ensure all `<label>` elements use `for` attributes.
