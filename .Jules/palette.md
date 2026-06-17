## 2024-06-17 - Vanilla JS Form Validation Accessibility
**Learning:** The application uses a custom vanilla JS pattern for form validation where inline error messages are toggled by changing their inline style between `display: none` and `display: block`. Screen readers won't automatically announce these dynamically appearing elements without ARIA live regions.
**Action:** Always add `aria-live="polite"` to inline error message elements that use this visibility-toggling pattern.
