/// <reference path="../markdown.d.ts" />

export * as SkillPlugin from "./skill"

import { define } from "./internal"
import { Effect } from "effect"
import { AbsolutePath } from "../schema"
import { SkillV2 } from "../skill"
import customizeGTAQCODEContent from "./skill/customize-GTAQCODE.md" with { type: "text" }

export const CustomizeGTAQCODEContent = customizeGTAQCODEContent

export const Plugin = define({
  id: "skill",
  effect: Effect.fn(function* (ctx) {
    yield* ctx.skill.transform((draft) => {
      draft.source(
        SkillV2.EmbeddedSource.make({
          type: "embedded",
          skill: SkillV2.Info.make({
            name: "customize-GTAQCODE",
            description:
              "Use ONLY when the user is editing or creating GTAQCODE's own configuration: GTAQCODE.json, GTAQCODE.jsonc, files under .GTAQCODE/, or files under ~/.config/GTAQCODE/. Also use when creating or fixing GTAQCODE agents, subagents, commands, skills, plugins, MCP servers, or permission rules. Do not use for the user's own application code, or for any project that is not configuring GTAQCODE itself.",
            location: AbsolutePath.make("/builtin/customize-GTAQCODE.md"),
            content: CustomizeGTAQCODEContent,
          }),
        }),
      )
    })
  }),
})
