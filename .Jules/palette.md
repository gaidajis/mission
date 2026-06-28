## 2024-05-15 - Form Validation Accessibility
**Learning:** Form validation in this vanilla JS app toggles visibility of custom error messages using `display: none`.
**Action:** Always add `aria-live="polite"` to these dynamically toggled inline error message elements, and ensure all `<label>` elements use `for` attributes to associate with their respective form inputs to ensure proper screen reader support.
