## 2026-07-02 - Form Accessibility and Error Announcements
**Learning:** Form validation in this vanilla JS app toggles visibility of custom error messages using `display: none`. Because screen readers do not announce content changes that are just toggled, these messages are missed. Also, form components lack `for` attributes, decoupling labels from inputs.
**Action:** Always add `aria-live="polite"` to dynamically toggled inline error message elements, and ensure all `<label>` elements use `for` attributes to associate with their respective form inputs to ensure proper screen reader support.
