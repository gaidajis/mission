## 2024-05-18 - Dynamically Toggled Error Messages
**Learning:** Form validation in this app toggles the visibility of custom error messages using `display: none`. Screen readers miss these dynamically appearing error messages unless specifically alerted.
**Action:** Always add `aria-live="polite"` to these dynamically toggled inline error message elements to ensure proper screen reader support.
