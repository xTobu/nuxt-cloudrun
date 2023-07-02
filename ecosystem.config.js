module.exports = {
  apps: [
    {
      name: "nuxt-cloudrun",
      exec_mode: "cluster",
      instances: 2,
      script: "./.output/server/index.mjs",
    },
  ],
};
