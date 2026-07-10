import { AgentV2 } from "@gtaqcode/core/agent"
import { AISDK } from "@gtaqcode/core/aisdk"
import { Catalog } from "@gtaqcode/core/catalog"
import { CommandV2 } from "@gtaqcode/core/command"
import { Credential } from "@gtaqcode/core/credential"
import { AppNodeBuilder } from "@gtaqcode/core/effect/app-node-builder"
import { LayerNodePlatform } from "@gtaqcode/core/effect/app-node-platform"
import { LayerNode } from "@gtaqcode/core/effect/layer-node"
import { EventV2 } from "@gtaqcode/core/event"
import { FileSystem } from "@gtaqcode/core/filesystem"
import { FSUtil } from "@gtaqcode/core/fs-util"
import { Integration } from "@gtaqcode/core/integration"
import { Location } from "@gtaqcode/core/location"
import { Npm } from "@gtaqcode/core/npm"
import { PluginV2 } from "@gtaqcode/core/plugin"
import { Reference } from "@gtaqcode/core/reference"
import { SkillV2 } from "@gtaqcode/core/skill"
import { Effect, Layer } from "effect"
import { tempLocationLayer } from "../fixture/location"

const npmLayer = Layer.succeed(
  Npm.Service,
  Npm.Service.of({
    add: () => Effect.succeed({ directory: "", entrypoint: undefined }),
    install: () => Effect.void,
    which: () => Effect.succeed(undefined),
  }),
)

export const PluginTestLayer = AppNodeBuilder.build(
  LayerNode.group([
    FileSystem.node,
    FSUtil.node,
    Location.node,
    Npm.node,
    Credential.node,
    EventV2.node,
    LayerNodePlatform.httpClient,
    PluginV2.node,
    AgentV2.node,
    AISDK.node,
    Catalog.node,
    CommandV2.node,
    Integration.node,
    Reference.node,
    SkillV2.node,
  ]),
  [
    [Location.node, tempLocationLayer],
    [Npm.node, npmLayer],
  ],
)
