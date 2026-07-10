import { Config } from "effect"

export function truthy(key: string) {
  const value = process.env[key]?.toLowerCase()
  return value === "true" || value === "1"
}

const copy = process.env["GTAQCODE_EXPERIMENTAL_DISABLE_COPY_ON_SELECT"]
const fff = process.env["GTAQCODE_DISABLE_FFF"]

function enabledByExperimental(key: string) {
  return process.env[key] === undefined ? truthy("GTAQCODE_EXPERIMENTAL") : truthy(key)
}

export const Flag = {
  OTEL_EXPORTER_OTLP_ENDPOINT: process.env["OTEL_EXPORTER_OTLP_ENDPOINT"],
  OTEL_EXPORTER_OTLP_HEADERS: process.env["OTEL_EXPORTER_OTLP_HEADERS"],

  GTAQCODE_AUTO_HEAP_SNAPSHOT: truthy("GTAQCODE_AUTO_HEAP_SNAPSHOT"),
  GTAQCODE_GIT_BASH_PATH: process.env["GTAQCODE_GIT_BASH_PATH"],
  GTAQCODE_CONFIG: process.env["GTAQCODE_CONFIG"],
  GTAQCODE_CONFIG_CONTENT: process.env["GTAQCODE_CONFIG_CONTENT"],
  GTAQCODE_DISABLE_AUTOUPDATE: truthy("GTAQCODE_DISABLE_AUTOUPDATE"),
  GTAQCODE_ALWAYS_NOTIFY_UPDATE: truthy("GTAQCODE_ALWAYS_NOTIFY_UPDATE"),
  GTAQCODE_DISABLE_PRUNE: truthy("GTAQCODE_DISABLE_PRUNE"),
  GTAQCODE_DISABLE_TERMINAL_TITLE: truthy("GTAQCODE_DISABLE_TERMINAL_TITLE"),
  GTAQCODE_SHOW_TTFD: truthy("GTAQCODE_SHOW_TTFD"),
  GTAQCODE_DISABLE_AUTOCOMPACT: truthy("GTAQCODE_DISABLE_AUTOCOMPACT"),
  GTAQCODE_DISABLE_MODELS_FETCH: truthy("GTAQCODE_DISABLE_MODELS_FETCH"),
  GTAQCODE_DISABLE_MOUSE: truthy("GTAQCODE_DISABLE_MOUSE"),
  GTAQCODE_FAKE_VCS: process.env["GTAQCODE_FAKE_VCS"],
  GTAQCODE_SERVER_PASSWORD: process.env["GTAQCODE_SERVER_PASSWORD"],
  GTAQCODE_SERVER_USERNAME: process.env["GTAQCODE_SERVER_USERNAME"],
  GTAQCODE_DISABLE_FFF: fff === undefined ? process.platform === "win32" : truthy("GTAQCODE_DISABLE_FFF"),

  // Experimental
  GTAQCODE_EXPERIMENTAL_FILEWATCHER: Config.boolean("GTAQCODE_EXPERIMENTAL_FILEWATCHER").pipe(
    Config.withDefault(false),
  ),
  GTAQCODE_EXPERIMENTAL_DISABLE_FILEWATCHER: Config.boolean("GTAQCODE_EXPERIMENTAL_DISABLE_FILEWATCHER").pipe(
    Config.withDefault(false),
  ),
  GTAQCODE_EXPERIMENTAL_DISABLE_COPY_ON_SELECT:
    copy === undefined ? process.platform === "win32" : truthy("GTAQCODE_EXPERIMENTAL_DISABLE_COPY_ON_SELECT"),
  GTAQCODE_MODELS_URL: process.env["GTAQCODE_MODELS_URL"],
  GTAQCODE_MODELS_PATH: process.env["GTAQCODE_MODELS_PATH"],
  GTAQCODE_DB: process.env["GTAQCODE_DB"],

  GTAQCODE_WORKSPACE_ID: process.env["GTAQCODE_WORKSPACE_ID"],
  GTAQCODE_EXPERIMENTAL_WORKSPACES: enabledByExperimental("GTAQCODE_EXPERIMENTAL_WORKSPACES"),

  // Evaluated at access time (not module load) because tests, the CLI, and
  // external tooling set these env vars at runtime.
  get GTAQCODE_DISABLE_PROJECT_CONFIG() {
    return truthy("GTAQCODE_DISABLE_PROJECT_CONFIG")
  },
  get GTAQCODE_EXPERIMENTAL_REFERENCES() {
    return enabledByExperimental("GTAQCODE_EXPERIMENTAL_REFERENCES")
  },
  get GTAQCODE_TUI_CONFIG() {
    return process.env["GTAQCODE_TUI_CONFIG"]
  },
  get GTAQCODE_CONFIG_DIR() {
    return process.env["GTAQCODE_CONFIG_DIR"]
  },
  get GTAQCODE_PURE() {
    return truthy("GTAQCODE_PURE")
  },
  get GTAQCODE_PERMISSION() {
    return process.env["GTAQCODE_PERMISSION"]
  },
  get GTAQCODE_PLUGIN_META_FILE() {
    return process.env["GTAQCODE_PLUGIN_META_FILE"]
  },
  get GTAQCODE_CLIENT() {
    return process.env["GTAQCODE_CLIENT"] ?? "cli"
  },
}
