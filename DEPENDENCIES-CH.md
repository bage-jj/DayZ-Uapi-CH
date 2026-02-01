# DayZ-Uapi-CH 依赖项安装指南

本指南说明如何解决 `UniversalAPIWebService-CH.exe` 启动失败的问题。

## 常见错误

### 错误代码 0xc000007b

当您尝试运行 `UniversalAPIWebService-CH.exe` 时，可能会看到以下错误：

```
应用程序无法正常启动(0xc000007b)。请单击"确定"关闭应用程序。
```

## 错误原因

此错误通常表示缺少以下依赖项：

1. **Microsoft Visual C++ Redistributable** 包
2. **DirectX** 运行时
3. **.NET Framework**（如果适用）
4. 其他系统 DLL 文件

## 解决方案

### 方法 1：安装 Visual C++ Redistributable 包

1. **下载并安装最新的 Visual C++ Redistributable**：
   - [Visual C++ Redistributable for Visual Studio 2015-2022](https://learn.microsoft.com/en-us/cpp/windows/latest-supported-vc-redist?view=msvc-170)
   - 同时安装 **x86** 和 **x64** 版本

### 方法 2：安装 DirectX 运行时

1. **下载并安装 DirectX 最终用户运行时**：
   - [DirectX End-User Runtime Web Installer](https://www.microsoft.com/en-us/download/details.aspx?id=35)

### 方法 3：检查系统文件

1. **运行系统文件检查器**：
   - 以管理员身份打开命令提示符
   - 运行命令：`sfc /scannow`
   - 等待扫描完成并修复任何损坏的系统文件

### 方法 4：重新安装 .NET Framework

1. **下载并安装最新的 .NET Framework**：
   - [.NET Framework 4.8](https://dotnet.microsoft.com/en-us/download/dotnet-framework/net48)

## 验证安装

安装完所有依赖项后，重新尝试运行 `UniversalAPIWebService-CH.exe`。

## 其他可能的问题

### 端口冲突

如果应用程序启动但无法正常工作，可能是端口冲突：

1. **检查端口 8443 是否已被占用**：
   - 运行命令：`netstat -ano | findstr :8443`
   - 如果有进程占用此端口，终止该进程或修改 `config.json` 中的端口设置

### 配置文件错误

确保 `config.json` 文件配置正确：

1. **复制示例配置文件**：
   - `copy sample-config.json config.json`

2. **修改配置文件**：
   - 根据您的服务器设置修改 `config.json` 文件

## 技术支持

如果上述方法都无法解决问题，请参考以下资源：

- [Electron 应用程序故障排除](https://www.electronjs.org/docs/latest/tutorial/application-distribution)
- [Microsoft 错误代码参考](https://docs.microsoft.com/en-us/windows/win32/debug/system-error-codes)

## 注意事项

- 确保以 **管理员身份** 运行应用程序
- 确保系统已安装所有必要的 Windows 更新
- 确保防火墙允许应用程序访问网络
