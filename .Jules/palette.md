## 2024-05-18 - Form Validation Accessibility
**Learning:** In vanilla JS apps, dynamically toggling `display: none` on custom error messages isn't announced by screen readers without `aria-live="polite"`. Further, `<label>` elements are frequently orphaned without `for` attributes when not using a framework, breaking standard form accessibility.
**Action:** Always verify custom error validation uses `aria-live` and all `<label>`s have explicit `for` bindings matching input `id`s.
