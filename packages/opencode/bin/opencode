#!/usr/bin/env node

const childProcess = require("child_process")
const fs = require("fs")
const path = require("path")
const os = require("os")

const forwardedSignals = ["SIGINT", "SIGTERM", "SIGHUP"]

function run(target) {
  const child = childProcess.spawn(target, process.argv.slice(2), {
    stdio: "inherit",
  })

  child.on("error", (error) => {
    console.error(error.message)
    process.exit(1)
  })

  const forwarders = {}
  for (const signal of forwardedSignals) {
    forwarders[signal] = () => {
      try {
        child.kill(signal)
      } catch {
        // The child may have already exited.
      }
    }
    process.on(signal, forwarders[signal])
  }

  child.on("exit", (code, signal) => {
    for (const forwardedSignal of forwardedSignals) {
      process.removeListener(forwardedSignal, forwarders[forwardedSignal])
    }

    if (signal) {
      process.kill(process.pid, signal)
      return
    }

    process.exit(typeof code === "number" ? code : 0)
  })
}

const envPath = process.env.OPENCODE_BIN_PATH

const scriptPath = fs.realpathSync(__filename)
const scriptDir = path.dirname(scriptPath)

//
const cached = path.join(scriptDir, ".gtaqcode")

const platformMap = {
  darwin: "darwin",
  linux: "linux",
  win32: "windows",
}
const archMap = {
  x64: "x64",
  arm64: "arm64",
  arm: "arm",
}

let platform = platformMap[os.platform()]
if (!platform) {
  platform = os.platform()
}
let arch = archMap[os.arch()]
if (!arch) {
  arch = os.arch()
}
const base = "gtaqcode-" + platform + "-" + arch
const binary = platform === "windows" ? "gtaqcode.exe" : "gtaqcode"

function supportsAvx2() {
  if (arch !== "x64") return false

  if (platform === "linux") {
    try {
      return /(^|\s)avx2(\s|$)/i.test(fs.readFileSync("/proc/cpuinfo", "utf8"))
    } catch {
      return false
    }
  }

  if (platform === "darwin") {
    try {
      const result = childProcess.spawnSync("sysctl", ["-n", "hw.optional.avx2_0"], {
        encoding: "utf8",
        timeout: 1500,
      })
      if (result.status !== 0) return false
      return (result.stdout || "").trim() === "1"
    } catch {
      return false
    }
  }

  if (platform === "windows") {
    const cmd =
      '(Add-Type -MemberDefinition "[DllImport(""kernel32.dll"")] public static extern bool IsProcessorFeaturePresent(int ProcessorFeature);" -Name Kernel32 -Namespace Win32 -PassThru)::IsProcessorFeaturePresent(40)'

    for (const exe of ["powershell.exe", "pwsh.exe", "pwsh", "powershell"]) {
      try {
        const result = childProcess.spawnSync(exe, ["-NoProfile", "-NonInteractive", "-Command", cmd], {
          encoding: "utf8",
          timeout: 3000,
          windowsHide: true,
        })
        if (result.status !== 0) continue
        const out = (result.stdout || "").trim().toLowerCase()
        if (out === "true" || out === "1") return true
        if (out === "false" || out === "0") return false
      } catch {
        continue
      }
    }

    return false
  }

  return false
}

const names = (() => {
  const avx2 = supportsAvx2()
  const baseline = arch === "x64" && !avx2

  if (platform === "linux") {
    const musl = (() => {
      try {
        if (fs.existsSync("/etc/alpine-release")) return true
      } catch {
        // ignore
      }

      try {
        const result = childProcess.spawnSync("ldd", ["--version"], { encoding: "utf8" })
        const text = ((result.stdout || "") + (result.stderr || "")).toLowerCase()
        if (text.includes("musl")) return true
      } catch {
        // ignore
      }

      return false
    })()

    if (musl) {
      if (arch === "x64") {
        if (baseline) return [`${base}-baseline-musl`, `${base}-musl`, `${base}-baseline`, base]
        return [`${base}-musl`, `${base}-baseline-musl`, base, `${base}-baseline`]
      }
      return [`${base}-musl`, base]
    }

    if (arch === "x64") {
      if (baseline) return [`${base}-baseline`, base, `${base}-baseline-musl`, `${base}-musl`]
      return [base, `${base}-baseline`, `${base}-musl`, `${base}-baseline-musl`]
    }
    return [base, `${base}-musl`]
  }

  if (arch === "x64") {
    if (baseline) return [`${base}-baseline`, base]
    return [base, `${base}-baseline`]
  }
  return [base]
})()

function findBinary(startDir) {
  let current = startDir
  for (;;) {
    const modules = path.join(current, "node_modules")
    if (fs.existsSync(modules)) {
      for (const name of names) {
        const candidate = path.join(modules, name, "bin", binary)
        if (fs.existsSync(candidate)) return candidate
      }
    }
    const parent = path.dirname(current)
    if (parent === current) {
      return
    }
    current = parent
  }
}

const https = require("https")

function download(url, dest) {
  return new Promise((resolve, reject) => {
    const file = fs.createWriteStream(dest)
    https.get(url, (res) => {
      if (res.statusCode >= 300 && res.headers.location) {
        https.get(res.headers.location, (r) => r.pipe(file))
      } else {
        res.pipe(file)
      }
    })
    file.on("finish", () => { file.close(); fs.chmodSync(dest, 0o755); resolve() })
    file.on("error", reject)
  })
}

;(async () => {
  let resolved = envPath || (fs.existsSync(cached) ? cached : findBinary(scriptDir))
  if (!resolved) {
    const ver = "1.0.0"
    const archive = platform === "windows" ? "zip" : "tar.gz"
    const url = `https://github.com/AufaaaQ/gtaqcode/releases/download/v${ver}/gtaqcode-${platform}-${arch}.${archive}`
    const tmp = path.join(os.tmpdir(), "gtaqcode-install")
    fs.mkdirSync(tmp, { recursive: true })
    const dl = path.join(tmp, `archive.${archive}`)
    console.error("Downloading gtaqcode binary...")
    await download(url, dl)
    if (archive === "zip") {
      const { spawnSync } = require("child_process")
      spawnSync("unzip", ["-o", dl, "-d", tmp], { stdio: "inherit" })
    } else {
      const { spawnSync } = require("child_process")
      spawnSync("tar", ["-xzf", dl, "-C", tmp], { stdio: "inherit" })
    }
    const files = fs.readdirSync(tmp).filter(f => f !== `archive.${archive}`)
    resolved = path.join(tmp, files[0], binary)
    if (!fs.existsSync(resolved)) {
      resolved = path.join(tmp, binary)
    }
  }
  run(resolved)
})()
