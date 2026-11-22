@echo off
cd /d "%~dp0"
if exist "%~dp0mc_dim_render.exe" (
    start "" "%~dp0mc_dim_render.exe" --gui --pack "%~dp0examples\sample_pack" --dimension dm23333 --seed 2026
) else (
    copy /Y "%~dp0build\mc_dim_render.exe" "%~dp0build\mc_dim_render_gui.exe" >nul 2>nul
    start "" "%~dp0build\mc_dim_render_gui.exe" --gui --pack "%~dp0examples\sample_pack" --dimension dm23333 --seed 2026
)
