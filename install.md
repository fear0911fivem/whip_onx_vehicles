# Installing ONX vehicle images on WHIP

WHIP does **not** auto-load pictures from a random folder. For add-on cars, [whip_core](https://github.com/WHIPFX/whip_core) only shows a picture when `RegisterVehicles` gets an `image` path, and that file is listed in the resource `files {}` block.

Official reference: `whip_core/docs/addon-vehicles.html` and `whip_core/docs/examples/whip_addon_vehicles/`.

This repo is already wired for that. Use **Option A** if you just installed `whip_onx_vehicles`. Use **Option B** only if you are merging the image support into another resource yourself.

---

## Option A — Use this resource as shipped (recommended)

No edits to `whip_core`. No copy into `whip_media_previews`.

1. Keep the `images/` folder next to `fxmanifest.lua` (one `.webp` per model, e.g. `images/onx_alamo.webp`).
2. Keep `vehicles.lua` rows with an `image` field (already done in this repo).
3. Keep this in `fxmanifest.lua`:

```lua
files {
    'images/*.webp',
}
```

4. Ensure after `whip_core` and your ONX stream packs:

```cfg
ensure whip_onx_vehicles
```

5. Restart, or `refresh` + `ensure whip_onx_vehicles`.

Console success line:

```text
[whip_onx_vehicles] registered 210 ONX vehicles into the WHIP catalog
```

Dealership / garage / Banks UI should then resolve each model’s picture from this resource (`cfx-nui-whip_onx_vehicles/...`).

---

## Option B — What WHIP needs (code locations)

If you are teaching someone, or wiring images by hand, these are the only two places that matter.

### 1. `fxmanifest.lua` — declare the image files

`RegisterVehicles` refuses an `image` that is not in `files {}`.

Add:

```lua
files {
    'images/*.webp',
}
```

Full ready `fxmanifest.lua` (no comments):

```lua
fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'whip_onx_vehicles'
description 'Registers ONX CVP/EVP vehicle packs into the WHIPFX Vehicle catalog'
version '1.0.0'

dependency 'whip_core'
whip_requires '1.0.1'

shared_scripts {
    '@whip_core/lib/satellite.lua',
}

server_scripts {
    'vehicles.lua',
    'server/main.lua',
}

files {
    'images/*.webp',
}
```

### 2. `vehicles.lua` — point each model at its picture

Each catalog row must include `image` relative to this resource:

```lua
{ model = 'onx_alamo', name = 'Alamo 2600LX', class = 'suvs', image = 'images/onx_alamo.webp' },
```

Pattern:

```lua
image = 'images/<model>.webp'
```

The filename must match the spawn name. Example before → after:

```lua
{ model = 'onx_alamo', name = 'Alamo 2600LX', class = 'suvs' },
```

```lua
{ model = 'onx_alamo', name = 'Alamo 2600LX', class = 'suvs', image = 'images/onx_alamo.webp' },
```

This repo’s `vehicles.lua` already has all **210** rows with `image` set. Do not paste into `whip_core`.

### 3. `server/main.lua` — no image code needed

`Whip.core:RegisterVehicles(OnxVehicles)` already passes the `image` field through. Leave prices as they are.

---

## Do not put ONX pictures in whip_core

Vanilla WHIP media packs use `img/vehicles/<model>.webp` inside something like `whip_media_previews`. That path is for WHIP’s stock catalog.

For ONX add-ons, prefer this satellite resource:

| Wrong for ONX packs | Correct for this resource |
| --- | --- |
| Edit `whip_core` | Leave `whip_core` alone |
| Drop files into `whip_media_previews/img/vehicles/` | Keep files in `whip_onx_vehicles/images/` |
| Register model with no `image` | Set `image = 'images/<model>.webp'` + `files { 'images/*.webp' }` |

---

## Folder layout

```text
whip_onx_vehicles/
  fxmanifest.lua          ← files { 'images/*.webp' }
  vehicles.lua            ← image = 'images/<model>.webp' on every row
  server/main.lua         ← RegisterVehicles + SetVehiclePrices
  images/
    onx_alamo.webp
    onx_ambassador.webp
    ...
```

---

## Checklist

- [ ] `images/<model>.webp` exists for every row in `vehicles.lua`
- [ ] `fxmanifest.lua` has `files { 'images/*.webp' }`
- [ ] Every row has `image = 'images/<model>.webp'`
- [ ] ONX stream packs are ensured so `inGame` is true
- [ ] `ensure whip_onx_vehicles` runs after `whip_core`
- [ ] Resource restarted after changing images or the list

If `RegisterVehicles` prints a picture error, the path is wrong or the file is missing from `files {}`.
