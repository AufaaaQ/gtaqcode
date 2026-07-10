const stage = process.env.SST_STAGE || "dev"

export default {
  url: stage === "production" ? "https://GTAQCODE.ai" : `https://${stage}.GTAQCODE.ai`,
  console: stage === "production" ? "https://GTAQCODE.ai/auth" : `https://${stage}.GTAQCODE.ai/auth`,
  email: "help@anoma.ly",
  socialCard: "https://social-cards.sst.dev",
  github: "https://github.com/anomalyco/GTAQCODE",
  discord: "https://GTAQCODE.ai/discord",
  headerLinks: [
    { name: "app.header.home", url: "/" },
    { name: "app.header.docs", url: "/docs/" },
  ],
}
