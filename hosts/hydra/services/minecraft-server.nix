# Pending review
{
  lib,
  config,
  pkgs,
  ...
}: let
  publicPort = 25565;
  rconPort = 25575;
  publicBedrockPort = 19132;
in {
  age.secrets.minecraft-server-rcon-password.file = ../../secrets/minecraft-server-rcon-password.age;

  services.nginx.virtualHosts."patus.wesleyjrz.com".root = "/var/lib/minecraft";

  services.minecraft-server = {
    eula = true;
    enable = true;
    package = pkgs.papermc;
    declarative = true;
    openFirewall = true;
    jvmOpts = lib.concatStringsSep " " [
      "-Xmn128M"
      "-Xms2G"
      "-Xmx4G"
      "-XX:+UnlockExperimentalVMOptions"
      "-XX:+UnlockDiagnosticVMOptions"
      "-XX:+AlwaysPreTouch"
      "-XX:+DisableExplicitGC"
      "-XX:+UseNUMA"
      "-XX:NmethodSweepActivity=1"
      "-XX:ReservedCodeCacheSize=400M"
      "-XX:NonNMethodCodeHeapSize=12M"
      "-XX:ProfiledCodeHeapSize=194M"
      "-XX:NonProfiledCodeHeapSize=194M"
      "-XX:-DontCompileHugeMethods"
      "-XX:MaxNodeLimit=240000"
      "-XX:NodeLimitFudgeFactor=8000"
      "-XX:+UseVectorCmov"
      "-XX:+PerfDisableSharedMem"
      "-XX:+UseFastUnorderedTimeStamps"
      "-XX:+UseCriticalJavaThreadPriority"
      "-XX:ThreadPriorityPolicy=1"
      "-XX:AllocatePrefetchStyle=3"
      "-XX:+UseG1GC"
      "-XX:MaxGCPauseMillis=37"
      "-XX:+PerfDisableSharedMem"
      "-XX:G1HeapRegionSize=16M"
      "-XX:G1NewSizePercent=23"
      "-XX:G1ReservePercent=20"
      "-XX:SurvivorRatio=32"
      "-XX:G1MixedGCCountTarget=3"
      "-XX:G1HeapWastePercent=20"
      "-XX:InitiatingHeapOccupancyPercent=10"
      "-XX:G1RSetUpdatingPauseTimePercent=0"
      "-XX:MaxTenuringThreshold=1"
      "-XX:G1SATBBufferEnqueueingThresholdPercent=30"
      "-XX:G1ConcMarkStepDurationMillis=5.0"
      "-XX:GCTimeRatio=99"
      "-XX:+UseLargePages"
      "-XX:LargePageSizeInBytes=2m"
    ];
    serverProperties = {
      server-port = publicPort;
      white-list = true;
      enforce-whitelist = true;
      difficulty = "hard";
      gamemode = "survival";
      force-gamemode = true;
      level-name = "Patus";
      level-seed = "91276453817984294";
      motd = "§2Creepers §r+ §f§cPolítica §r= §f§gDebates explosivos!";
      online-mode = true;
      enforce-secure-profile = false; # NOTE: disable if using mods or cracked accounts.
      player-idle-timeout = 30;
      spawn-protection = 0;
      max-players = 16;
      view-distance = 14;
      simulation-distance = 12;
      op-permission-level = 2;
      # resource-pack = "https://vanillatweaks.net/share#XJpf8k";
      # resource-pack-sha1 = "";
      enable-rcon = true;
      "rcon.port" = rconPort;
      "rcon.password" = config.age.secrets.minecraft-server-rcon-password.plaintext;
    };
    whitelist = {
      ZaaZard = "6a20695b-203f-4458-9ccf-abacd3fbbd50";
      AtomzkyAznable = "7038de1f-a714-4aa1-a6c3-9ed6e8c4a88c";
    };
  };

  networking.firewall = {
    allowedTCPPorts = [rconPort publicBedrockPort];
    allowedUDPPorts = [publicBedrockPort];
  };

  # Enable port forwarding
  boot.kernel.sysctl."net.ipv4.ip_forward" = lib.mkForce 1;

  # Prevent the server from auto-starting
  # systemd.services.minecraft-server = { wantedBy = pkgs.lib.mkForce [ ]; };
}
