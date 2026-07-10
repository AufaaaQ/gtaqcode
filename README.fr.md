<p align="center">
  <a href="https://GTAQCODE.ai">
    <picture>
      <source srcset="packages/console/app/src/asset/logo-ornate-dark.svg" media="(prefers-color-scheme: dark)">
      <source srcset="packages/console/app/src/asset/logo-ornate-light.svg" media="(prefers-color-scheme: light)">
      <img src="packages/console/app/src/asset/logo-ornate-light.svg" alt="Logo GTAQCODE">
    </picture>
  </a>
</p>
<p align="center">L'agent de codage IA open source.</p>
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

# Gestionnaires de paquets
npm i -g GTAQCODE-ai@latest        # ou bun/pnpm/yarn
scoop install GTAQCODE             # Windows
choco install GTAQCODE             # Windows
brew install anomalyco/tap/GTAQCODE # macOS et Linux (recommandÃ©, toujours Ã  jour)
brew install GTAQCODE              # macOS et Linux (formule officielle brew, mise Ã  jour moins frÃ©quente)
sudo pacman -S GTAQCODE            # Arch Linux (Stable)
paru -S GTAQCODE-bin               # Arch Linux (Latest from AUR)
mise use -g GTAQCODE               # n'importe quel OS
nix run nixpkgs#GTAQCODE           # ou github:anomalyco/GTAQCODE pour la branche dev la plus rÃ©cente
```

> [!TIP]
> Supprimez les versions antÃ©rieures Ã  0.1.x avant d'installer.

### Application de bureau (BETA)

GTAQCODE est aussi disponible en application de bureau. TÃ©lÃ©chargez-la directement depuis la [page des releases](https://github.com/anomalyco/GTAQCODE/releases) ou [GTAQCODE.ai/download](https://GTAQCODE.ai/download).

| Plateforme            | TÃ©lÃ©chargement                     |
| --------------------- | ---------------------------------- |
| macOS (Apple Silicon) | `GTAQCODE-desktop-mac-arm64.dmg`   |
| macOS (Intel)         | `GTAQCODE-desktop-mac-x64.dmg`     |
| Windows               | `GTAQCODE-desktop-windows-x64.exe` |
| Linux                 | `.deb`, `.rpm`, ou AppImage        |

```bash
# macOS (Homebrew)
brew install --cask GTAQCODE-desktop
# Windows (Scoop)
scoop bucket add extras; scoop install extras/GTAQCODE-desktop
```

#### RÃ©pertoire d'installation

Le script d'installation respecte l'ordre de prioritÃ© suivant pour le chemin d'installation :

1. `$GTAQCODE_INSTALL_DIR` - RÃ©pertoire d'installation personnalisÃ©
2. `$XDG_BIN_DIR` - Chemin conforme Ã  la spÃ©cification XDG Base Directory
3. `$HOME/bin` - RÃ©pertoire binaire utilisateur standard (s'il existe ou peut Ãªtre crÃ©Ã©)
4. `$HOME/.GTAQCODE/bin` - Repli par dÃ©faut

```bash
# Exemples
GTAQCODE_INSTALL_DIR=/usr/local/bin curl -fsSL https://GTAQCODE.ai/install | bash
XDG_BIN_DIR=$HOME/.local/bin curl -fsSL https://GTAQCODE.ai/install | bash
```

### Agents

GTAQCODE inclut deux agents intÃ©grÃ©s que vous pouvez basculer avec la touche `Tab`.

- **build** - Par dÃ©faut, agent avec accÃ¨s complet pour le travail de dÃ©veloppement
- **plan** - Agent en lecture seule pour l'analyse et l'exploration du code
  - Refuse les modifications de fichiers par dÃ©faut
  - Demande l'autorisation avant d'exÃ©cuter des commandes bash
  - IdÃ©al pour explorer une base de code inconnue ou planifier des changements

Un sous-agent **general** est aussi inclus pour les recherches complexes et les tÃ¢ches en plusieurs Ã©tapes.
Il est utilisÃ© en interne et peut Ãªtre invoquÃ© via `@general` dans les messages.

En savoir plus sur les [agents](https://GTAQCODE.ai/docs/agents).

### Documentation

Pour plus d'informations sur la configuration d'GTAQCODE, [**consultez notre documentation**](https://GTAQCODE.ai/docs).

### Contribuer

Si vous souhaitez contribuer Ã  GTAQCODE, lisez nos [docs de contribution](./CONTRIBUTING.md) avant de soumettre une pull request.

### Construire avec GTAQCODE

Si vous travaillez sur un projet liÃ© Ã  GTAQCODE et que vous utilisez "GTAQCODE" dans le nom du projet (par exemple, "GTAQCODE-dashboard" ou "GTAQCODE-mobile"), ajoutez une note dans votre README pour prÃ©ciser qu'il n'est pas construit par l'Ã©quipe GTAQCODE et qu'il n'est pas affiliÃ© Ã  nous.

---

**Rejoignez notre communautÃ©** [Discord](https://discord.gg/GTAQCODE) | [X.com](https://x.com/GTAQCODE)
