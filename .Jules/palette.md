## 2024-05-18 - Dynamic form error accessibility
**Learning:** In vanilla JS forms that toggle custom validation errors using `display: none` / `display: block`, screen readers fail to announce the errors when they appear. The `aria-live` attribute is required for dynamically toggled content.
**Action:** Always add `aria-live="polite"` to inline error message elements (like `<p>` or `<span>`) that are hidden by default and shown via JavaScript validation, to ensure screen readers inform users of form errors.
