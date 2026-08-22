## 2024-05-14 - Inline Form Errors Accessibility
**Learning:** Form validation in vanilla JS apps that toggles visibility of custom error messages using `display: none` requires `aria-live="polite"` so screen readers will announce them dynamically. Also, associating labels with inputs using `for` is essential for screen reader support on generic input structures.
**Action:** Always add `aria-live="polite"` to dynamically toggled inline error message elements (`<p id="error">`) and ensure all `<label>` elements use `for` attributes pointing to their input IDs.
