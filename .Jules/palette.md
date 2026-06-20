## 2024-05-16 - Form Accessibility Improvements
**Learning:** The application extensively uses vanilla JS for forms and error handling, but lacks basic `for` attributes connecting labels to inputs, and misses `aria-live` regions for dynamically toggled inline error messages.
**Action:** Ensure all form labels use the `for` attribute referencing the corresponding input ID. Always add `aria-live="polite"` to error message containers whose visibility is toggled via JS (`display: none` to `block`).
