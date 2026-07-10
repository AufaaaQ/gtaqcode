<p align="center">
  <a href="https://GTAQCODE.ai">
    <picture>
      <source srcset="packages/console/app/src/asset/logo-ornate-dark.svg" media="(prefers-color-scheme: dark)">
      <source srcset="packages/console/app/src/asset/logo-ornate-light.svg" media="(prefers-color-scheme: light)">
      <img src="packages/console/app/src/asset/logo-ornate-light.svg" alt="Logo GTAQCODE">
    </picture>
  </a>
</p>
<p align="center">Lâ€™agente di coding AI open source.</p>
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

### Installazione

```bash
# YOLO
curl -fsSL https://GTAQCODE.ai/install | bash

# Package manager
npm i -g GTAQCODE-ai@latest        # oppure bun/pnpm/yarn
scoop install GTAQCODE             # Windows
choco install GTAQCODE             # Windows
brew install anomalyco/tap/GTAQCODE # macOS e Linux (consigliato, sempre aggiornato)
brew install GTAQCODE              # macOS e Linux (formula brew ufficiale, aggiornata meno spesso)
sudo pacman -S GTAQCODE            # Arch Linux (Stable)
paru -S GTAQCODE-bin               # Arch Linux (Latest from AUR)
mise use -g GTAQCODE               # Qualsiasi OS
nix run nixpkgs#GTAQCODE           # oppure github:anomalyco/GTAQCODE per lâ€™ultima branch di sviluppo
```

> [!TIP]
> Rimuovi le versioni precedenti alla 0.1.x prima di installare.

### App Desktop (BETA)

GTAQCODE Ã¨ disponibile anche come applicazione desktop. Puoi scaricarla direttamente dalla [pagina delle release](https://github.com/anomalyco/GTAQCODE/releases) oppure da [GTAQCODE.ai/download](https://GTAQCODE.ai/download).

| Piattaforma           | Download                           |
| --------------------- | ---------------------------------- |
| macOS (Apple Silicon) | `GTAQCODE-desktop-mac-arm64.dmg`   |
| macOS (Intel)         | `GTAQCODE-desktop-mac-x64.dmg`     |
| Windows               | `GTAQCODE-desktop-windows-x64.exe` |
| Linux                 | `.deb`, `.rpm`, oppure AppImage    |

```bash
# macOS (Homebrew)
brew install --cask GTAQCODE-desktop
# Windows (Scoop)
scoop bucket add extras; scoop install extras/GTAQCODE-desktop
```

#### Directory di installazione

Lo script di installazione rispetta il seguente ordine di prioritÃ  per il percorso di installazione:

1. `$GTAQCODE_INSTALL_DIR` â€“ Directory di installazione personalizzata
2. `$XDG_BIN_DIR` â€“ Percorso conforme alla XDG Base Directory Specification
3. `$HOME/bin` â€“ Directory binaria standard dellâ€™utente (se esiste o puÃ² essere creata)
4. `$HOME/.GTAQCODE/bin` â€“ Fallback predefinito

```bash
# Esempi
GTAQCODE_INSTALL_DIR=/usr/local/bin curl -fsSL https://GTAQCODE.ai/install | bash
XDG_BIN_DIR=$HOME/.local/bin curl -fsSL https://GTAQCODE.ai/install | bash
```

### Agenti

GTAQCODE include due agenti integrati tra cui puoi passare usando il tasto `Tab`.

- **build** â€“ Predefinito, agente con accesso completo per il lavoro di sviluppo
- **plan** â€“ Agente in sola lettura per analisi ed esplorazione del codice
  - Nega le modifiche ai file per impostazione predefinita
  - Chiede il permesso prima di eseguire comandi bash
  - Ideale per esplorare codebase sconosciute o pianificare modifiche

Ãˆ inoltre incluso un sotto-agente **general** per ricerche complesse e attivitÃ  multi-step.
Viene utilizzato internamente e puÃ² essere invocato usando `@general` nei messaggi.

Scopri di piÃ¹ sugli [agenti](https://GTAQCODE.ai/docs/agents).

### Documentazione

Per maggiori informazioni su come configurare GTAQCODE, [**consulta la nostra documentazione**](https://GTAQCODE.ai/docs).

### Contribuire

Se sei interessato a contribuire a GTAQCODE, leggi la nostra [guida alla contribuzione](./CONTRIBUTING.md) prima di inviare una pull request.

### Costruire su GTAQCODE

Se stai lavorando a un progetto correlato a GTAQCODE e che utilizza â€œGTAQCODEâ€ come parte del nome (ad esempio â€œGTAQCODE-dashboardâ€ o â€œGTAQCODE-mobileâ€), aggiungi una nota nel tuo README per chiarire che non Ã¨ sviluppato dal team GTAQCODE e che non Ã¨ affiliato in alcun modo con noi.

---

**Unisciti alla nostra community** [Discord](https://discord.gg/GTAQCODE) | [X.com](https://x.com/GTAQCODE)
