## 2024-06-11 - Form Accessibility
**Learning:** In vanilla JS apps, form labels are easily missed and error messages are often dynamically toggled without aria-live, leading to screen reader unfriendliness.
**Action:** Consistently link `<label>` and `<input>` with `for` and `id` respectively, and add `aria-live="polite"` on hidden error text.
