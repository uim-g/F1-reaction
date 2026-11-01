# F1 Reaction Test

English | [简体中文](README.zh-CN.md)

<img src="Reaction-Test-logo.png" alt="Reaction Test logo" width="280">

A 2D racing-start reaction game built with **Godot 4.7.2 and GDScript**. This is my first independent game development learning project.

Start a round, wait for all five red lights to go out, then click the same button again to measure your reaction time.

**[Play in your browser](https://uim-g.github.io/F1-reaction/)** | [Download for Windows](https://github.com/uim-g/F1-reaction/releases)

## How to play

1. Click **🟢 START** to begin.
2. Five red light groups illuminate sequentially, **one second apart**.
3. Once the fifth group lights up, all lights remain on for a random **0.2–3 seconds**.
4. When all red lights go out together, click the button as quickly as possible.
5. Your reaction time appears in seconds, for example `0.213 s`. Lower is faster.
6. Click **BACK** to return to the initial START screen. Click START again to begin another round.

Clicking before the lights go out results in a **FALSE START**. Click BACK to return to the initial screen.

Use mouse clicks on desktop or taps in a mobile browser; the space bar is not required. Timing starts when the lights go out and stops when the button is pressed.

Click **Licenses** to view the license notices. Close the dialog using **OK**.

> This game is for entertainment and learning. Display, input-device, and runtime latency affect the result, so it is not a precision physiological measurement. The 0.2–3-second hold is a simulation setting, not a claim about a mandatory interval in current F1 regulations.

## Features

- Five automatic, sequential red lights with simultaneous lights-out.
- A random hold after the fifth light.
- False-start detection.
- Reaction times displayed in seconds to three decimal places.
- An explicit return to START after a result or false start.
- English interface text with emoji and Chinese code comments.
- A Windows build exported and tested locally.
- A playable browser build hosted on GitHub Pages.
- Bundled English and emoji fonts for consistent glyph support in web builds.
- An in-game Licenses dialog with full license notices.
- A verified fix for duplicate button activation in mobile browsers.

## Running the game

### Windows build

Download published Windows builds from this repository's [Releases](https://github.com/uim-g/F1-reaction/releases).

For **v0.1.2**:

1. Open the [v0.1.2 release](https://github.com/uim-g/F1-reaction/releases/tag/v0.1.2) and download `F1ReactionTest.exe` from **Assets**.
2. Run the EXE directly. No ZIP extraction, separate PCK file, or Godot installation is required.
3. Click **Licenses** in the game to read the project, font, Godot, and third-party license notices.

Older releases use different packaging: extract the v0.1.1 ZIP before running its embedded-PCK EXE; v0.1.0 also requires its matching `F1ReactionTest.pck` beside the EXE. Keep any other runtime files supplied with an older release in their original relative locations.

### Run from source

1. Install the **standard edition of Godot 4.7.2**. This project uses GDScript, so the .NET edition is not required.
2. Download or clone this repository.
3. In the Godot Project Manager, click **Import** and select `project.godot`.
4. Open the project and wait for its assets to finish importing.
5. Press **F5** to run the project or **F8** to stop it.

The current project uses the **Forward+** renderer and **Direct3D 12** on Windows. The runtime environment must support these settings.

### Web version

The Web version is live on [GitHub Pages](https://uim-g.github.io/F1-reaction/). Open the link, wait for loading to finish, and play using the same button controls. No installation is required. The Web preset uses the Compatibility renderer with thread support disabled. Keep the game tab active during a round; background tabs can pause or throttle the game.

## Project structure

```text
.
├── project.godot                 # Project settings and main scene
├── main.tscn                     # Game interface and license dialog
├── main.gd                       # Game logic and license text loading
├── main.gd.uid                   # Godot script resource identifier
├── Reaction-Test-logo.png        # Game interface logo
├── Reaction-Test-logo.png.import # Image import settings
├── fonts/                        # English/emoji fonts, import settings, and ui_font.tres
│   └── license/                  # Separate license notices for each font
├── export_presets.cfg            # Windows and Web export configuration
├── .gitignore                    # Cache and local build exclusions
├── LICENSE                       # MIT license
├── README.md                     # English documentation
└── README.zh-CN.md               # Simplified Chinese documentation
```

The `.godot/` directory contains generated caches and is recreated by Godot. It is excluded from version control. Local exports in `exports/` and the root Windows build files are also excluded by `.gitignore`. Windows packages are distributed through Releases. The live website is published from `docs/` on the `gh-pages` branch; the `main` branch contains the editable project source. Keep the bundled fonts, their import settings, and all license files when running or modifying the source.

## Adjusting the timing

The following constants at the top of `main.gd` control the sequence. All values are in seconds:

```gdscript
const LIGHT_INTERVAL: float = 1.0
const MIN_WAIT: float = 0.2
const MAX_WAIT: float = 3.0
```

- `LIGHT_INTERVAL`: time between consecutive light groups turning on.
- `MIN_WAIT`: shortest hold after the fifth light turns on.
- `MAX_WAIT`: longest hold after the fifth light turns on.

Run the project again after making changes.

## Project status and licensing

This is an unofficial personal learning project. It is not affiliated with, authorized by, or endorsed by Formula 1, the FIA, or related organizations.

This project is licensed under the [MIT License](LICENSE). Copyright (c) 2026 uim-g. Third-party components and assets, if any, remain subject to their respective licenses. This license does not grant rights to third-party names or trademarks.

This project uses **Godot Engine**, which is available under the MIT license. See the [Godot Engine License](https://godotengine.org/license/). The engine license is separate from the licensing of this project's code, logo, and other assets.

Bundled fonts have their own licenses:

- Open Sans: English text; see [license notice](fonts/license/open-sans/OFL.txt).
- Noto Color Emoji: emoji fallback; see [license notice](fonts/license/noto-emoji/LICENSE.txt).

## Exporting license notices

The license dialog reads `LICENSE` and the font license files from the exported project. For both Windows and Web presets, keep these entries in **Resources > Filters to export non-resource files**:

```text
LICENSE,fonts/license/open-sans/OFL.txt,fonts/license/noto-emoji/LICENSE.txt
```

Keep **Embed PCK** enabled for the standalone Windows EXE. After exporting, test the EXE by itself in an empty folder and confirm that the Licenses dialog contains the notices without a file-loading error. The dialog obtains Godot's license text and bundled third-party copyright/license information through the Engine API.
