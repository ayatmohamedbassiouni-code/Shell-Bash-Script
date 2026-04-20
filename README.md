# 🖥️ User & Group Management Tool

A interactive **Bash** script for managing Linux users and groups through a clean **whiptail** GUI menu — no need to memorize commands!

---

## 📋 Features

| Feature | Description |
|---|---|
| ➕ Add User | Create a new user with a home directory |
| ✏️ Modify User | Rename an existing user |
| 🗑️ Delete User | Remove a user and their home directory |
| 📋 List Users | Display all real system users (UID ≥ 1000) |
| ➕ Add Group | Create a new user group |
| ✏️ Modify Group | Rename an existing group |
| 🗑️ Delete Group | Delete an existing group |
| 📋 List Groups | Display all groups on the system |
| 🔒 Disable User | Lock a user account (`usermod -L`) |
| 🔓 Enable User | Unlock a user account (`usermod -U`) |
| 🔑 Change Password | Change the password of any user |
| ℹ️ About | Display information about the tool |

---

## 🖼️ Preview

```
┌────────────────────── Main Menu ──────────────────────┐
│  Select an option:                                     │
│                                                        │
│     Add User       Add a user to the system.           │
│     Modify User    Rename an existing user.            │
│     Delete User    Delete an existing user.            │
│     List Users     List all real users on the system.  │
│     Add Group      Add a user group to the system.     │
│     ...                                                │
│                                                        │
│             <Select>              <Exit>               │
└────────────────────────────────────────────────────────┘
```

---

## ⚙️ Requirements

- Linux OS (Tested on **Red Hat / CentOS / Ubuntu**)
- `bash` shell
- `whiptail` package

**Install whiptail if not available:**
```bash
# Red Hat / CentOS
sudo dnf install newt -y

# Ubuntu / Debian
sudo apt install whiptail -y
```

---

## 🚀 Usage

**1. Clone the repository:**
```bash
git clone https://github.com/ayatmohamedbassiouni/user-group-management-tool.git
cd user-group-management-tool
```

**2. Give execute permission:**
```bash
chmod +x exam_task.sh
```

**3. Run as root:**
```bash
sudo ./exam_task.sh
```

> ⚠️ **Note:** This script must be run with root privileges (`sudo`) since it manages system users and groups.

---

## 🔍 How It Works

- Built with **Bash scripting** and **whiptail** for the interactive TUI (Text User Interface)
- Uses standard Linux commands: `useradd`, `usermod`, `userdel`, `groupadd`, `groupmod`, `groupdel`, `passwd`
- Validates all inputs — checks if users/groups already exist before creating, and checks existence before modifying or deleting
- Reads real users from `/etc/passwd` (UID ≥ 1000) and groups from `/etc/group`

---

## 🛡️ Error Handling

- Prompts error if user/group **already exists** on creation
- Prompts error if user/group **not found** on modify/delete/lock
- Exits gracefully when the user presses **Cancel** or **Exit**
- Requires root — exits with a clear message if run without `sudo`

---

## 📁 Project Structure

```
user-group-management-tool/
│
└── exam_task.sh       # Main script
└── README.md          # Project documentation
```

---

## 👩‍💻 Author

**Ayat Mohamed Bassiouni**
- 🔗 [LinkedIn](https://linkedin.com/in/ayat-bassiouni-58a802262)
- 🐙 [GitHub](https://github.com/ayatmohamedbassiouni)

---

## 📄 License

This project is open source and available under the [MIT License](LICENSE).
