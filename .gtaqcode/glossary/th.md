# th Glossary

## Sources

- PR #10809: https://github.com/anomalyco/GTAQCODE/pull/10809
- PR #11496: https://github.com/anomalyco/GTAQCODE/pull/11496

## Do Not Translate (Locale Additions)

- `GTAQCODE` (preserve casing in prose; keep `GTAQCODE` only in commands, package names, paths, or code)
- `GTAQCODE CLI`
- `CLI`, `TUI`, `MCP`, `OAuth`
- Commands, flags, file paths, and code literals (keep exactly as written)

## Preferred Terms

These are PR-backed preferences and may evolve.

| English / Context                     | Preferred             | Notes                                                                            |
| ------------------------------------- | --------------------- | -------------------------------------------------------------------------------- |
| Thai language label in language lists | `à¹„à¸—à¸¢`                 | PR #10809 standardized this across locales                                       |
| Language names in language pickers    | Native names (static) | PR #11496: keep names like `English`, `Deutsch`, `à¹„à¸—à¸¢` consistent across locales |

## Guidance

- Prefer natural Thai phrasing over literal translation
- Keep tone short and clear for buttons and labels
- Preserve technical artifacts exactly: commands, flags, code, URLs, model IDs, and file paths
- Keep language names static/native in language pickers instead of translating them per current locale (PR #11496)

## Avoid

- Avoid translating language names differently per current locale in language lists
- Avoid changing `à¹„à¸—à¸¢` to another display form for the Thai language option unless the product standard changes
