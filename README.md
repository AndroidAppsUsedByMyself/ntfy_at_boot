# Ntfy at Boot

Ntfy at Boot is a Magisk module used to send notifications upon device boot. This module utilizes the `ntfy.sh` service to send notifications, which include the device model, system version, and current time.

## Features

- Sends notifications upon device boot.
- Sends notifications after device decryption.
- Supports custom notification topics.
- Supports custom `ntfy.sh` server (optional).

## Installation

1. Download the latest ZIP file.
2. Install the ZIP file in the Magisk app.
3. Reboot the device.

## Configuration

After installing the module, you need to configure the `conf.sh` file to set the `NTFY_SUBSCRIPTIONS`.

1. Open the file manager and navigate to `/data/adb/ntfy`.
2. Edit the `conf.sh` file, replace `https://ntfy.sh/test https://ntfy.sh/test2` with your own `NTFY_SUBSCRIPTIONS`.

## File Structure

- `action.sh`: Script executed upon device boot.
- `conf.sh`: Configuration file containing `NTFY_SUBSCRIPTIONS`.
- `customize.sh`: Installation script.
- `module.prop`: Module property file.
- `post-fs-data.sh`: Script executed after the file system is mounted.
- `service.sh`: Script executed after device boot is complete.
- `utils.sh`: Script containing utility functions.

## Contributing

Contributions of code and suggestions are welcome! Please submit a Pull Request or create an Issue.

## License

This project is licensed under the MIT License. For more details, see the [LICENSE](LICENSE) file.

## Acknowledgments

- [ntfy.sh](https://ntfy.sh/) - Service used for sending notifications.
- [Magisk](https://github.com/topjohnwu/Magisk) - Tool used for managing modules.

## Contact

If you have any questions or suggestions, please contact [Mayuri](mailto:mayuri@example.com).
