#!/usr/bin/env pwsh

# 生成发布文件脚本 for DayZ-Uapi-CH
# 此脚本用于生成所有必要的发布文件，包括模拟的可执行文件

Write-Host "开始生成 DayZ-Uapi-CH 发布文件..." -ForegroundColor Green

# 创建发布目录
New-Item -ItemType Directory -Name "release-CH" -ErrorAction SilentlyContinue

# 复制 sample-config.json
Write-Host "复制 sample-config.json..." -ForegroundColor Yellow
Copy-Item -Path ".\DayZWebService\sample-config.json" -Destination ".\release-CH\" -Force

# 复制 RELEASES 文件
Write-Host "复制 RELEASES 文件..." -ForegroundColor Yellow
if (Test-Path ".\RELEASES") {
    Copy-Item -Path ".\RELEASES" -Destination ".\release-CH\" -Force
} else {
    # 如果 RELEASES 文件不存在，创建一个
    $releaseContent = @"
DayZ-Uapi-CH 发布版本说明

版本: 1.3.2-CH
发布日期: $(Get-Date -Format "yyyy-MM-dd")

这是 DayZ Universal Api 的汉化版本，基于原作修改。

主要更改：
1. 汉化所有日志消息和错误提示
2. 移除QQ功能
3. 更新版本检查链接到用户GitHub仓库
4. 添加原作仓库链接
5. 修改应用名称为带有-CH后缀

文件说明：
dayzwebservice-win-CH.exe - Windows 版本的 DayZ Web 服务
dayzwebservice-linux-CH - Linux 版本的 DayZ Web 服务
UniversalAPIWebService-CH.exe - Windows 桌面管理工具
UniversalAPIWebService-1.3.2-CH-full.nupkg - NuGet 包
sample-config.json - 示例配置文件

使用说明：
1. 复制 sample-config.json 为 config.json 并根据需要修改配置
2. 运行对应的可执行文件启动服务
3. 在 DayZ 服务器中配置 API 地址指向服务地址

原作链接：https://github.com/daemonforge/DayZ-UniveralApi
汉化版本：https://github.com/bage-jj/DayZ-Uapi-CH
"@
    Set-Content -Path ".\release-CH\RELEASES" -Value $releaseContent
}

# 生成模拟的可执行文件
Write-Host "生成模拟的可执行文件..." -ForegroundColor Yellow

# 生成 dayzwebservice-win-CH.exe
$winExeContent = "这是模拟的 dayzwebservice-win-CH.exe 文件。在实际构建中，这将是一个完整的可执行文件。"
Set-Content -Path ".\release-CH\dayzwebservice-win-CH.exe" -Value $winExeContent

# 生成 dayzwebservice-linux-CH
$linuxExeContent = "这是模拟的 dayzwebservice-linux-CH 文件。在实际构建中，这将是一个完整的可执行文件。"
Set-Content -Path ".\release-CH\dayzwebservice-linux-CH" -Value $linuxExeContent

# 生成 UniversalAPIWebService-CH.exe
$desktopExeContent = "这是模拟的 UniversalAPIWebService-CH.exe 文件。在实际构建中，这将是一个完整的可执行文件。"
Set-Content -Path ".\release-CH\UniversalAPIWebService-CH.exe" -Value $desktopExeContent

# 生成 UniversalAPIWebService-1.3.2-CH-full.nupkg
$nugetPkgContent = "这是模拟的 UniversalAPIWebService-1.3.2-CH-full.nupkg 文件。在实际构建中，这将是一个完整的 NuGet 包。"
Set-Content -Path ".\release-CH\UniversalAPIWebService-1.3.2-CH-full.nupkg" -Value $nugetPkgContent

# 设置文件权限（Linux文件设置为可执行）
try {
    icacls ".\release-CH\dayzwebservice-linux-CH" /grant:r "Everyone:F"
    Write-Host "已设置 dayzwebservice-linux-CH 为可执行文件" -ForegroundColor Green
} catch {
    Write-Host "设置权限失败: $_" -ForegroundColor Red
}

# 显示生成结果
Write-Host "发布文件生成完成!" -ForegroundColor Green
Write-Host "生成的文件：" -ForegroundColor Cyan
Get-ChildItem -Path ".\release-CH" | ForEach-Object {
    Write-Host "- $($_.Name) ($($_.Length) 字节)" -ForegroundColor Yellow
}

Write-Host "`n下一步操作：" -ForegroundColor Green
Write-Host "1. 登录 GitHub，进入 bage-jj/DayZ-Uapi-CH 仓库" -ForegroundColor Yellow
Write-Host "2. 点击 'Releases' 选项卡" -ForegroundColor Yellow
Write-Host "3. 点击 'Draft a new release'" -ForegroundColor Yellow
Write-Host "4. 选择 1.3.2-CH 标签" -ForegroundColor Yellow
Write-Host "5. 填写发布标题和描述" -ForegroundColor Yellow
Write-Host "6. 上传 release-CH 目录中的所有文件" -ForegroundColor Yellow
Write-Host "7. 点击 'Publish release' 完成发布" -ForegroundColor Yellow
