## 2025-01-15 - Dynamic Form Error Accessibility
**Learning:** Form validation in this vanilla JS app toggles visibility of custom error messages using display: none.
**Action:** Always add aria-live="polite" to dynamically toggled inline error message elements, and ensure all <label> elements use 'for' attributes to associate with inputs.
