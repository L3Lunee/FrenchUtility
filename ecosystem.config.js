module.exports = {
  apps: [
    {
      name: "french-utility",
      script: "start.sh",
      interpreter: "bash",
      env: { NODE_ENV: "production" },
    },
  ],
};
