---
name: mc-dim-render
description: 使用 mc_dim_render CLI 离线校验、定位（locate）、单点探针查询（probe）和俯视渲染网易《我的世界》基岩版自定义维度（主世界/下界/末地/超平坦）、群系管线、地表材质图案与地物/拼图结构。制作、修改或排查自定义维度、群系、feature_rules、.mcstructure 及大型拼图结构时使用。
---

# mc_dim_render

- 首次使用或不确定参数时，先运行 `mc_dim_render help` 读取完整子命令、参数选项、退出码与 JSON 返回结构（若未加入 `PATH`，依次检查 `$env:MC_DIM_RENDER_EXE` 或当前仓库 `build/mc_dim_render.exe`）。
- AI 自测迭代一律保持无头静默（不加 `--gui`）；仅当用户明确要求打开预览窗口时再启动 `gui`。
- 验证顺序：修改配置后先 `validate`（退出码恒为 `0`，以返回 JSON 的 `.valid` 布尔值为准），再用 `locate-biome` / `locate-structure` / `probe` / `render` 验证并导出 PNG，且**必须用看图工具实际查看导出的 PNG** 确认地形、群系过渡、贴图取色与结构落位。
- 收尾必须清理验证过程中生成的临时 `.png` 与 `.json` 报告，只保留模组正式文件。
- 网易 `3.10` 自定义维度关键避坑：
  - 维度配置同时支持**完整写法**（`dimension_config.json` + `dm<维度ID>.json` 显式声明 `netease:biome_source`）与**省略写法**（仅写 `dimension_config.json` 的 `modDimensionId`，自动沿用主世界群系管线并按后缀映射 `dm<维度ID>_<原版群系>`）。
  - 不带命名空间的 `dm<维度ID>_<后缀>` 群系，`<后缀>` 必须为合法原版群系名；全新群系请加自定义命名空间。
  - `netease:biome_source` 推荐串联 `6~8` 个 `*_zoom_2x` 控制斑块大小；真虚空群系在主世界类型自定义维度中通过 `"netease:overworld_surface"` 配置 `fill` (`min_height: 0, max_height: 255, fill_block: "minecraft:air"`，注意 `max_height < 256` 且左闭右开)；启用 `surface_material_adjustments` 时群系 JSON 需使用 `"minecraft:surface_builder"`。
  - `netease_large_feature_rules` 的 `"place_pool"` 须写在 `"description"` 内，`allowed_biomes` 按群系 **tag** 匹配；维度禁用原版结构须用 `{"allowlist": ["netease_large_feature"]}`（不可用 `{"ban_all": true}`），且 `.mcstructure` 必须包含 `TAG_List("entities")`。
