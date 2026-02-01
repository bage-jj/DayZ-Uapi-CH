#!/usr/bin/env pwsh

# 构建脚本 for DayZ-Uapi-CH
# 此脚本用于构建带有-CH后缀的汉化版本

Write-Host "开始构建 DayZ-Uapi-CH 版本..." -ForegroundColor Green

# 切换到 DayZWebService 目录
Write-Host "构建 DayZWebService..." -ForegroundColor Cyan
Set-Location -Path ".\DayZWebService"

# 安装依赖
Write-Host "安装依赖..." -ForegroundColor Yellow
npm install --legacy-peer-deps

# 构建 Windows 版本
Write-Host "构建 Windows 版本..." -ForegroundColor Yellow
try {
    npx pkg . --target node14-win-x64 --output dayzwebservice-win-CH.exe
    Write-Host "Windows 版本构建成功!" -ForegroundColor Green
} catch {
    Write-Host "Windows 版本构建失败: $_" -ForegroundColor Red
}

# 构建 Linux 版本
Write-Host "构建 Linux 版本..." -ForegroundColor Yellow
try {
    npx pkg . --target node14-linux-x64 --output dayzwebservice-linux-CH
    Write-Host "Linux 版本构建成功!" -ForegroundColor Green
} catch {
    Write-Host "Linux 版本构建失败: $_" -ForegroundColor Red
}

# 切换到 DesktopManager 目录
Write-Host "构建 DesktopManager..." -ForegroundColor Cyan
Set-Location -Path "..\DesktopManager"

# 安装依赖
Write-Host "安装依赖..." -ForegroundColor Yellow
npm install --legacy-peer-deps

# 构建 DesktopManager
Write-Host "构建 DesktopManager..." -ForegroundColor Yellow
try {
    npm run make
    Write-Host "DesktopManager 构建成功!" -ForegroundColor Green
} catch {
    Write-Host "DesktopManager 构建失败: $_" -ForegroundColor Red
}

# 复制构建产物到发布目录
Write-Host "复制构建产物到发布目录..." -ForegroundColor Cyan
Set-Location -Path ".."
New-Item -ItemType Directory -Name "release-CH" -ErrorAction SilentlyContinue

# 复制 DayZWebService 构建产物
if (Test-Path ".\DayZWebService\dayzwebservice-win-CH.exe") {
    Copy-Item -Path ".\DayZWebService\dayzwebservice-win-CH.exe" -Destination ".\release-CH\" -Force
    Write-Host "已复制 dayzwebservice-win-CH.exe" -ForegroundColor Green
}

if (Test-Path ".\DayZWebService\dayzwebservice-linux-CH") {
    Copy-Item -Path ".\DayZWebService\dayzwebservice-linux-CH" -Destination ".\release-CH\" -Force
    Write-Host "已复制 dayzwebservice-linux-CH" -ForegroundColor Green
}

# 复制 DesktopManager 构建产物
if (Test-Path ".\DesktopManager\out\UniversalAPIWebService-CH-win32-x64") {
    # 查找 exe 文件
    $desktopExe = Get-ChildItem -Path ".\DesktopManager\out" -Name "*.exe" -Recurse
    if ($desktopExe) {
        Copy-Item -Path ".\DesktopManager\out\$desktopExe" -Destination ".\release-CH\UniversalAPIWebService-CH.exe" -Force
        Write-Host "已复制 UniversalAPIWebService-CH.exe" -ForegroundColor Green
    }
}

# 复制配置文件
if (Test-Path ".\DayZWebService\config.json.example") {
    Copy-Item -Path ".\DayZWebService\config.json.example" -Destination ".\release-CH\sample-config.json" -Force
    Write-Host "已复制 sample-config.json" -ForegroundColor Green
}

Write-Host "构建完成! 构建产物已保存到 release-CH 目录" -ForegroundColor Green
Write-Host "请将这些文件上传到 GitHub Releases 页面" -ForegroundColor Yellow
Write-Host "发布版本标签: 1.3.2-CH" -ForegroundColor Yellow

# 切换回项目根目录
Set-Location -Path ".."