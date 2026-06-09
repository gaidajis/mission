## 2024-05-15 - Inline Error Visibility
**Learning:** Toggling custom inline errors via `display: none` in vanilla JS requires `aria-live="polite"` to properly alert screen readers when they become visible. Ensure `<label>` elements are connected to `<input>` with `for` attributes.
**Action:** Always add `aria-live="polite"` to dynamically toggled error text and associate all form labels with inputs using the `for` attribute to enhance form accessibility.
