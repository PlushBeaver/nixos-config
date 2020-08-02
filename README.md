# My NixOS Configuration

## Deployment

**Note:**
you probably don´t need `work`, it´s for my job only
(can be disabled via `inputs.secrets.work.enable`).

Create `secrets` flake from example and register it:

```
nix registry add secrets ~/src/secrets.nix
```

Deploy (`-E` required to access user `secrets`):

```
sudo -E nixos-rebuild switch --flake .
```


## Hardware Setup

```
# Select block device.
export device=/dev/lvm/data

# Create BTRFS and subvolumes.
mkfs.btrfs --uuid 621ae564-a03e-466b-8ba0-8d7830e8d8c8 $device
mount $device /mnt
btrfs subvolume add /mnt/@nixos
btrfs subvolume add /mnt/@home
btrfs subvolume add /mnt/@docker
mkdir /mnt/@nixos/var/lib/docker
umount /mnt

# Mount root filesystem.
mount -t btrfs -o subvol=@nixos $device /mnt

# Mount UFI system partition.
mkdir /mnt/boot
mount /dev/disk/by-uuid/4387-B2FA /mnt/boot
```
