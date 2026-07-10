export * from "./client.js"
export * from "./server.js"

import { createGTAQCODEClient } from "./client.js"
import { createGTAQCODEServer } from "./server.js"
import type { ServerOptions } from "./server.js"

export * as data from "./data.js"

export async function createGTAQCODE(options?: ServerOptions) {
  const server = await createGTAQCODEServer({
    ...options,
  })

  const client = createGTAQCODEClient({
    baseUrl: server.url,
  })

  return {
    client,
    server,
  }
}
