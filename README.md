# whip_onx_vehicles

Registers **ONX CVP / EVP** vehicle packs into the [WHIP](https://whipfx.net/docs/) vehicle catalog, with display names, GTA classes, and bank valuation prices.

This resource does **not** stream vehicle models. You still need the official ONX packs installed and started. It only tells `whip_core` which `onx_*` models exist so they appear in dealerships, garages, `/whip` Banks valuation, and the rest of the WHIP vehicle system.

Community resource for the [WHIPFX Discord](https://whipfx.net/). Not an official WHIPFX release.

Repository: https://github.com/fear0911fivem/whip_onx_vehicles

## Requirements

- [whip_core](https://github.com/WHIPFX/whip_core) **1.0+** (and the rest of a normal WHIP install)
- Your **ONX CVP / EVP** stream packs (purchased separately from ONX), started so the `onx_*` models exist in-game

## Installation

1. Clone or download this resource into your server `resources` folder:

```bash
cd resources
git clone https://github.com/OkanFeNwa/whip_onx_vehicles.git
```

Or unzip a release so the folder is named `whip_onx_vehicles`.

2. Make sure your ONX vehicle packs are installed and ensured (shared, audio, lightbars, and the pack folders you own). Example pattern from a WHIP server:

```cfg
## ONX vehicle stream packs (your purchased assets)
ensure onx-cvp-a-shared
ensure onx-cvp-b-audio
ensure onx-cvp-c-pack
# …plus any other ONX CVP/EVP packs you run

ensure onx-evp-a-shared
ensure onx-evp-b-audio
ensure onx-evp-b-lightbars
# …etc.
```

3. In `server.cfg`, add this **after `whip_core`** (and after the ONX stream packs):

```cfg
ensure whip_onx_vehicles
```

4. Restart the server, or run `refresh` then `ensure whip_onx_vehicles`.

On a successful start you should see:

```text
[whip_onx_vehicles] registered 210 ONX vehicles into the WHIP catalog
```

- `dependency 'whip_core'` and `@whip_core/lib/satellite.lua` are already in the manifest.
- No edits to `whip_core` are required.

## What it does

On start, inside `Whip.register`:

1. **`RegisterVehicles`** — pushes the list in `vehicles.lua` into WHIP’s catalog (`model`, `name`, `class`).
2. **`SetVehiclePrices`** — sets a class-based dollar value for each model (used by `/whip` Banks for owned-vehicle valuation).

When you stop the resource, WHIP drops that pack’s catalog entries and prices again.

## Customising

### Add or remove a vehicle

Edit `vehicles.lua`. Each row is:

```lua
{ model = 'onx_alamo', name = 'Alamo 2600LX', class = 'suvs' },
```

- `model` — spawn name (must match the ONX stream pack)
- `name` — catalog display name
- `class` — one of WHIP’s class names:  
  `compacts`, `sedans`, `suvs`, `coupes`, `muscle`, `sportsclassics`, `sports`, `super`, `motorcycles`, `offroad`, `industrial`, `utility`, `vans`, `boats`, `helicopters`, `planes`, `service`, `emergency`, `military`, `commercial`, `trains`, `openwheel`

Only include models you actually stream. A model that is not in-game will show as not available in the catalog (`inGame == false`).

### Change prices

Default prices by class live at the top of `server/main.lua` (`CLASS_PRICE`). Unknown classes fall back to `DEFAULT_PRICE` (40000). Restart or `ensure` the resource after edits.

## Files

| File | Role |
| --- | --- |
| `fxmanifest.lua` | WHIP satellite manifest (`whip_requires '1.0'`) |
| `vehicles.lua` | Full ONX model list (`OnxVehicles`) |
| `server/main.lua` | `RegisterVehicles` + `SetVehiclePrices` |

## Support

Share issues and feedback in the **WHIPFX Discord** community channels. For broken stream models, missing liveries, or pack updates, use ONX’s own support — this script only registers names into WHIP.

## License / credits

- WHIP framework: [WHIPFX](https://github.com/WHIPFX)
- Vehicle models: **ONX** (CVP / EVP packs — you must own the packs you stream)
- Catalog bridge: this resource
