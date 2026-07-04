## 2024-05-24 - Form Validation Accessibility
**Learning:** Custom JS form validation that toggles inline error messages using display: none needs aria-live="polite" to properly announce errors to screen readers.
**Action:** Always add aria-live="polite" to dynamic error message elements and ensure labels use for attributes to associate with their inputs.
