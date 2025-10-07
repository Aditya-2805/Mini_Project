# Network Analytics Suite

A **modular Bash-based network analytics suite** to monitor and log various aspects of network performance on Linux systems. This suite includes:

1. **Network Speed Test** – Measures download speed, upload speed (placeholder), and ping.  
2. **Network Interface Info** – Logs IP address, MAC address, and link status for all interfaces.  
3. **DNS Resolver Check** – Tests response times and availability of multiple DNS servers.  
4. **Signal Strength Monitor** – Logs Wi-Fi signal strength and link quality.  
5. **HTTP Availability Checker** – Tests accessibility and response time of specified websites.  
6. **Master Script** – Executes all modules sequentially and logs their outputs to a consolidated CSV.

---

## Features

- Modular design: Each functionality is a separate script.  
- Logs results in CSV format for easy analysis.  
- Works with default Linux utilities (`ping`, `curl`, `ip`, `iwconfig`, `nslookup`).  
- Can be run on schedule via `cron` for periodic monitoring.  

---

## Requirements

- Linux OS  
- Bash shell  
- Utilities: `ping`, `curl`, `ip`, `iwconfig`, `nslookup`  
- Optional (for detailed DNS checks): `dig` (`dnsutils` package)

---

## Installation

1. Clone this repository:

```bash
git clone https://github.com/kautik4/Network-Analytics
cd Network-Analytics
```

2. Make all scripts executable:

```bash
chmod +x network_speed_test.sh network_interface_info.sh dns_resolver_check.sh signal_strength.sh http_availibility_checker.sh main_network_suite.sh
```

---

## Usage

### 1. Run individual modules:

```bash
./network_speed_test.sh
./network_interface_info.sh
./dns_resolver_check.sh
./signal_strength.sh
./http_availibility_checker.sh
```

### 2. Run the master script:

```bash
./main_network_suite.sh
```

- Logs will be stored in your home directory:  
  - `network_speed_log.csv`  
  - `network_interface_log.csv`  
  - `dns_resolver_log.csv`  
  - `signal_strength_log.csv`  
  - `http_availability_log.csv`  
  - `network_analytics_master_log.csv` (combined log)

---

## Directory Structure

```
network-analytics-suite/
├── network_speed_test.sh
├── network_interface_info.sh
├── dns_resolver_check.sh
├── signal_strength.sh
├── http_availibility_checker.sh
├── main_network_suite.sh
└── README.md
```

---

## Example Output

**Master Log (`network_analytics_master_log.csv`):**

| Date       | Time     | Module                    | Details                                                               |
|------------|----------|---------------------------|------------------------------------------------------------------------|
| 2025-10-06 | 16:30:00 | Network Speed Test         | Download: 42 Mbps, Upload: 0 Mbps, Ping: 10 ms                        |
| 2025-10-06 | 16:30:10 | Network Interface Info     | eth0: IP 192.168.1.5, MAC xx:xx:xx, up; wlan0: IP 192.168.1.10, up    |
| 2025-10-06 | 16:30:20 | DNS Resolver Check         | 8.8.8.8: 15 ms, Success; 1.1.1.1: 12 ms, Success                      |
| 2025-10-06 | 16:30:30 | Signal Strength Monitor    | wlan0: Signal -55 dBm, Quality 90%                                    |
| 2025-10-06 | 16:30:40 | HTTP Availability Checker  | https://google.com: 200 OK, 35 ms; https://github.com: 200 OK, 42 ms  |

---

## Future Improvements

- Implement upload speed testing.  
- Add packet loss and jitter monitoring.  
- Email or Slack notifications for network anomalies.  
- Advanced signal noise ratio (SNR) analytics.  
- Auto-retry and failure alert system for HTTP checks.  

---

## License

MIT License – See `LICENSE` file for details.
