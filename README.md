# Synchronous TMR with Single-Cycle Fault Detection and Isolation for Radiation-Prone FPGA Data Acquisition Systems

<div align="center">

![Platform](https://img.shields.io/badge/Platform-AMD%20Xilinx%20Artix--7-E01F3D?style=for-the-badge&logo=amd)
![Language](https://img.shields.io/badge/HDL-VHDL-00979D?style=for-the-badge)
![Tool](https://img.shields.io/badge/Toolchain-Vivado%202018.2-FF6B35?style=for-the-badge)
![Status](https://img.shields.io/badge/Status-Draft%20Under%20Review-yellow?style=for-the-badge)
![Timing](https://img.shields.io/badge/Timing-Closure%20Achieved%20%40%20100%20MHz-2EA44F?style=for-the-badge)
![License](https://img.shields.io/badge/License-MIT-blue?style=for-the-badge)

**A lightweight synchronous TMR architecture with single-cycle Fault Detection and Isolation (FDI) telemetry, for radiation-prone FPGA data acquisition systems**

*Implemented on xc7a100tcsg324-1 | Timing closure achieved at 100 MHz | Verified via behavioral simulation with single-core and multi-cycle fault injection*

[Architecture](#architecture) · [Simulation Results](#simulation--verification) · [Implementation Data](#silicon-implementation-results) · [Scope and Limitations](#scope-and-limitations) · [Repository Structure](#repository-structure) · [Author](#author)

</div>

---

## Project Overview

Cosmic ray muon detectors and other high-speed Data Acquisition (DAQ) systems operating in radiation-harsh environments — including low Earth orbit (LEO) satellite subsystems — are vulnerable to radiation-induced **Single Event Upsets (SEUs)**. In SRAM-based FPGAs, an SEU can flip an internal register bit mid-operation, corrupting a state machine, counter, or data buffer with no warning.

Conventional Triple Modular Redundancy (TMR) masks such faults through majority voting, but it is typically passive: it does not report which replica has failed, and combinational voter implementations can introduce transient propagation glitches in high-speed designs.

This project implements a fully synchronous **TMR** architecture with:

- A registered majority voter that eliminates combinational voting hazards and propagation glitches
- A lightweight Fault Detection and Isolation (FDI) telemetry engine that identifies the corrupted core by index within exactly one clock cycle
- Behavioral verification via single-core and extended multi-cycle fault injection
- Full silicon implementation on Artix-7, with resource utilization, timing, and power analysis

The goal of this work is not autonomous hardware repair. It is a deterministic, low-overhead telemetry layer designed to sit upstream of an external recovery mechanism — such as ICAP-based scrubbing or AMD Xilinx Dynamic Function eXchange (DFX) — by isolating a fault and identifying the faulty core fast enough for that mechanism to act on it.

> **Research Context:** Developed as independent research at the Department of Electronic Engineering, Mehran University of Engineering and Technology (MUET), Jamshoro, Pakistan. Integrated into the author's Final Year Project on a radiation-prone FPGA DAQ system for cosmic ray muon detection. This work is currently a draft under academic review.

---

## Architecture

### System Block Diagram

```
                    ┌─────────────────────────────────────────────┐
                    │         TMR FAULT-TOLERANT CORE              │
                    │                                               │
  CLK ─────────────┤──► Core A (State Machine) ──────────────────►│──┐
                    │                                               │  │
  RST ─────────────┤──► Core B (State Machine) ──────────────────►│  ├──► MAJORITY VOTER
                    │                                               │  │       │
                    │──► Core C (State Machine) ──────────────────►│──┘       │
                    │                                               │          ▼
                    │                                   ┌─────────────────────────────┐
                    │                                   │  Voted_State = (A∧B)∨(B∧C)∨(A∧C) │
                    │                                   │  Registered on CLK rising edge     │
                    │                                   └──────────────┬──────────────────┘
                    │                                                   │
                    │                                         sig_voted (registered output)
                    │
                    │   ┌─────────────────────────────────────────┐
                    │   │        FDI TELEMETRY ENGINE              │
                    │   │                                          │
                    │   │  Divergence Detector ──► sig_fault_det  │
                    │   │  Core Isolator      ──► sig_faulty_core │
                    │   │  (1 clock cycle latency)                 │
                    └───┴─────────────────────────────────────────┘
```

### Design Principles

| Principle | Implementation |
|-----------|---------------|
| **Synchronous Operation** | Majority voter and FDI telemetry outputs are both registered on the rising clock edge |
| **Glitch-Free Voter** | Registered majority voter eliminates transient routing hazards that affect purely combinational TMR voters |
| **Deterministic FDI** | Fault flagging and faulty-core index are resolved within exactly **1 clock cycle** of divergence |
| **Output Continuity** | The voted output continues to reflect the healthy majority while a single core remains divergent |
| **Self-Synchronizing Telemetry** | Once a corrupted core's state vectors are re-aligned externally, the FDI flags clear automatically |
| **Timing Closure** | All user-specified timing constraints met at 100 MHz — WPWS: 4.500 ns, zero failing endpoints |

### Majority Voter Logic

```vhdl
-- Combinational majority voter
comb_voted <= (sig_core_A AND sig_core_B) OR
              (sig_core_B AND sig_core_C) OR
              (sig_core_A AND sig_core_C);

-- Registered output: eliminates transient hazards
process(clk)
begin
    if rising_edge(clk) then
        sig_voted <= comb_voted;
    end if;
end process;
```

### FDI Telemetry Engine

```vhdl
-- Fault Detection & Core Isolation
process(clk)
begin
    if rising_edge(clk) then
        if (sig_core_A /= sig_core_B) or (sig_core_B /= sig_core_C) then
            sig_fault_det  <= '1';
            -- Identify divergent core
            if sig_core_A /= sig_voted then
                sig_faulty_core <= "01";  -- Core A corrupted
            elsif sig_core_B /= sig_voted then
                sig_faulty_core <= "10";  -- Core B corrupted
            else
                sig_faulty_core <= "11";  -- Core C corrupted
            end if;
        else
            sig_fault_det   <= '0';
            sig_faulty_core <= "00";
        end if;
    end if;
end process;
```

---

## Simulation & Verification

Behavioral verification was performed at 100 MHz in Xilinx Vivado Simulator. The testbench implements a generic sequential state machine as a representative control-path abstraction — it is not yet connected to a real data-processing IP such as a TDC or trigger logic block. The fault campaign covered: (i) single-core SEU injection at the clock boundary, and (ii) an extended 1000 ns simulation with sequential multi-node fault injection to evaluate cumulative stress behavior.

### Extended Multi-Cycle Fault Injection Test

The testbench (`tb_tmr_voter.vhd`) generates a 100 MHz clock and injects sequential fault events across a 1000 ns simulation window, including a secondary fault injected into a second core while the first remained divergent.

**Simulation Waveform — 1000 ns Full Test Run:**

![Extended Simulation Waveform](docs/waveform_extended.png)

*Waveform shows: sequential fault injection events, fault detection (sig_fault_det pulses), the faulty core index updating to track the active fault, and correct voted output maintained throughout — as long as no more than one of three cores was corrupted at a given time.*

### Single Fault Injection — Annotated Timeline

| Time | Event | sig_core_A | sig_core_B | sig_core_C | sig_voted | sig_fault_det | sig_faulty_core |
|------|-------|-----------|-----------|-----------|-----------|---------------|-----------------|
| 0–240 ns | Healthy Run | 0→1→2 | 0→1→2 | 0→1→2 | 0→1→2 | 0 | 00 |
| 250 ns | SEU Injected | 2→0 | 2 | 2 | 2 (held) | →1 | →01 (Core A) |
| 250–350 ns | Fault Active | 0 | 2 | 2 | 2 | 1 | 01 |
| 350 ns | System Advances | 0 | 3 | 3 | 3 | 1 | 01 |
| 450 ns | Recovery | →3 | 3 | 3 | 3 | →0 | →00 |

**Verification Result:** `sig_voted` did not take the corrupted value at any point. The majority voter continued seeing two valid states, the FDI engine flagged the discrepancy within one clock cycle, and the system advanced uninterrupted.

### Why Synchronous Registration Matters

```
WITHOUT registration (combinational output):
  Core A fault → comb_voted glitches for Δt (propagation + routing delay) → possible downstream corruption

WITH registration (this design):
  Core A fault → comb_voted glitches → registered output ignores the glitch within the same clock period
  Next rising edge: clean majority decision registered → system continues correctly
```

This registration technique is a standard implementation practice for avoiding combinational hazards in TMR voters, not a novel contribution of this work. It is used here as the foundation on top of which the FDI telemetry layer is built.

---

## Silicon Implementation Results

Fully synthesized, placed, routed, and timing-closed on **xc7a100tcsg324-1 (Artix-7, -1 speed grade)**, target board Digilent Nexys 4 DDR, using Vivado Design Suite v2018.2.

### Timing Closure — 100 MHz

| Parameter | Result |
|-----------|--------|
| Status | All user-specified timing constraints met |
| Worst Pulse Width Slack (WPWS) | 4.500 ns |
| Total Pulse Width Negative Slack (TPWS) | 0.000 ns |
| Failing Endpoints | 0 |
| Total Endpoints Analyzed | 6 |

![Timing Summary](docs/timing_summary_constrained.png)

### Resource Utilization

| Resource | Used | Available | Utilization |
|----------|------|-----------|--------------|
| LUTs | 7 | 63,400 | 0.01% |
| Flip-Flops | 5 | 126,800 | 0.00% |
| I/O Pins | 13 | 210 | 6.19% |

> The complete TMR voter and FDI engine consume only 7 LUTs and 5 flip-flops for the current minimal state machine. This footprint is expected to scale roughly linearly with state width — approximately 3N flip-flops and 3N LUTs for an N-bit state machine, plus a fixed FDI overhead of about 4 comparison LUTs. A planned 16-bit counter, representative of a TDC tally-register width, projects to roughly 48 FFs and 52 LUTs, still under 0.1% of Artix-7 fabric. This scaled implementation is in progress and not yet part of the verified results below.

![Utilization Report](docs/utilization.png)

### Power Analysis (Implemented Design)

| Parameter | Value |
|-----------|-------|
| Total On-Chip Power | 1.936 W |
| Dynamic Power | 1.838 W (95%) |
| — I/O Switching | 1.748 W (90% of dynamic) |
| — Logic Power | 0.033 W (2%) |
| — Signal Power | 0.058 W (3%) |
| Device Static | 0.098 W (5%) |
| Junction Temperature | 33.8°C |
| Thermal Margin | 51.2°C (11.1 W headroom) |

> The dominant power consumer is I/O switching, driven by output signals during vectorless power analysis on this minimal test design, and is not representative of the TMR logic's intrinsic consumption. Core logic power alone is 33 mW.

![Power Analysis](docs/power_analysis.png)

---

## Scope and Limitations

This is an honest account of what the current implementation does and does not demonstrate, written for anyone evaluating this work for research or collaboration purposes:

- **The testbench is a generic abstraction, not a real DAQ component yet.** The protected state machine in the current verified results is a minimal sequential abstraction with no external data input. It validates that the TMR+FDI control logic itself is correct and timing-clean, but it is not yet wired to a real processing IP such as a TDC counter or trigger logic block. A 16-bit counter representative of TDC tally-register width, with hardware validation on the Nexys 4 DDR, is in progress.
- **No physical radiation testing has been performed.** All fault injection is behavioral-simulation-based (register-level SEU modeling), not proton beam or heavy-ion testing. Physical irradiation testing is future work.
- **This work does not perform fault correction.** The FDI engine detects and isolates a fault and produces a trigger signal within one clock cycle; it does not itself scrub configuration memory or reconfigure the faulty core. It is designed as a front-end interface for an external recovery mechanism (e.g., ICAP-based scrubbing or DFX), which has not yet been implemented or integrated.
- **Registered majority voting is a standard technique**, not a novel contribution of this work. It is used here as a prerequisite for the FDI telemetry layer, which is the primary contribution.
- **No quantitative comparison against the Xilinx SEM core (configuration-memory-layer scrubbing) has been performed**, since this work targets a different fault domain (register-level state, not CRAM) and the author does not currently have access to UltraScale+ hardware running the SEM TMR interface. A structured, qualitative comparison (detection layer, latency, correction mechanism, platform) is planned for the next revision.

---

## Comparative Architecture Analysis

| Metric | Baseline (No Resilience) | This Design (TMR + FDI) |
|--------|---------------------------|--------------------------|
| Look-Up Tables | ~2–3 LUTs | 7 LUTs |
| Slice Registers | ~1–2 FFs | 5 FFs |
| Fault Detection Latency | None (faults propagate silently) | 1 clock cycle |
| Fault Correction | None | Not yet implemented — interface only |
| Telemetry Output | None | `sig_fault_det`, `sig_faulty_core` |
| Timing Closure | N/A | 100 MHz (WPWS: 4.5 ns) |

This comparison is against an unprotected baseline of the same minimal design, not against an established fault-tolerance solution such as Xilinx SEM or a full DSP-kernel TMR implementation. See [Scope and Limitations](#scope-and-limitations) above.

---

## Repository Structure

```
Resilient-FPGA-Muon-DAQ/
│
├── src/
│   └── tmr_voter.vhd                  # RTL: Synchronous TMR voter + FDI telemetry engine
│
├── sim/
│   └── tb_tmr_voter.vhd               # Testbench: 100 MHz clock + multi-cycle SEU injection
│
├── constraints/
│   └── tmr_voter.xdc                  # Xilinx Design Constraints (100 MHz clock)
│
├── docs/
│   ├── waveform_single_fault.png      # Annotated single-fault injection waveform
│   ├── waveform_extended.png          # 1000 ns multi-fault verification waveform
│   ├── timing_summary_constrained.png # Timing closure report (all constraints met)
│   ├── power_analysis.png             # On-chip power breakdown
│   ├── utilization.png                # LUT/FF/IO resource report
│   ├── rtl_schematic.png              # Vivado-generated RTL gate-level schematic
│   └── Draft_Synchronous_TMR_FDI_Faiza_Khoso.pdf  # Current paper draft
│
└── README.md
```

---

## How to Reproduce

### Prerequisites
- Xilinx Vivado Design Suite (2018.2 or later)
- Digilent Nexys 4 DDR board (xc7a100tcsg324-1) or any Artix-7 target
- VHDL-2008 simulation support

### Simulation

```tcl
# In Vivado Tcl Console:
add_files src/tmr_voter.vhd
add_files -fileset sim_1 sim/tb_tmr_voter.vhd
set_property top tb_tmr_voter [get_filesets sim_1]
launch_simulation
run 1000ns
```

### Implementation

```tcl
# Synthesis + Implementation
synth_design -top tmr_voter -part xc7a100tcsg324-1
opt_design
place_design
route_design
report_timing_summary
report_utilization
report_power
```

### XDC Constraints (constraints/tmr_voter.xdc)

```xdc
# 100 MHz system clock constraint
create_clock -period 10.000 -name clk [get_ports clk]
```

---

## Research Contributions

1. **Glitch-free synchronous TMR** — a registered voter output that eliminates transient routing hazards present in purely combinational TMR voter implementations.
2. **Single-cycle FDI telemetry** — the fault isolation engine identifies the specific corrupted core within exactly one clock cycle, designed as a handshake signal for an external scrubbing or DFX-based recovery subsystem.
3. **Low area overhead at current scale** — 7 LUTs and 5 FFs for the complete resilience layer protecting a minimal state machine, with a projected linear scaling model for wider state widths.
4. **Behavioral verification under single-core and sequential multi-core fault injection**, demonstrating output continuity as long as no more than one of three cores is corrupted at a given time.
5. **Timing-closed silicon implementation** at 100 MHz (WPWS: 4.500 ns, zero failing endpoints) on real Artix-7 hardware, not simulation alone.

---

## Academic Affiliation

**Author:** Faiza Khoso (Roll No: 23ES011)
**Department:** Electronic Engineering
**Institution:** Mehran University of Engineering and Technology (MUET), Jamshoro, Pakistan

This work is integrated into the author's Final Year Project on a radiation-prone FPGA DAQ system for cosmic ray muon detection. The accompanying paper draft is currently under academic review and revision.

---

## Future Work

- [ ] Extend TMR+FDI protection to a 16-bit counter representative of TDC tally-register width, with validation on physical Nexys 4 DDR hardware
- [ ] Add a structured qualitative comparison against the Xilinx SEM core and SEM TMR interface (detection layer, latency, correction mechanism, platform)
- [ ] Implement a scrubbing or DFX-based correction mechanism that consumes the `sig_fault_det` / `sig_faulty_core` telemetry to actually trigger recovery
- [ ] Add an AXI4-Lite interface for telemetry readout via a Zynq-7000 PS ARM core
- [ ] Pursue physical radiation (proton or heavy-ion) testing to validate the simulation-based SEU model

---

## License

MIT License — open for research and educational use. If this work contributes to your research, a citation or acknowledgment is appreciated.

---

<div align="center">
<sub>VHDL · Timing-Closed on Artix-7 · Draft Under Academic Review</sub>
</div>
