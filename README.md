# Network Analytics Suite

A **modular Bash-based network analytics suite** to monitor and log various aspects of network performance on Linux systems. This suite includes:

1. **Network Speed Test** – Measures download speed, upload speed (placeholder), and ping.  
2. **Network Interface Info** – Logs IP address, MAC address, and link status for all interfaces.  
3. **DNS Resolver Check** – Tests response times and availability of multiple DNS servers.  
4. **Master Script** – Executes all modules sequentially and logs their outputs to a consolidated CSV.

---

## Features

- Modular design: Each functionality is a separate script.  
- Logs results in CSV format for easy analysis.  
- Works with default Linux utilities (`ping`, `curl`, `ip`, `nslookup`).  
- Can be run on schedule via `cron` for periodic monitoring.  

---

## Requirements

- Linux OS  
- Bash shell  
- Utilities: `ping`, `curl`, `ip`, `nslookup`  
- Optional (for more detailed DNS checks): `dig` (`dnsutils` package)

---

## Installation

1. Clone this repository:

```bash
git clone https://github.com/kautik4/Network-Analytics
cd Network-Analytics
```

2. Make all scripts executable:

```bash
chmod +x network_speed_test.sh network_interface_info.sh dns_resolver_check.sh main_network_suite.sh
```

---

## Usage

### 1. Run individual modules:

```bash
./network_speed_test.sh
./network_interface_info.sh
./dns_resolver_check.sh
```

### 2. Run the master script:

```bash
./main_network_suite.sh
```

- Logs will be stored in your home directory:  
  - `network_speed_log.csv`  
  - `network_interface_log.csv`  
  - `dns_resolver_log.csv`  
  - `network_analytics_master_log.csv` (combined log)

---

## Directory Structure

```
network-analytics-suite/
├── network_speed_test.sh
├── network_interface_info.sh
├── dns_resolver_check.sh
├── main_network_suite.sh
└── README.md
```

---

## Example Output

**Master Log (`network_analytics_master_log.csv`):**

| Date       | Time     | Module                 | Details                                    |
|------------|----------|----------------------|--------------------------------------------|
| 2025-10-06 | 16:30:00 | Network Speed Test    | Download: 42 Mbps, Upload: 0 Mbps, Ping: 10 ms |
| 2025-10-06 | 16:30:10 | Network Interface Info | eth0: IP 192.168.1.5, MAC xx:xx:xx, up; wlan0: IP 192.168.1.10, MAC xx:xx:xx, up |
| 2025-10-06 | 16:30:20 | DNS Resolver Check    | 8.8.8.8: 15 ms, Success; 1.1.1.1: 12 ms, Success |

---

## Future Improvements

- Implement upload speed testing.  
- Add packet loss and jitter monitoring.  
- Wi-Fi signal strength logging.  
- Email or Slack notifications for network anomalies.  

---

## License

MIT License – See `LICENSE` file for details.
