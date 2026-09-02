## Installation

### Windows

1. Install [MSYS2](https://www.msys2.org/).
2. Configure `Bootable\install.sh` to open with `C:\msys64\ucrt64.exe`.
3. Double-click `Bootable\install.sh`.

## Build and Run

### Windows

1. Double-click one of the following:
   - `Bootable\MBR\run.sh`
   - `Bootable\UEFI\run.sh`

## Deploy

### Windows

#### MBR

1. Prepare an unused USB flash drive.
2. Install [HxD](https://mh-nexus.de/en/hxd/).
3. Run HxD as an administrator.
4. Select **Tools → Open disk** from the menu bar.
5. Select **Physical disks → Removable disk** (your unused USB flash drive).
6. Uncheck **Open as Readonly**.
7. Click **OK**.
8. Click **OK** to accept the warning.
9. In the menu bar, change **Bytes per row** to `8` (the default is 16).
10. Open `Bootable\MBR\out\MBR.raw`.
11. Select all bytes from offset `0` to the last byte.
12. Copy the selected bytes from `MBR.raw`.
13. Switch to the removable disk tab.
14. Select the same offset and range.
15. Right-click and select **Paste Write**.
16. Save the disk.
17. Your USB flash drive is now ready to boot using BIOS.

---

##### Restoring the USB flash drive

1. Select all data in **Sector 0** of the USB flash drive, from offset `0` to the line before offset `0x200`.
2. Right-click and select **Fill selection**, then fill every byte with `00`.
3. Save the disk.
4. Use Windows Explorer to format the USB flash drive.

#### UEFI

1. Prepare an unused USB flash drive.
2. Use Windows Explorer to format the USB flash drive as **FAT32**.
3. Copy `efi\boot\bootx64.efi` to the USB flash drive. Make sure `bootx64.efi` is located inside the `efi\boot` directory.
4. Your USB flash drive is now ready to boot using UEFI.