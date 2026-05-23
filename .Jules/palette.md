## 2024-05-24 - Form Label Accessibility and Visual UX
**Learning:** Found that custom form controls across the app lacked proper `for` ID associations with their input elements, hindering screen reader usability and click targets. Additionally, mandatory fields lacked visual required indicators despite having HTML5 `required` attributes.
**Action:** Always link `<label>` to `<input>` using `for` and `id` pairs. Added visual asterisks (using existing accent colors) to provide clear UX cues for required fields without adding new dependencies.
