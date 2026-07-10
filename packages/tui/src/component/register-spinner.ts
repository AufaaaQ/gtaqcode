import { getComponentCatalogue } from "@opentui/solid/components"
import { registerSpinner } from "opentui-spinner/solid"

export function registerGTAQCODESpinner() {
  if (!getComponentCatalogue().spinner) registerSpinner()
}
