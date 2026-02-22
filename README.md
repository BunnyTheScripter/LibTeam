# 📦 Required Placement

## 1️⃣ ReplicatedStorage

Place:

```
ReplicatedStorage
└── ThunderFramework
    └── NotificationSystem
        └── NotifactionRemoteEvent
```

---

## 2️⃣ StarterGui

Place:

```
StarterGui
└── Notifeus (ScreenGui)
    └── NotificationFrame
        ├── Container
        └── Template
            ├── Title (TextLabel)
            ├── Message (TextLabel)
            ├── Image (ImageLabel)
            └── UIStroke (optional)
```

> [!IMPORTANT]
> `Template.Visible` must be **false**.
>
> The system clones this frame when creating notifications.

---

# 🚀 How To Use The Module

Require the module from **ReplicatedStorage**, ( note that this is not the path in the roblox studio packet, you need to check manually) :

```lua
local Notifeus = require(game.ReplicatedStorage.Notifeus)
```

Then call:

```lua
Notifeus:Notify(
    message,
    duration,
    backgroundColor,
    title,
    titleColor,
    imageId,
    textColor,
    player,     -- optional (server only)
    useTween
)
```

---

# 📘 API Reference

## `Notifeus:Notify()`

```lua
Notifeus:Notify(
    message: string,
    duration: number,
    backgroundColor: Color3,
    title: string,
    titleColor: Color3,
    imageId: string,
    textColor: Color3,
    player: Player?, -- optional
    useTween: boolean
)
```

---

## 🧾 Parameters Explained

| Parameter        | Type      | Description |
|------------------|-----------|------------|
| message          | string    | Main notification text |
| duration         | number    | Seconds before removal |
| backgroundColor  | Color3    | Frame background color |
| title            | string    | Title text |
| titleColor       | Color3    | Title color |
| imageId          | string    | rbxassetid:// image |
| textColor        | Color3    | Message text color |
| player           | Player?   | Target player (server only) |
| useTween         | boolean   | Enables animation |

---

# 🖥 Client Example (LocalScript)

Place inside:
- StarterPlayerScripts
- StarterGui
- Tool
- Any LocalScript

```lua
local Notifeus = require(game.ReplicatedStorage.Notifeus)

Notifeus:Notify(
    "Welcome to the game!",
    4,
    Color3.fromRGB(30, 30, 30),
    "Hello",
    Color3.fromRGB(255, 255, 255),
    "rbxassetid://123456789",
    Color3.fromRGB(255, 255, 255),
    nil,
    true
)
```

---

# 🌍 Server Example (All Players)

Place inside **ServerScriptService**:

```lua
local Notifeus = require(game.ReplicatedStorage.Notifeus)

Notifeus:Notify(
    "Server restarting in 1 minute!",
    5,
    Color3.fromRGB(120, 20, 20),
    "Warning",
    Color3.fromRGB(255, 255, 255),
    "rbxassetid://123456789",
    Color3.fromRGB(255, 255, 255),
    nil,
    true
)
```

---

# 👤 Server Example (Specific Player)

```lua
local Players = game:GetService("Players")
local Notifeus = require(game.ReplicatedStorage.Notifeus)

local player = Players:GetPlayers()[1]

Notifeus:Notify(
    "You received 500 coins!",
    4,
    Color3.fromRGB(20, 120, 20),
    "Reward",
    Color3.fromRGB(255, 255, 255),
    "rbxassetid://123456789",
    Color3.fromRGB(255, 255, 255),
    player,
    true
)
```

---

# 🎨 Template Customization Guide

The `Template` inside:

```
StarterGui > Notifeus > NotificationFrame > Template
```

is the base notification design.

You can safely edit:

- Size
- Corner radius
- Fonts
- TextScaled
- UIStroke
- UIGradient
- Padding
- Layout

The system only changes:

- Title.Text
- Message.Text
- Image.Image
- Colors
- Visibility
- Tween properties

---

## 🧠 How Template Cloning Works

1. Template is cloned
2. Values are applied
3. Tween plays (if enabled)
4. Waits `duration`
5. Fades out
6. Destroyed

You can redesign the UI freely as long as:

- Title exists
- Message exists
- Image exists

---

# 🎞 Animation System

If `useTween = true`:

- Background fades in
- Frame pops in (Back easing)
- Text fades in
- Smooth fade out before destroy

Tween styles used:

- Quint
- Back
- Sine

> [!TIP]
> Best duration range: **2–6 seconds**

---

# 🧪 Debug Mode

Inside the ModuleScript:

```lua
local debug = true
```

When enabled, it prints notification data.

> [!NOTE]
> Disable debug before publishing your game.

---

# ⚠️ Common Mistakes

> [!CAUTION]
> Do NOT rename:
>
> `ThunderFramework`
> `NotificationSystem`
> `NotifactionRemoteEvent`

> [!CAUTION]
> Do NOT delete the RemoteEvent if using server notifications.

> [!CAUTION]
> Do NOT set Template.Visible to true.

> [!CAUTION]
> ModuleScript must stay inside ReplicatedStorage.

---

# ✅ Final Checklist

- [ ] ThunderFramework inside ReplicatedStorage
- [ ] Notifeus ModuleScript inside ReplicatedStorage
- [ ] Notifeus ScreenGui inside StarterGui
- [ ] Template.Visible = false
- [ ] RemoteEvent not renamed

---

# 🔔 Notifeus

Lightweight  
Animated  
Client + Server  
Plug & Play  

Ready to use.
