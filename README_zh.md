# Ntfy at Boot

Ntfy at Boot 是一个 Magisk 模块，用于在设备启动时发送通知。该模块利用 `ntfy.sh` 服务来发送通知，通知内容包括设备型号、系统版本和当前时间。

## 功能

- 在设备启动时发送通知。
- 在设备解密后发送通知。
- 支持自定义通知主题。
- 支持自定义 `ntfy.sh` 服务器（可选）。

## 安装

1. 下载最新的 ZIP 文件。
2. 在 Magisk 应用中安装该 ZIP 文件。
3. 重启设备。

## 配置

安装模块后，您需要配置 `conf.sh` 文件来设置 `NTFY_SUBSCRIPTIONS`

1. 打开文件管理器并导航到 `/data/adb/ntfy`。
2. 编辑 `conf.sh` 文件，将 `https://ntfy.sh/test https://ntfy.sh/test2` 替换为您自己的 `NTFY_SUBSCRIPTIONS`。

## 文件结构

- `action.sh`：在设备启动时执行的脚本。
- `conf.sh`：包含 `NTFY_SUBSCRIPTIONS`的配置文件。
- `customize.sh`：安装脚本。
- `module.prop`：模块属性文件。
- `post-fs-data.sh`：在文件系统挂载后执行的脚本。
- `service.sh`：在设备启动完成后执行的脚本。
- `utils.sh`：包含实用函数的脚本。

## 贡献

欢迎贡献代码和建议！请提交 Pull Request 或创建 Issue。

## 许可证

本项目采用 MIT 许可证。有关详细信息，请参阅 [LICENSE](LICENSE) 文件。

## 致谢

- [ntfy.sh](https://ntfy.sh/) - 用于发送通知的服务。
- [Magisk](https://github.com/topjohnwu/Magisk) - 用于管理模块的工具。

## 联系

如果您有任何问题或建议，请联系 [Mayuri](mailto:mayuri@example.com)。
