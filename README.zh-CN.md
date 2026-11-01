# F1 Reaction Test

[English](README.md) | 简体中文

<img src="Reaction-Test-logo.png" alt="Reaction Test logo" width="280">

一个使用 **Godot 4.7.2 + GDScript** 制作的 2D 赛车起跑灯反应测试小游戏，也是我的第一个独立游戏练习项目。

点击按钮开始，等待五盏红灯全部熄灭，再次点击同一个按钮，测试自己的反应速度。

**[在线游玩](https://uim-g.github.io/F1-reaction/)** | [下载 Windows 版本](https://github.com/uim-g/F1-reaction/releases)

## 玩法

1. 点击 **🟢 START** 开始一局。
2. 五组红灯依次亮起，相邻两组的亮起间隔为 **1 秒**。
3. 第五组亮起后，所有红灯保持点亮，等待随机的 **0.2–3 秒**。
4. 红灯同时熄灭时，立即再次点击按钮。
5. 界面显示反应时间，例如 `0.213 s`。数值越小，反应越快。
6. 点击 **BACK** 返回初始 START 界面，再点击 START 才会开始下一局。

如果在红灯熄灭前提前点击，会显示 **FALSE START**，本局判定为抢跑。点击 BACK 可以返回初始界面。

电脑端使用鼠标点击，手机浏览器使用触摸操作，不需要按空格。游戏的计时从红灯熄灭时开始，到按钮被按下时结束。

点击 **Licenses** 可查看许可声明，点击 **OK** 关闭窗口。

> 这是用于娱乐和学习的反应测试。显示、输入设备及运行环境的延迟都会影响成绩，不适合用于精确的生理反应测量。0.2–3 秒是本游戏采用的模拟参数，不代表现行 F1 规则强制规定的范围。

## 当前功能

- 五组红灯自动依次点亮、同时熄灭。
- 全亮后随机等待，避免通过固定节奏预判起跑。
- 提前点击判定抢跑。
- 反应时间显示到小数点后三位，单位为秒。
- 成绩或抢跑后返回 START，再手动开始下一局。
- 英文界面提示与 Emoji，脚本附有中文注释。
- 已完成 Windows 版本导出，并在本机测试可运行。
- 网页版已部署到 GitHub Pages，可直接在线游玩。
- 内置英文和 Emoji 字体，避免网页版缺少字形。
- 游戏内可查看完整许可声明的 Licenses 窗口。
- 已修复并验证手机浏览器单次触摸重复触发按钮的问题。

## 运行游戏

### Windows 可玩版本

已发布的 Windows 可玩版本可在本仓库的 [Releases](https://github.com/uim-g/F1-reaction/releases) 下载。

对于 **v0.1.2**：

1. 打开 [v0.1.2 发布页面](https://github.com/uim-g/F1-reaction/releases/tag/v0.1.2)，在 **Assets（附件）** 中下载 `F1ReactionTest.exe`。
2. 直接运行 EXE，无需解压 ZIP、配套 PCK 文件或安装 Godot。
3. 点击游戏中的 **Licenses**，查看项目、字体、Godot 及第三方组件的许可声明。

旧版打包方式不同：v0.1.1 需要先解压 ZIP，其中的 EXE 已内嵌 PCK；v0.1.0 还需要将配套的 `F1ReactionTest.pck` 与 EXE 放在一起。旧版附带的其他运行文件也应保持原有相对位置。

### 从源码运行

1. 安装 **Godot 4.7.2 普通版**，本项目使用 GDScript，无需 .NET 版。
2. 下载或克隆本仓库。
3. 在 Godot 项目管理器中点击 **Import（导入）**，选择 `project.godot`。
4. 打开项目，等待图片等资源导入完成。
5. 按 **F5** 运行项目；按 **F8** 停止运行。

项目当前使用 **Forward+** 渲染器，Windows 图形驱动设置为 **Direct3D 12**，需要支持这些设置的运行环境。

### 网页版本

网页版已上线：[点击在线游玩](https://uim-g.github.io/F1-reaction/)。打开链接，等待加载完成后即可使用同样的按钮操作，无需安装。Web 导出使用 Compatibility（兼容）渲染器，并关闭线程支持。测试反应时请保持游戏标签页处于前台，切换到后台可能使游戏暂停或减慢。

## 项目结构

```text
.
├── project.godot                 # 项目设置与主场景入口
├── main.tscn                     # 游戏界面与许可证弹窗
├── main.gd                       # 游戏流程、反应计时与许可文本读取
├── main.gd.uid                   # Godot 脚本资源标识
├── Reaction-Test-logo.png        # 游戏界面使用的 Logo
├── Reaction-Test-logo.png.import # 图片导入设置
├── fonts/                        # 英文与 Emoji 字体、导入配置及 ui_font.tres
│   └── license/                  # 分别保留两份字体的许可证
├── export_presets.cfg            # Windows 与 Web 导出配置
├── .gitignore                    # 缓存与本地导出文件的忽略规则
├── LICENSE                       # MIT 许可证
├── README.md                     # 英文项目说明
└── README.zh-CN.md               # 中文项目说明
```

`.godot/` 是 Godot 自动生成的缓存目录，重新打开项目时会生成，不需要提交到 Git。`exports/` 中的本地导出文件和根目录的 Windows 成品也由 `.gitignore` 排除。Windows 可玩版本通过 Releases 分发；网站由 `gh-pages` 分支的 `docs/` 目录发布，`main` 分支保存可编辑的项目源码。从源码运行或修改时，请保留字体文件、导入配置及所有许可证文件。

## 调整游戏节奏

在 `main.gd` 顶部可以修改以下参数，时间单位均为秒：

```gdscript
const LIGHT_INTERVAL: float = 1.0
const MIN_WAIT: float = 0.2
const MAX_WAIT: float = 3.0
```

- `LIGHT_INTERVAL`：相邻两组灯亮起的间隔。
- `MIN_WAIT`：第五组亮起后，随机等待的最短时间。
- `MAX_WAIT`：第五组亮起后，随机等待的最长时间。

修改后重新运行，即可观察节奏变化。

## 项目性质与许可

这是一个非官方的个人学习项目，与 Formula 1、FIA 及相关组织没有隶属、授权或背书关系。

本项目采用 [MIT 许可证](LICENSE)，版权署名为 Copyright (c) 2026 uim-g。第三方组件和素材（如有）仍遵循其各自的许可证；本项目许可证不授予第三方名称或商标的使用权。

本项目使用 **Godot Engine**，引擎采用 MIT 许可证，详见 [Godot Engine License](https://godotengine.org/license/)。引擎许可证与本项目代码、Logo 及其他素材的许可分别适用。

项目内置的字体分别遵循各自的许可证：

- Open Sans：显示英文，详见[字体许可](fonts/license/open-sans/OFL.txt)。
- Noto Color Emoji：作为 Emoji 备用字体，详见[字体许可](fonts/license/noto-emoji/LICENSE.txt)。

## 导出许可声明

许可证窗口会从导出项目中读取 `LICENSE` 和两份字体许可文件。Windows、Web 两个导出预设的 **资源 → 导出非资源文件的过滤器** 都需要包含：

```text
LICENSE,fonts/license/open-sans/OFL.txt,fonts/license/noto-emoji/LICENSE.txt
```

发布单个 Windows EXE 时保持 **Embed PCK（内嵌 PCK）** 开启。导出后，将 EXE 单独复制到空文件夹中测试，确认 Licenses 能显示许可内容且没有文件读取错误。Godot 引擎许可及其所含第三方组件的版权与许可信息由 Engine 接口读取。
