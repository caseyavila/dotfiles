# Desktop PC Kernel Configuration
# Run from kernel source root directory

# Ryzen 5 1600X
./scripts/config --disable GENERIC_CPU
./scripts/config --enable MK8
./scripts/config --enable X86_AMD_PLATFORM_DEVICE
./scripts/config --enable PERF_EVENTS_AMD_POWER
./scripts/config --enable X86_POWERNOW_K8
./scripts/config --enable X86_AMD_FREQ_SENSITIVITY
./scripts/config --enable AMD_IOMMU_V2
./scripts/config --enable SENSORS_K10TEMP

# Filesystems
./scripts/config --enable F2FS_FS
./scripts/config --enable FUSE_FS
./scripts/config --enable EXFAT_FS
./scripts/config --enable NTFS_FS

# Electron...
./scripts/config --enable USER_NS

# Virtualization
./scripts/config --enable KVM
./scripts/config --enable KVM_AMD
./scripts/config --enable TUN
./scripts/config --enable BRIDGE
./scripts/config --enable VHOST_NET

# Bluetooth (bluez)
./scripts/config --enable BT
./scripts/config --enable BT_HCIBTUSB
./scripts/config --enable BT_RFCOMM
./scripts/config --enable BT_RFCOMM_TTY
./scripts/config --enable BT_BNEP
./scripts/config --enable BT_BNEP_MC_FILTER
./scripts/config --enable BT_BNEP_PROTO_FILTER
./scripts/config --enable BT_HIDP
./scripts/config --enable RFKILL
./scripts/config --enable CRYPTO_USER
./scripts/config --enable CRYPTO_USER_API
./scripts/config --enable CRYPTO_USER_API_AEAD
./scripts/config --enable CRYPTO_USER_API_HASH
./scripts/config --enable CRYPTO_USER_API_SKCIPHER

# USB Device Battery Info
./scripts/config --enable HID_BATTERY_STRENGTH

# Disable Intel Graphics
./scripts/config --disable DRM_I915

# Audio
./scripts/config --enable SND_HDA_CODEC_REALTEK
./scripts/config --enable SND_INTEL8X0
./scripts/config --enable SND_USB_AUDIO

# Multimedia (Webcam)
./scripts/config --enable MEDIA_SUPPORT
./scripts/config --enable MEDIA_CAMERA_SUPPORT
./scripts/config --enable MEDIA_USB_SUPPORT
./scripts/config --enable USB_VIDEO_CLASS
