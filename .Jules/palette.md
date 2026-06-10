## 2024-06-10 - Form Accessibility and Error Messages
**Learning:** Inline error messages toggled via `display: none` are completely missed by screen readers when they appear, and many custom form controls omit the critical `for` attribute tying `<label>` elements to inputs.
**Action:** Always add `aria-live="polite"` to dynamic error containers and ensure every `<label>` has a `for` attribute matching the `id` of its corresponding input element.
