## 2024-05-15 - Missing form `<label>` associations
**Learning:** Found multiple instances where form `<label>` tags lacked `for` attributes, which broke screen reader associations and prevented users from focusing inputs by clicking their labels.
**Action:** Ensure all `<label>` elements explicitly define `for="[input-id]"` for both improved accessibility and a smoother click-to-focus experience across the component library.
