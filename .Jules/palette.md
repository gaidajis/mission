## 2024-05-22 - Add `for` attributes to form labels
**Learning:** Found multiple form `<label>` elements missing the `for` attribute to associate them with the relevant input fields. This negatively impacts keyboard users and screen reader accessibility, and makes forms less usable for everyone (since clicking the label doesn't focus the input).
**Action:** Always ensure every `<label>` has a `for` attribute matching the `id` of its corresponding `<input>`, `<textarea>`, or `<select>`.
