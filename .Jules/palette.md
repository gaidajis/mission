## 2025-05-18 - Improve Form Accessibility and Error Messages
**Learning:** In vanilla JS apps using `display: none` to toggle inline validation errors, the errors are not announced to screen readers when they appear. Additionally, generic labels without `for` attributes break screen reader navigation.
**Action:** Always add `aria-live="polite"` to dynamically toggled error messages and ensure every `<label>` has a `for` attribute matching its input ID.
