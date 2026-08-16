## 2024-05-24 - Dynamic Inline Error Messages
**Learning:** In vanilla JS apps where form validation toggles visibility of custom error messages using `display: none`, screen readers may not announce the error when it appears.
**Action:** Always add `aria-live="polite"` to dynamically toggled inline error message elements to ensure screen readers announce them when they become visible, and ensure all `<label>` elements use `for` attributes to associate with their respective form inputs to ensure proper screen reader support.
