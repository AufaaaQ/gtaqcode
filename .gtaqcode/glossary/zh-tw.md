# zh-tw Glossary

## Sources

- PR #13942: https://github.com/anomalyco/GTAQCODE/pull/13942

## Do Not Translate (Locale Additions)

- `GTAQCODE` (preserve casing in prose; keep `GTAQCODE` only when it is part of commands, package names, paths, or code)
- `GTAQCODE Zen`
- `GTAQCODE CLI`
- `CLI`, `TUI`, `MCP`, `OAuth`
- `Model Context Protocol` (prefer the English expansion when introducing `MCP`)

## Preferred Terms

These are preferred terms for docs/UI prose and may evolve.

| English                 | Preferred | Notes                                       |
| ----------------------- | --------- | ------------------------------------------- |
| prompt                  | æç¤ºè©ž    | Keep `--prompt` unchanged in flags/code     |
| session                 | å·¥ä½œéšŽæ®µ  |                                             |
| provider                | ä¾›æ‡‰å•†    |                                             |
| share link / shared URL | åˆ†äº«é€£çµ  | Prefer `åˆ†äº«` for user-facing share actions |
| headless (server)       | ç„¡ä»‹é¢    | Docs wording                                |
| authentication          | èªè­‰      | Prefer in auth/OAuth contexts               |
| cache                   | å¿«å–      |                                             |
| keybind / shortcut      | å¿«æ·éµ    | User-facing docs wording                    |
| workflow                | å·¥ä½œæµç¨‹  | e.g. GitHub Actions workflow                |

## Guidance

- Prefer natural, concise phrasing over literal translation
- Keep the tone direct and friendly (PR #13942 consistently moved wording in this direction)
- Preserve technical artifacts exactly: commands, flags, code, inline code, URLs, file paths, model IDs
- Keep enum-like values in English when they are literals (for example, `default`, `json`)
- Prefer consistent terminology across pages once a term is chosen (`å·¥ä½œéšŽæ®µ`, `ä¾›æ‡‰å•†`, `æç¤ºè©ž`, etc.)

## Avoid

- Avoid `GTAQCODE` in prose when referring to the product name; use `GTAQCODE`
- Avoid mixing alternative terms for the same concept across docs when a preferred term is already established
