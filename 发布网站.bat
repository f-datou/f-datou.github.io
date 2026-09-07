@echo off
cd /d "%~dp0"
set "GIT=git"
where git >nul 2>&1 || set "GIT=C:\Program Files\Git\bin\git.exe"
where git >nul 2>&1 || set "GIT=C:\Program Files (x86)\Git\bin\git.exe"
echo ============================================
echo   飞猫大头网站 - 一键发布
echo ============================================
echo.
echo [1/3] 添加改动...
%GIT% add -A
echo [2/3] 提交...
%GIT% commit -m "website auto-publish %date% %time%"
echo [3/3] 推送到 GitHub...
%GIT% push origin main
if errorlevel 1 (echo [推送失败] 请看上面的红色错误，也可打开 Git Bash 执行 git push origin main) else (echo [成功] 已推送到 GitHub，等约1分钟浏览器 Ctrl+F5 强刷)
echo.
pause
