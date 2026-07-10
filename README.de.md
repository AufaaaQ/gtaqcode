<p align="center">
  <a href="https://GTAQCODE.ai">
    <picture>
      <source srcset="packages/console/app/src/asset/logo-ornate-dark.svg" media="(prefers-color-scheme: dark)">
      <source srcset="packages/console/app/src/asset/logo-ornate-light.svg" media="(prefers-color-scheme: light)">
      <img src="packages/console/app/src/asset/logo-ornate-light.svg" alt="GTAQCODE logo">
    </picture>
  </a>
</p>
<p align="center">Der Open-Source KI-Coding-Agent.</p>
<p align="center">
  <a href="https://GTAQCODE.ai/discord"><img alt="Discord" src="https://img.shields.io/discord/1391832426048651334?style=flat-square&label=discord" /></a>
  <a href="https://www.npmjs.com/package/GTAQCODE-ai"><img alt="npm" src="https://img.shields.io/npm/v/GTAQCODE-ai?style=flat-square" /></a>
  <a href="https://github.com/anomalyco/GTAQCODE/actions/workflows/publish.yml"><img alt="Build status" src="https://img.shields.io/github/actions/workflow/status/anomalyco/GTAQCODE/publish.yml?style=flat-square&branch=dev" /></a>
</p>

<p align="center">
  <a href="README.md">English</a> |
  <a href="README.zh.md">ç®€ä½“ä¸­æ–‡</a> |
  <a href="README.zht.md">ç¹é«”ä¸­æ–‡</a> |
  <a href="README.ko.md">í•œêµ­ì–´</a> |
  <a href="README.de.md">Deutsch</a> |
  <a href="README.es.md">EspaÃ±ol</a> |
  <a href="README.fr.md">FranÃ§ais</a> |
  <a href="README.it.md">Italiano</a> |
  <a href="README.da.md">Dansk</a> |
  <a href="README.ja.md">æ—¥æœ¬èªž</a> |
  <a href="README.pl.md">Polski</a> |
  <a href="README.ru.md">Ð ÑƒÑÑÐºÐ¸Ð¹</a> |
  <a href="README.bs.md">Bosanski</a> |
  <a href="README.ar.md">Ø§Ù„Ø¹Ø±Ø¨ÙŠØ©</a> |
  <a href="README.no.md">Norsk</a> |
  <a href="README.br.md">PortuguÃªs (Brasil)</a> |
  <a href="README.th.md">à¹„à¸—à¸¢</a> |
  <a href="README.tr.md">TÃ¼rkÃ§e</a> |
  <a href="README.uk.md">Ð£ÐºÑ€Ð°Ñ—Ð½ÑÑŒÐºÐ°</a> |
  <a href="README.bn.md">à¦¬à¦¾à¦‚à¦²à¦¾</a> |
  <a href="README.gr.md">Î•Î»Î»Î·Î½Î¹ÎºÎ¬</a> |
  <a href="README.vi.md">Tiáº¿ng Viá»‡t</a>
</p>

