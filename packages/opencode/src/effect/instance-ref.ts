import { Context } from "effect"
import type { InstanceContext } from "@/project/instance-context"
import type { WorkspaceV2 } from "@gtaqcode/core/workspace"

export const InstanceRef = Context.Reference<InstanceContext | undefined>("~GTAQCODE/InstanceRef", {
  defaultValue: () => undefined,
})

export const WorkspaceRef = Context.Reference<WorkspaceV2.ID | undefined>("~GTAQCODE/WorkspaceRef", {
  defaultValue: () => undefined,
})
