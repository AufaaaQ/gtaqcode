export * as PublicEventManifest from "./public-event-manifest"

import { Event } from "@gtaqcode/schema/event"
import { EventManifest } from "@gtaqcode/schema/event-manifest"

export const Definitions = EventManifest.ServerDefinitions
export const Latest = Event.latest(Definitions)
