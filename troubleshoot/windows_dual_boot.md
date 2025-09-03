# Dual Boot Troubleshooting: Restoring Windows Boot Option

## Common Issue

After reinstalling a Linux OS on a system with Windows on a separate drive, the
Windows boot option is no longer available in the boot menu. The Windows
installation is still present on the other drive, but it's not recognized by the
boot loader.

## Solution

To restore the Windows boot option, you need to rebuild the Boot Configuration
Data (BCD) store using the bcdboot command in the Windows recovery environment.

Steps:

1. Boot into the Windows recovery environment:
2. Open Command Prompt:

- Navigate to "Troubleshoot" > "Advanced options" > "Command Prompt"

3. Identify drive where wndows is installed in

```bash
diskpart 
select disk 0
```

4. Identify the volumes where Windows is installed and the efi partition in that
   drive; usually its a 1024MB Hidden Reserved Partition and assign them the
   letters W:, S: respectively

```bash
# Windows Partition
list volume 
select volume 3
assign letter=:W

# EFI Partition
select volume 1
assing letter=:S
exit
```

4. Run the bcdboot command:

```bash
bcdboot W:\Windows /s S: /f UEFI
```

5. Restart computer the windows boot option should now be visible
