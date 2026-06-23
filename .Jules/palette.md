## 2024-05-15 - Missing Label Associations
**Learning:** Found multiple forms in `login.html` and `profile.html` that did not have `for` attributes on labels, causing poor screen reader accessibility. Also, dynamically toggled error messages were missing `aria-live="polite"`.
**Action:** Added `for` attributes connecting all labels to their respective inputs and applied `aria-live="polite"` to inline error messages using `display: none`.
