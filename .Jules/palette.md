## 2024-05-15 - Inline Error Accessibility
**Learning:** In this vanilla JS application, form validation toggles custom error messages using `display: none` rather than standard HTML5 validation UI. Screen readers do not announce these inline messages when they appear.
**Action:** Always add `aria-live="polite"` to dynamically toggled inline error messages in this codebase to ensure they are announced to screen reader users without interrupting their current task.
