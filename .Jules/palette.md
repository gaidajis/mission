## 2026-06-26 - Inline Form Error Accessibility
**Learning:** In this vanilla JS application, form validation error messages are toggled dynamically using `display: none` rather than adding/removing DOM elements. This requires explicit ARIA attributes to notify screen readers of changes when an error is revealed.
**Action:** Always add `aria-live="polite"` to these statically present error message containers, and ensure standard form accessibility by connecting all inputs to explicit `<label>` elements using `for` attributes.
