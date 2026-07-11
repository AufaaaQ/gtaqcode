#!/usr/bin/env node
const https = require("https")
const fs = require("fs")
const path = require("path")
const os = require("os")
const { spawnSync } = require("child_process")

const platformMap = { darwin: "darwin", linux: "linux", win32: "windows" }
const archMap = { x64: "x64", arm64: "arm64" }
const platform = platformMap[os.platform()] || os.platform()
const arch = archMap[os.arch()] || os.arch()
const binaryName = platform === "windows" ? "gtaqcode.exe" : "gtaqcode"
const pkgDir = path.dirname(__dirname)
const binPath = path.join(pkgDir, binaryName)

function download(url, dest) {
  return new Promise((resolve, reject) => {
    const file = fs.createWriteStream(dest)
    https.get(url, (res) => {
      const target = res.statusCode >= 300 && res.headers.location ? res.headers.location : url
      if (target !== url) return https.get(target, (r) => r.pipe(file))
      res.pipe(file)
    })
    file.on("finish", () => { file.close(); fs.chmodSync(dest, "755"); resolve() })
    file.on("error", reject)
  })
}

;(async () => {
  if (fs.existsSync(binPath)) return run(binPath)

  const ver = require("../package.json").version
  const archive = platform === "windows" ? "zip" : "tar.gz"
  const url = `https://github.com/AufaaaQ/gtaqcode/releases/download/v${ver}/gtaqcode-${platform}-${arch}.${archive}`
  const tmp = fs.mkdtempSync(path.join(os.tmpdir(), "gtaqcode-"))
  const dl = path.join(tmp, `archive.${archive}`)

  process.stderr.write("Downloading gtaqcode binary...\n")
  await download(url, dl)

  if (archive === "zip") {
    spawnSync("unzip", ["-o", dl, "-d", tmp], { stdio: "inherit" })
  } else {
    spawnSync("tar", ["-xzf", dl, "-C", tmp], { stdio: "inherit" })
  }

  const found = fs.readdirSync(tmp).find((f) => f !== `archive.${archive}`)
  const src = fs.existsSync(path.join(tmp, found, binaryName))
    ? path.join(tmp, found, binaryName)
    : path.join(tmp, binaryName)
  fs.copyFileSync(src, binPath)
  fs.chmodSync(binPath, "755")
  run(binPath)
})()

function run(target) {
  const child = spawnSync(target, process.argv.slice(2), { stdio: "inherit" })
  process.exit(child.status ?? 0)
}
