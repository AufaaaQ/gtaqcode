import path from "path"

process.env.GTAQCODE_DB = ":memory:"
process.env.GTAQCODE_MODELS_PATH = path.join(import.meta.dir, "plugin", "fixtures", "models-dev.json")
process.env.GTAQCODE_DISABLE_MODELS_FETCH = "true"