[![GTAQCODE Terminal UI](packages/web/src/assets/lander/screenshot.png)](https://GTAQCODE.ai)

---

### Installation

```bash
# YOLO
curl -fsSL https://GTAQCODE.ai/install | bash

# Paketmanager
npm i -g GTAQCODE-ai@latest        # oder bun/pnpm/yarn
scoop install GTAQCODE             # Windows
choco install GTAQCODE             # Windows
brew install anomalyco/tap/GTAQCODE # macOS und Linux (empfohlen, immer aktuell)
brew install GTAQCODE              # macOS und Linux (offizielle Brew-Formula, seltener aktualisiert)
sudo pacman -S GTAQCODE            # Arch Linux (Stable)
paru -S GTAQCODE-bin               # Arch Linux (Latest from AUR)
mise use -g GTAQCODE               # jedes Betriebssystem
nix run nixpkgs#GTAQCODE           # oder github:anomalyco/GTAQCODE fÃ¼r den neuesten dev-Branch
```

> [!TIP]
> Entferne Versionen Ã¤lter als 0.1.x vor der Installation.

### Desktop-App (BETA)

GTAQCODE ist auch als Desktop-Anwendung verfÃ¼gbar. Lade sie direkt von der [Releases-Seite](https://github.com/anomalyco/GTAQCODE/releases) oder [GTAQCODE.ai/download](https://GTAQCODE.ai/download) herunter.

| Plattform             | Download                           |
| --------------------- | ---------------------------------- |
| macOS (Apple Silicon) | `GTAQCODE-desktop-mac-arm64.dmg`   |
| macOS (Intel)         | `GTAQCODE-desktop-mac-x64.dmg`     |
| Windows               | `GTAQCODE-desktop-windows-x64.exe` |
| Linux                 | `.deb`, `.rpm` oder AppImage       |

```bash
# macOS (Homebrew)
brew install --cask GTAQCODE-desktop
# Windows (Scoop)
scoop bucket add extras; scoop install extras/GTAQCODE-desktop
```

#### Installationsverzeichnis

Das Installationsskript beachtet die folgende PrioritÃ¤tsreihenfolge fÃ¼r den Installationspfad:

1. `$GTAQCODE_INSTALL_DIR` - Benutzerdefiniertes Installationsverzeichnis
2. `$XDG_BIN_DIR` - XDG Base Directory Specification-konformer Pfad
3. `$HOME/bin` - Standard-BinÃ¤rverzeichnis des Users (falls vorhanden oder erstellbar)
4. `$HOME/.GTAQCODE/bin` - Standard-Fallback

```bash
# Beispiele
GTAQCODE_INSTALL_DIR=/usr/local/bin curl -fsSL https://GTAQCODE.ai/install | bash
XDG_BIN_DIR=$HOME/.local/bin curl -fsSL https://GTAQCODE.ai/install | bash
```

### Agents

GTAQCODE enthÃ¤lt zwei eingebaute Agents, zwischen denen du mit der `Tab`-Taste wechseln kannst.

- **build** - Standard-Agent mit vollem Zugriff fÃ¼r Entwicklungsarbeit
- **plan** - Nur-Lese-Agent fÃ¼r Analyse und Code-Exploration
  - Verweigert Datei-Edits standardmÃ¤ÃŸig
  - Fragt vor dem AusfÃ¼hren von bash-Befehlen nach
  - Ideal zum Erkunden unbekannter Codebases oder zum Planen von Ã„nderungen

AuÃŸerdem ist ein **general**-Subagent fÃ¼r komplexe Suchen und mehrstufige Aufgaben enthalten.
Dieser wird intern genutzt und kann in Nachrichten mit `@general` aufgerufen werden.

Mehr dazu unter [Agents](https://GTAQCODE.ai/docs/agents).

### Dokumentation

Mehr Infos zur Konfiguration von GTAQCODE findest du in unseren [**Docs**](https://GTAQCODE.ai/docs).

### Beitragen

Wenn du zu GTAQCODE beitragen mÃ¶chtest, lies bitte unsere [Contributing Docs](./CONTRIBUTING.md), bevor du einen Pull Request einreichst.

### Auf GTAQCODE aufbauen

Wenn du an einem Projekt arbeitest, das mit GTAQCODE zusammenhÃ¤ngt und "GTAQCODE" als Teil seines Namens verwendet (z.B. "GTAQCODE-dashboard" oder "GTAQCODE-mobile"), fÃ¼ge bitte einen Hinweis in deine README ein, dass es nicht vom GTAQCODE-Team gebaut wird und nicht in irgendeiner Weise mit uns verbunden ist.

---

**Tritt unserer Community bei** [Discord](https://discord.gg/GTAQCODE) | [X.com](https://x.com/GTAQCODE)
