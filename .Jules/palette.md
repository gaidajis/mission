## 2024-06-14 - Missing form associations and inline error ARIA
**Learning:** Toggled inline error messages using `display: none` without `aria-live` are a common pattern in this vanilla JS app. Furthermore, forms rely on unassociated labels.
**Action:** Always add `aria-live="polite"` to dynamic validation messages and `for` attributes to labels.
