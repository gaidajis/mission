## 2026-05-26 - Accessible Custom Rating Widget
**Learning:** Hiding native inputs with `display: none` for custom UI widgets (like star ratings) completely removes them from the accessibility tree and keyboard focus order, breaking accessibility for screen readers and keyboard users.
**Action:** Visually hide inputs using CSS (`position: absolute; opacity: 0; width: 0; height: 0;`) so they remain focusable, use `+ label` to style the adjacent label for `:focus-visible` states, and ensure proper `aria-label` and `role` attributes are set.
