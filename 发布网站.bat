@echo off
cd /d "%~dp0"
set "GIT=git"
where git >nul 2>&1 || set "GIT=C:\Program Files\Git\bin\git.exe"
where git >nul 2>&1 || set "GIT=C:\Program Files (x86)\Git\bin\git.exe"
echo ============================================
echo   飞猫大头网站 - 一键发布
echo ============================================
echo.
echo [1/3] 检查改动并暂存...
git add -A
git diff --cached --quiet
if errorlevel 1 (
  echo [2/3] 提交改动...
  git commit -m "website auto-publish %date% %time%"
) else (
  echo 没有新的改动，跳过提交，直接推送。
)
echo [3/3] 推送到 GitHub（失败自动重试 3 次）...
set "TRY=0"
:retry
set /a TRY+=1
git push origin main
if not errorlevel 1 goto pushok
if %TRY% lss 3 (
  echo 第 %TRY% 次推送失败，2 秒后重试...
  timeout /t 2 /nobreak >nul
  goto retry
)
echo [推送失败] 可能是网络波动或登录失效。请稍后双击本脚本重试，或打开 Git Bash 执行 git push origin main
goto end
:pushok
echo [成功] 已推送到 GitHub！等约 1 分钟，浏览器打开 f-datou.github.io 按 Ctrl+F5 强刷
:end
echo.
pause
