<p align="center">
  <a href="https://github.com/swiftly-solution/swiftly">
    <img src="https://cdn.swiftlycs2.net/swiftly-logo.png" alt="SwiftlyLogo" width="80" height="80">
  </a>

  <h3 align="center">[Swiftly] Bombsite Restrict</h3>

  <p align="center">
    A simple plugin for Swiftly that implements bombsite restriction.
    <br/>
  </p>
</p>

<p align="center">
  <img src="https://img.shields.io/github/downloads/m3ntorsky/bombsite-restrict/total" alt="Downloads"> 
  <img src="https://img.shields.io/github/contributors/m3ntorsky/tagbombsite-restrict?color=dark-green" alt="Contributors">
  <img src="https://img.shields.io/github/issues/m3ntorsky/bombsite-restrict" alt="Issues">
  <img src="https://img.shields.io/github/license/m3ntorsky/bombsite-restrict" alt="License">
</p>



## Installation 👀
1. Download the newest [release](https://github.com/m3ntorsky/bombsite-restrict/releases)
2. Everything is drag & drop, so I think you can do it!

### Configuring the plugin 🧐
- After installing the plugin, you can change the prefix and the database settings from `addons/swiftly/configs/plugins/bombsite-restrict.json`

```json
{
    "prefix": "{DARKRED}[Bombsite Restrict]{DEFAULT}", // Prefix
    "disabled_bombsite": 0, // 0 - Random | 1 - A | 2 - B
    "minimum_players": 6, // Minimum number of players (including bots) required to disable bombsite restriction (couting bots)
    "message_repeated_time": 10 // Time (in seconds) between repeated messages to players
}
```

### Creating A Pull Request 😃

1. Fork the Project
2. Create your Feature Branch
3. Commit your Changes
4. Push to the Branch
5. Open a Pull Request

### Have ideas/Found bugs? 💡

Join [Swiftly Discord Server](https://swiftlycs2.net/discord) and send a message in the topic from `📕╎plugins-sharing` of this plugin!

---