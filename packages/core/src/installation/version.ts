declare global {
  const GTAQCODE_VERSION: string
  const OPENCODE_CHANNEL: string
}

export const InstallationVersion = typeof GTAQCODE_VERSION === "string" ? GTAQCODE_VERSION : "local"
export const InstallationChannel = typeof OPENCODE_CHANNEL === "string" ? OPENCODE_CHANNEL : "local"
export const InstallationLocal = InstallationChannel === "local"
