# Flatpak Troubleshooting: Bottles Fails to Launch on NixOS (Hyprland + NVIDIA)

## Common Issue

When launching Bottles (com.usebottles.bottles) on NixOS with Hyprland and an
NVIDIA GPU, the application fails with errors such as:

    bwrap: Can't find source path /run/user/1000/doc/by-app/com.usebottles.bottles
    Unable to load libGLX_nvidia.so.0

Symptoms include:

- App fails to start due to missing /run/user/1000/doc/... paths.
- App starts but shows a black window, with logs complaining about
  libGLX_nvidia.so.0.

---

## Solution 1: Fix Missing Document Portal Path

The Flatpak sandbox relies on xdg-document-portal to mount /run/user/1000/doc.
Sometimes the expected by-app/... directory is missing.

Steps:

1. Verify the portal is running: systemctl --user status xdg-document-portal

2. If the service is active but the path is missing, manually create it: mkdir
   -p /run/user/1000/doc/by-app/com.usebottles.bottles

3. Relaunch Bottles: flatpak run com.usebottles.bottles

---

## Solution 2: Fix NVIDIA Driver Mismatch

Flatpak requires driver extension runtimes that match the host NVIDIA driver
exactly. If they don’t match, you’ll get errors like:

    Unable to load libGLX_nvidia.so.0
    Unable to locate libGLX_nvidia

Steps:

1. Check your host driver version: nvidia-smi --query-gpu=driver_version
   --format=csv,noheader

   Example output: 580.82.09

2. Search for the matching Flatpak extensions: flatpak remote-ls flathub | grep
   nvidia-580

3. Install both 64-bit and 32-bit versions: flatpak install flathub
   org.freedesktop.Platform.GL.nvidia-580-82-09//1.4 flatpak install flathub
   org.freedesktop.Platform.GL32.nvidia-580-82-09//1.4

4. Verify installation: flatpak list --runtime | grep nvidia

5. Relaunch Bottles: flatpak run com.usebottles.bottles

---

## Notes

- If the black window persists, try forcing software rendering (diagnostic
  only): flatpak run --env=LIBGL_ALWAYS_SOFTWARE=1 com.usebottles.bottles

- Ensure you are running Flatpak apps inside your Hyprland session (not from a
  bare TTY).

- On NixOS, always keep services.flatpak.enable = true; and portals enabled in
  your configuration.

---
