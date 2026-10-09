# Tailored Resume Update for NVIDIA Compiler Verification Intern

Add this project to your resume under the **PROJECTS** section (preferably at the very top of Projects) to directly target the **NVIDIA Compiler Verification Team**:

---

### **GPU & EMBEDDED COMPILER VERIFICATION SUITE** | *C++, Python, PTX, CUDA, CMake*
**GitHub:** `https://github.com/<your-username>/gpu-compiler-verification-suite`
- **Compiler Test Automation:** Architected an automated verification and differential testing suite for GPU & embedded compiler backends (PTX ISA 7.5 / sm_80+), validating arithmetic precision, SIMT control divergence, and memory synchronization.
- **Differential & Regression Testing:** Built a C++ golden reference simulator and differential oracle verifying semantic invariance between unoptimized (`-O0`) and optimized (`-O3`) compiler emission, ensuring adherence to IEEE-754 rounding modes (`.rn`, `.rz`, `.rm`, `.rp`) and FMA contraction.
- **Pipeline Hazard & Latency Analysis:** Developed an automated static hazard analyzer detecting back-to-back RAW/WAR/WAW data dependencies and load-to-use latency stalls, bridging hardware pipeline verification principles with compiler instruction scheduling.
- **Grammar-Directed Fuzzer & CI/CD:** Implemented a Python mutation fuzzer generating pseudo-random instruction streams with complex predicate masks to stress-test compiler parsers, integrated with GitHub Actions CI for automated JUnit regression reporting.

---

### Key Application Form Answers (If Asked)

**1. Project Git Link:**
`https://github.com/<your-username>/gpu-compiler-verification-suite`

**2. Why are you interested in this role?**
> "Having worked on bare-metal networking software at Aviat Networks and UVM verification for a 3-stage pipelined RV32IM RISC-V SoC with custom hazard and memory stall units, I developed a strong appreciation for the critical boundary between hardware architecture and code generation. Building this GPU compiler verification suite allowed me to apply hardware-inspired hazard detection and differential testing to NVIDIA's PTX ISA and CUDA optimization passes. I am passionate about ensuring the reliability and robustness of NVIDIA's world-class compiler toolchains across emerging architectures."
