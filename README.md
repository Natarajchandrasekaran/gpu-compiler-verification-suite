# GPU & Embedded Compiler Verification Suite

[![CI Regression](https://img.shields.io/badge/CI-Passing-brightgreen?style=flat-square&logo=github-actions)](https://github.com)
[![PTX ISA](https://img.shields.io/badge/PTX%20ISA-v7.5%20%7C%20sm__80%2B-76B900?style=flat-square&logo=nvidia)](https://docs.nvidia.com/cuda/parallel-thread-execution/)
[![C++ Standard](https://img.shields.io/badge/Language-C%2B%2B17-blue?style=flat-square&logo=c%2B%2B)](https://isocpp.org)
[![Python Automation](https://img.shields.io/badge/Automation-Python%203.10%2B-yellow?style=flat-square&logo=python)](https://python.org)
[![License](https://img.shields.io/badge/License-MIT-lightgrey?style=flat-square)](LICENSE)

An industry-grade verification and differential testing suite designed for **NVIDIA GPU and embedded compiler backends** (LLVM NVPTX, `nvcc`, embedded vector compilers). 

This project bridges **hardware pipeline verification** (RAW/WAR hazard detection, memory synchronization) with **compiler code-generation validation** (IEEE-754 precision modes, SIMT divergence, and differential optimization invariants).

---

## Key Features

- **PTX & CUDA Testbench Suite:** Regression coverage for floating-point rounding modes (`.rn`, `.rz`, `.rm`, `.rp`), subnormal numbers, FMA contraction, SIMT control divergence, and barrier primitives (`bar.sync`, atomics).
- **Golden Model Virtual SIMT Interpreter:** C++ reference engine emulating 32-lane warp execution, per-lane predicates, and memory consistency checks.
- **Static Pipeline Hazard Analyzer:** Automatic detection of Read-After-Write (RAW), Write-After-Read (WAR), Write-After-Write (WAW), and load-to-use latency stalls.
- **Grammar-Directed PTX Instruction Fuzzer:** Automated mutation engine synthesizing valid random instruction streams to stress-test compiler parsers and register allocators.
- **Differential Optimization Invariant Checker:** Multi-tier oracle asserting semantic equivalence between unoptimized (`-O0`) and optimized (`-O3`) representations.
- **CI/CD Automation:** GitHub Actions regression workflow publishing JUnit XML and Markdown reports on every commit.

---

## Architecture Overview

```
                      +-----------------------------+
                      | PTX / CUDA Testbench Suites |
                      +--------------+--------------+
                                     |
                +--------------------+--------------------+
                |                                         |
                v                                         v
   +-------------------------+               +-------------------------+
   |  Pipeline Hazard Unit   |               | Virtual SIMT 32-Lane    |
   |  - RAW / WAR / WAW      |               | Golden Interpreter      |
   |  - Load-Use Stalls      |               | - Rounding Invariants   |
   +------------+------------+               | - Predicated Execution  |
                |                            +------------+------------+
                |                                         |
                +--------------------+--------------------+
                                     |
                                     v
                      +-----------------------------+
                      | Differential Testing Oracle |
                      |   - State Equivalence Check |
                      |   - JUnit / Markdown Output |
                      +-----------------------------+
```

---

## Directory Structure

```
gpu-compiler-verification-suite/
├── .github/workflows/
│   └── compiler_regression.yml       # Continuous integration workflow
├── docs/
│   ├── ARCHITECTURE.md               # Technical architectural deep dive
│   └── METHODOLOGY.md                # Verification methodology & triage guide
├── include/
│   ├── ptx_ast.hpp                   # PTX intermediate AST & register models
│   ├── ptx_interpreter.hpp           # 32-lane golden reference interpreter
│   └── verification_engine.hpp       # Differential oracle & hazard analyzer
├── src/
│   ├── ptx_interpreter.cpp           # Simulation engine implementation
│   ├── verification_engine.cpp       # Invariant & assertion checker
│   └── main.cpp                      # Standalone C++ verification CLI
├── tests/
│   ├── ptx/
│   │   ├── arithmetic_precision.ptx  # IEEE-754 rounding, denormals, FMA
│   │   ├── control_divergence.ptx    # SIMT branching & warp reconvergence
│   │   ├── memory_synchronization.ptx# Atomics and bar.sync barriers
│   │   └── hazard_corner_cases.ptx   # RAW/WAR/WAW pipeline hazards
│   └── cuda/
│       ├── vector_add_opt_diff.cu    # -O0 vs -O3 differential testing
│       └── reduction_warp_sync.cu    # Intra-warp shuffle verification
├── tools/
│   ├── nv_verify.py                  # CLI test runner & reporter
│   ├── ptx_fuzzer.py                 # Grammar-directed mutation fuzzer
│   └── differential_tester.py        # Differential compiler comparator
├── CMakeLists.txt                    # Modern CMake build system
└── requirements.txt                  # Python dependencies
```

---

## Quickstart

### 1. Build the C++ Verification Engine
```bash
mkdir build && cd build
cmake ..
cmake --build . --config Release
./nv_verify_engine
```

### 2. Run the Automated Python Test Runner
```bash
pip install -r requirements.txt
python tools/nv_verify.py --tests-dir tests
```

### 3. Generate Stress-Test PTX Kernels with the Fuzzer
```bash
python tools/ptx_fuzzer.py --count 100 --seed 2026 --output tests/ptx/fuzzed_stress.ptx
python tools/nv_verify.py --tests-dir tests
```

### 4. Execute Differential Optimization Testing
```bash
python tools/differential_tester.py --size 5000
```

---

## Verification Test Results

| Test Suite | Focus Area | Status | Verified Invariant |
| :--- | :--- | :---: | :--- |
| `arithmetic_precision.ptx` | FP Precision & Rounding | **PASS** | Strict IEEE-754 `.rn`, `.rz`, `.rm`, `.rp` rounding |
| `control_divergence.ptx` | SIMT Control Flow | **PASS** | Divergent predicate masks & warp reconvergence |
| `memory_synchronization.ptx` | Memory Consistency | **PASS** | Barrier ordering (`bar.sync`) & atomic commit |
| `hazard_corner_cases.ptx` | Pipeline Hazard Regressions | **PASS** | Load-use latency & register RAW hazard detection |
| `vector_add_opt_diff.cu` | Optimization Differential | **PASS** | Zero semantic drift between `-O0` and `-O3` passes |

---

## Author

**Nataraj C**  
B.E. Electronics and Communication Engineering  
*PSG College of Technology, Coimbatore*  
- **Email:** nataraj05chandrummh@gmail.com
- **LinkedIn / GitHub:** [github.com/nataraj05](https://github.com/nataraj05)
