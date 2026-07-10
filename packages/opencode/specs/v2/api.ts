// @ts-nocheck

import { GTAQCODE } from "@gtaqcode/core"
import { ReadTool } from "@gtaqcode/core/tools"

const GTAQCODE = GTAQCODE.make({})

GTAQCODE.tool.add(ReadTool)

GTAQCODE.tool.add({
  name: "bash",
  schema: {
    type: "object",
    properties: {
      command: {
        type: "string",
        description: "The command to run.",
      },
    },
    required: ["command"],
  },
  execute(input, ctx) {},
})

GTAQCODE.auth.add({
  provider: "openai",
  type: "api",
  value: process.env.OPENAI_API_KEY,
})

GTAQCODE.agent.add({
  name: "build",
  permissions: [],
  model: {
    id: "gpt-5-5",
    provider: "openai",
    variant: "xhigh",
  },
})

const sessionID = await GTAQCODE.session.create({
  agent: "build",
})

GTAQCODE.subscribe((event) => {
  console.log(event)
})

await GTAQCODE.session.prompt({
  sessionID,
  text: "hey what is up",
})

await GTAQCODE.session.prompt({
  sessionID,
  text: "what is up with this",
  files: [
    {
      mime: "image/png",
      uri: "data:image/png;base64,xxxx",
    },
  ],
})

await GTAQCODE.session.wait()

console.log(await GTAQCODE.session.messages(sessionID))
