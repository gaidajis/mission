## 2024-05-15 - Form Validation Accessibility
**Learning:** In this vanilla JS app, custom validation errors dynamically toggle visibility via `display: none`. Without `aria-live`, screen readers completely miss these errors when they appear.
**Action:** Always add `aria-live="polite"` to dynamically toggled error messages and strictly use `<label for="...">` associated with input IDs for proper form structure.
