# 🌐 Network Analytics Suite

A modular Bash-based toolkit for comprehensive network performance monitoring on Linux systems.

![Language](https://img.shields.io/badge/Language-Bash-blue.svg)
![Platform](https://img.shields.io/badge/Platform-Linux-lightgrey.svg)
![License](https://img.shields.io/badge/License-MIT-green.svg)

---

## 📜 Description

This suite provides a collection of simple, powerful Bash scripts designed to monitor and log various aspects of your network. Whether you're a system administrator, a developer, or a power user, this toolkit helps you keep a close eye on your network's health and performance, logging everything to clean, easy-to-analyze CSV files.

---

## 🚀 Core Features

* **🧩 Modular Design:** Each function is a self-contained script. Use what you need.
* **📊 CSV Logging:** Automatically logs results in CSV format for easy data analysis and visualization.
* **🐧 Linux Native:** Built with standard Linux utilities (`ping`, `curl`, `ip`, `iwconfig`) for maximum compatibility and minimal dependencies.
* **⏰ Cron-Ready:** Easily schedule the master script with `cron` for automated, periodic monitoring.

---

## 🛠️ Modules Included

1.  **Network Speed Test:** Measures download speed, upload speed, and ping latency.
2.  **Network Interface Info:** Logs IP/MAC addresses and link status for all network interfaces.
3.  **DNS Resolver Check:** Tests the response time and availability of your DNS servers.
4.  **Signal Strength Monitor:** Monitors Wi-Fi signal strength and link quality over time.
5.  **HTTP Availability Checker:** Checks the status code and response time of critical websites or endpoints.
6.  **Master Script:** A unified script to run all modules sequentially and aggregate the results.

---

## 💻 Requirements

* **OS:** Any Linux distribution
* **Shell:** `bash`
* **Core Utilities:** `ping`, `curl`, `ip`, `iwconfig`, `nslookup`
* **Optional:** `dig` (from the `dnsutils` or `bind-utils` package) for more detailed DNS checks.

---

## ⚙️ Installation

Getting started is simple. Just clone the repository and make the scripts executable.

1.  **Clone the repository:**
    ```bash
    git clone [https://github.com/kautik4/Network-Analytics](https://github.com/kautik4/Network-Analytics)
    cd Network-Analytics
    ```

2.  **Grant execute permissions:**
    ```bash
    chmod +x *.sh
    ```

---

## ▶️ How to Use

You can run each module individually or use the master script to run them all at once.

### 1. Run Individual Modules

Execute any script directly from your terminal to test a specific function.

```bash
./network_speed_test.sh
./network_interface_info.sh
./dns_resolver_check.sh
./signal_strength.sh
./http_availibility_checker.sh
