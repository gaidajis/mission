## 2024-05-24 - Form Validation Accessibility
**Learning:** Form validation in this vanilla JS app toggles visibility of custom error messages using `display: none`. Native browser validation handles formatting, but JS custom validation errors are silently toggled.
**Action:** Always add `aria-live="polite"` to dynamically toggled inline error message elements (`<p>`), and ensure all `<label>` elements use `for` attributes to associate with their respective form inputs to ensure proper screen reader support.
