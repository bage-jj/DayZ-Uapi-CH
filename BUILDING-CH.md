# DayZ-Uapi-CH 构建指南

本指南详细说明如何构建 DayZ-Uapi-CH 项目的所有组件。

## 环境要求

### 基础依赖
- Node.js v14 或更高版本
- npm v6 或更高版本
- Git

### DayZWebService 构建依赖
- **Windows 构建**：
  - NASM（用于 OpenSSL 构建）
  - Python 3.7+（用于 Node.js 源码构建）
  - Visual Studio Build Tools（用于 C++ 编译）

- **Linux 构建**：
  - GCC/G++
  - Make
  - Python 3.7+
  - NASM

### DesktopManager 构建依赖
- Electron 构建工具链
- Windows 构建：Windows 10/11
- macOS 构建：macOS 10.13+
- Linux 构建：Ubuntu 16.04+

## 构建步骤

### 1. 克隆仓库

```bash
git clone https://github.com/bage-jj/DayZ-Uapi-CH.git
cd DayZ-Uapi-CH
```

### 2. 构建 DayZWebService

#### Windows 构建

```bash
cd DayZWebService
npm install --legacy-peer-deps

# 构建 Windows 可执行文件
npx pkg . --target node14-win-x64 --output dayzwebservice-win-CH.exe

# 构建 Linux 可执行文件（需要在 Linux 环境中执行）
# npx pkg . --target node14-linux-x64 --output dayzwebservice-linux-CH
```

#### 绕过 NASM 依赖（备选方案）

如果遇到 NASM 依赖问题，可以尝试以下方法：

```bash
# 使用不同版本的 pkg
npm install -g pkg@4.5.1
npx pkg@4.5.1 . --target node14-win-x64 --output dayzwebservice-win-CH.exe

# 或使用 nexe
npm install -g nexe
nexe -i app.js -o dayzwebservice-win-CH.exe
```

### 3. 构建 DesktopManager

```bash
cd ../DesktopManager
npm install --legacy-peer-deps

# 构建应用程序
npm run make

# 构建产物将位于 out/ 目录中
```

### 4. 生成 NuGet 包

```bash
# 导航到项目根目录
cd ..

# 创建 NuGet 包（需要 NuGet CLI）
nuget pack UniversalAPIWebService.nuspec -Version 1.3.2-CH
```

## 发布步骤

### 1. 准备发布文件

运行以下脚本生成所有必要的发布文件：

```bash
# Windows
.enerate-release-files-CH.ps1

# Linux/macOS
chmod +x generate-release-files-CH.sh
./generate-release-files-CH.sh
```

### 2. 在 GitHub 上创建发布版本

1. 登录 GitHub，进入 `bage-jj/DayZ-Uapi-CH` 仓库
2. 点击 "Releases" 选项卡
3. 点击 "Draft a new release"
4. 选择 `1.3.2-CH` 标签
5. 填写发布标题和描述
6. 上传 `release-CH` 目录中的所有文件
7. 点击 "Publish release" 完成发布

## 故障排除

### 常见问题

1. **pkg 构建失败，提示缺少 NASM**
   - 解决方案：安装 NASM 或使用 `--openssl-no-asm` 标志
   - 下载 NASM：https://www.nasm.us/

2. **Electron 构建失败，提示证书验证错误**
   - 解决方案：设置环境变量绕过证书验证
   - Windows：`set NODE_TLS_REJECT_UNAUTHORIZED=0`
   - Linux/macOS：`export NODE_TLS_REJECT_UNAUTHORIZED=0`

3. **依赖安装失败**
   - 解决方案：使用 `--legacy-peer-deps` 标志
   - `npm install --legacy-peer-deps`

### 构建日志

如果构建失败，请检查以下日志文件：
- DayZWebService 构建日志：`DayZWebService/npm-debug.log`
- DesktopManager 构建日志：`DesktopManager/npm-debug.log`

## 构建脚本

项目根目录提供了以下构建脚本：

- `build-release-CH.ps1`：Windows 构建脚本
- `generate-release-files-CH.ps1`：生成发布文件脚本

## 注意事项

- 构建过程可能需要较长时间，特别是首次构建时需要下载和编译 Node.js 源码
- 确保有足够的磁盘空间（至少 10GB）
- 构建过程需要网络连接，用于下载依赖和源码

## 支持

如果遇到构建问题，请参考以下资源：

- [Node.js 构建指南](https://github.com/nodejs/node/blob/master/BUILDING.md)
- [pkg 文档](https://github.com/vercel/pkg#readme)
- [Electron Forge 文档](https://www.electronforge.io/)

---

**构建成功后，您将获得以下文件：**
- `dayzwebservice-linux-CH` - Linux 版本的 DayZ Web 服务
- `dayzwebservice-win-CH.exe` - Windows 版本的 DayZ Web 服务
- `UniversalAPIWebService-CH.exe` - Windows 桌面管理工具
- `UniversalAPIWebService-1.3.2-CH-full.nupkg` - NuGet 包
- `sample-config.json` - 示例配置文件
- `RELEASES` - 发布说明文件

将这些文件上传到 GitHub Releases 页面，完成发布过程。