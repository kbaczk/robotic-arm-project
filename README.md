# Robotic Arm — with Spring-Loaded Compliant Gripper

A 5-DOF servo-driven robotic arm, built on [LimpSquid's open-source robotic arm design](https://www.thingiverse.com/thing:1838120), with a custom spring-loaded gripper tip I designed to add passive compliance to the end effector.

![Gripper render](images/preview_both_jaws.png)

**Status:** Design complete, gripper mod modelled and print-ready — currently awaiting 3D printer access for physical build and testing.

---

## Why I built this

Mechanical Engineering student at LJMU, going into third year. I wanted a hands-on mechatronics project that went beyond just assembling a kit — something that involved genuine mechanical design, not just following instructions.

The base arm design (turntable, arm, gripper) is a well-documented open-source project by [LimpSquid](https://www.thingiverse.com/LimpSquid/about). Rather than print it as-is, I identified a real limitation in the stock gripper — the rigid gear-driven jaws either slip on soft/irregular objects or risk stalling the servo/crushing the object when closing on something firm — and designed a fix.

## What I changed: spring-loaded compliant gripper tips

The original gripper is a scissor-style "mantis" claw: two curved, gear-driven jaws (`Gripper_120T` and `Gripper_72T`) that pivot on a shared bearing and mesh with a central servo-driven gear.

I modified both jaws by:
1. Measuring the original STL mesh to find the exact tip geometry and sweep angle of each jaw
2. Computationally cutting the outer ~20mm off each jaw's tip along its natural sweep direction
3. Designing a socket-and-spring pocket into the remaining rigid jaw
4. Designing a matching sliding tip module — carrying the original jaw's tooth geometry — that seats a small compression spring and can retract a few millimetres under load

This is a form of **underactuation**: one servo still drives both jaws, but the added mechanical compliance lets the gripper absorb overtravel passively, without needing force feedback or extra code. It's the same principle used in a lot of real prosthetic and pick-and-place grippers.

| | Original | Modified |
|---|---|---|
| Tip | Rigid, fixed to jaw | Spring-loaded, ~5mm travel |
| Grip on irregular objects | Poor — first point of contact takes full force | Better — tip conforms slightly |
| Risk of stall/crush | Higher | Lower — spring absorbs overtravel |

Full design reasoning, including how the cut angle and socket dimensions were derived from the mesh, is in [`docs/design-notes.md`](docs/design-notes.md).

---

## Repo structure

```
├── cad/            # OpenSCAD source (and SolidWorks files, once modelled)
│   └── gripper_spring_mod_SOURCE.scad
├── stl/
│   ├── original/   # Unmodified LimpSquid STLs (arm, turntable, gripper)
│   └── modified/   # My spring-loaded gripper tip + base parts
├── images/         # Renders and (once built) real photos
├── docs/
│   └── design-notes.md
└── README.md
```

---

## Bill of materials

**Structure:** PLA or PETG, printed per-part (see `stl/original` and `stl/modified`)

**Hardware (per LimpSquid's original BOM, arm + turntable + gripper):**
- 5x standard-size servo (e.g. TowerPro MG995)
- 2x 688zz bearing (8x16x5mm)
- M3 x 8mm, M3 x 10mm, M3 x 16mm, M3 x 63mm round head screws + M3 nuts
- M4 x 16mm round head screws

**Added for the spring-loaded gripper mod:**
- 2x small compression spring (~6mm OD, ~14mm free length)
- 2x short retention pin (~1.8mm — e.g. cut paperclip)

**Electronics:**
- Arduino Uno
- PCA9685 servo driver board (HCPCA9685 or Adafruit PWM Servo Driver library)
- 6x standard servo (e.g. MG996R)
- NEMA-17 stepper motor + A4988 driver (for base rotation)
- 5V, 2200mAh battery pack for servo power (do not power servos from the Arduino's 5V pin)
- Arduino code from [Eben Kouao's arduino-robot-arm repo](https://github.com/EbenKouao/arduino-robot-arm)
- [Optional] Robotic glove for gesture control: 3x flex sensors, 2x MPU6050, Arduino Nano, HC-05 Bluetooth modules (glove side + arm side)

---

## Build instructions

1. Print all parts — see [LimpSquid's original assembly notes](https://www.thingiverse.com/thing:1838120) for the base arm and turntable, and `docs/design-notes.md` for the gripper mod-specific assembly.
2. For the gripper: assemble as normal, but insert a compression spring into each jaw's spring pocket before sliding the tip module's rail into the socket, then secure with the retention pin.
3. Wire servos to the Arduino with a separate power supply.
4. [Add your control code / link to a `/code` folder once written]

---

## Credit & license

Base arm, turntable, and gripper mechanism designed by **Wonder Tiger** on Thingiverse ([gripper](https://www.thingiverse.com/thing:1748596), [base/turntable](https://www.thingiverse.com/thing:1750025), [arm](https://www.thingiverse.com/thing:1838120)), used and modified under the original design's license (see `LICENSE.txt` in each `stl/original` subfolder).

Control electronics, Arduino code, and tutorial by [Eben Kouao / SmartBuilds.io](https://smartbuilds.io/diy-robot-arm-arduino-hand-gestures/) ([code repo](https://github.com/EbenKouao/arduino-robot-arm)).

Robotic glove STL by **Roman 13** on Thingiverse ([thing:1982745](https://www.thingiverse.com/thing:1982745)) — only relevant if you build the gesture-control glove.

Spring-loaded gripper tip modification designed by [Your Name].

---

## Contact

[Your Name] — Mechanical Engineering, Liverpool John Moores University
[LinkedIn] · [Email]
