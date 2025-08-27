# FeedForwad-Phase-Correction-Using-Arctan



# QPSK Feed-Forward Phase Correction (Arctan LUT)

This project implements a **feed-forward Carrier Phase Recovery (CPR)** block for **QPSK modulation** in **Verilog RTL**.  
Instead of using a CORDIC algorithm, the design leverages **Lookup Tables (LUTs)** for efficient **arctan-based phase estimation** and **complex rotation**.
This repository implements a **feed-forward Carrier Phase Recovery (CPR)** block for **QPSK modulation** in **Verilog RTL**.  
The design uses **Lookup Tables (LUTs)** for efficient **arctan-based phase estimation** and **complex symbol rotation**, making it FPGA-friendly compared to iterative CORDIC solutions.

---
## 🔹 Feed-Forward Phase Correction

### 📌 Definition
Feed-forward phase correction (also called **feed-forward carrier phase recovery**) is a **non-iterative technique** used in digital communication systems (QPSK, QAM, OFDM) to **estimate and remove carrier phase offsets**. Unlike feedback-based loops (e.g., PLLs), feed-forward methods compute the phase **directly from the received I/Q samples**, without relying on past values.

### 📌 Function
The block performs two main tasks:
1. **Phase Estimation** – calculates the instantaneous carrier phase:
   \[
   \hat{\theta} = \arctan\left(\frac{Q}{I}\right)
   \]
2. **Phase Correction** – rotates the received symbol to cancel the offset:
   \[
   C' = (I + jQ) \cdot e^{-j\hat{\theta}}
   \]

### 📌 Purpose of Use
Feed-forward phase correction is used to:
- Compensate **carrier frequency and phase offsets** from oscillators and channels.  
- Ensure **correct demodulation** of phase-sensitive modulations (QPSK, QAM).  
- Provide **low-latency correction** (suitable for burst-mode systems).  
- Allow **compact FPGA implementation** via LUTs instead of CORDIC.  

## 🔹 Features
- **Phase Estimation**
  - Computes phase θ = atan(Q/I) using LUT
  - Quadrant projection into [0, π/4] for reduced LUT size
  - Phase scaling: π ≈ `1608` (π × 512)

- **Arctan Lookup Table**
  - 256-entry LUT for tan(θ) ∈ [0,1]
  - Python script `gen_atan_lut.py` generates `atan_lut.v`

- **Complex Rotation**
  - Multiplies input `(I + jQ)` by `cos(θ) + j sin(θ)`
  - Uses LUT for cos/sin values (scaled by 2048)
  - Quadrant decomposition for smaller tables

- **Fixed-Point Scaling**
  - Phase values scaled by 512
  - π/4 quadrant split into 402 steps

- **Verification**
  - MATLAB scripts generate I/Q test vectors
  - MATLAB vs. Verilog results compared for phase correction accuracy

---

## 🔹 File Structure
- `verilog/` → RTL modules + testbench
- `scripts/` → LUT generation Python scripts
- `matlab/` → MATLAB verification testbenches
- `docs/` → Design documentation & images

---

## 🔹 Example Workflow
1. Generate LUTs:
   ```bash
   python scripts/gen_atan_lut.py
   python scripts/gen_rot_lut.py
