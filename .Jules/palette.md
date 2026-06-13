## 2026-06-13 - Dynamic form error handling & field labels
**Learning:** In a vanilla HTML setup where error messages are toggled via display:none, they require aria-live='polite' for screen readers to announce them when they become visible. All form fields strictly need for-attributes on labels matching their element ids to ensure input-label association for screen readers.
**Action:** Applied aria-live='polite' to login and signup error paragraphs, and paired all label elements with their target inputs via for attributes.
