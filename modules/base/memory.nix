{
  zramSwap = {
    enable = true;
    memoryPercent = 100;
    algorithm = "zstd";
    priority = 100;
  };

  # Swapping to zram is cheap; prefer it over dropping page cache
  boot.kernel.sysctl = {
    "vm.swappiness" = 150;
    "vm.page-cluster" = 0;
  };

  # MGLRU: OOM-kill rather than thrash once the working set is gone
   systemd.tmpfiles.rules = [ "w /sys/kernel/mm/lru_gen/min_ttl_ms - - - - 1000" ];

   systemd.oomd.enable = false;
   services.earlyoom = {
     enable = true;
     freeMemThreshold = 5;     # % RAM
     freeSwapThreshold = 10;   # % swap
     enableNotifications = true;
     extraArgs = [
       "--avoid" "(^|/)(umbriel|systemd|sshd|Xwayland|amane-shell|helium)$"
       "--prefer" "(^|/)(chrome|electron|java|node)$"
     ];
   };
}
