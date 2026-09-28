# H-Passworder

A secure, lightweight, and customizable CLI password generator written in pure Haskell with **zero external dependencies**. Designed to be completely portable and run effortlessly as a standalone executable.

---

## 🚀 Quick Start (For Users)
If you just want to generate passwords, you don't need to compile anything! 
1. Go to the `app/` folder (or releases).
2. Simply double-click **`main.exe`** (or run it from your terminal).
3. Follow the interactive prompts and you're good to go!

---

## Features

- **Zero External Dependencies:** Built using only Haskell's standard libraries (`System.IO`, `System.CPUTime`, `Data.Bits`).
- **Fully Customizable:** Choose your desired password length and toggle uppercase letters, numbers, and symbols on/off.
- **Advanced Entropy:** Utilizes high-precision CPU time seeding combined with bitwise shifting and XOR mixing (`Xorshift`/`LCG`) to ensure non-repeating, highly secure generation.
- **Standalone Portable Executable:** Compiles down to a single `.exe` file that runs seamlessly without needing a pre-installed package manager or interpreter.

---

## For Developers (Compilation)

If you want to view, modify, or compile the source code yourself:

### Prerequisites
You will need the Glasgow Haskell Compiler (`GHC`):
```bash
ghc --version
```
### Compilation
Clone the repository and compile `main.hs` using the optimization flag (`-O2`):
```bash
ghc -O2 main.hs -o main.exe
```
### Usage
Run the executable:
```bash
./main.exe
```

### Follow the interactive prompts:

Enter password length (default is 12).

Include uppercase letters? (y/n, default is y).

Include numbers? (y/n, default is y).

Include symbols? (y/n, default is y).

### Built With
Haskell - Pure functional core logic.

Bitwise Operations (Data.Bits) - For robust pseudo-random mixing.

License
This project is open-source and available under the **MIT License**.
