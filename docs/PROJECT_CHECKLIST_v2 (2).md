# Robotic Arm Project — Full To-Do List (v2)

Updated to reflect the real electronics setup: PCA9685 servo driver, NEMA-17 stepper for base rotation, HC-05 Bluetooth glove control — and the corrected attribution (Wonder Tiger for the STLs, Eben Kouao/SmartBuilds.io for the code).

Work through top to bottom — Phase 2 runs in parallel with Phase 1 while parts are printing.

## Phase 1 — Source & Print
- [ ] Source 2 small compression springs (~6mm OD, ~14mm free length)
- [ ] Source 2 retention pins (paperclip offcuts work fine)
- [ ] Source the real electronics BOM: 6x MG996R servo, PCA9685 driver board, NEMA-17 stepper, A4988 driver, Arduino Uno, HC-05 Bluetooth module, 5V 2200mAh battery pack
- [ ] *(If building the glove)* Source: Arduino Nano, 3x flex sensors, 2x MPU6050, second HC-05, resistors/capacitors per the tutorial's parts table
- [ ] Print the 4 spring-loaded gripper parts: `Gripper_120T_MODIFIED_base`, `Gripper_120T_spring_tip`, `Gripper_72T_MODIFIED_base`, `Gripper_72T_spring_tip`
- [ ] Print the rest of the arm + turntable parts, if not already done
- [ ] *(Optional but recommended)* Print one original unmodified rigid tip as a comparison control for testing

## Phase 2 — While Parts Are Printing (do this in parallel)
- [ ] Rebuild the gripper modification (socket, spring pocket, sliding tip) in SolidWorks or Fusion 360 — just your mod, not the whole arm
- [ ] Fork or clone [Eben Kouao's arduino-robot-arm repo](https://github.com/EbenKouao/arduino-robot-arm) — this is your starting code, not something to write from scratch
- [ ] Install the required libraries: HCPCA9685 (or the Adafruit PWM Servo Driver library as a working alternative — several tutorial commenters had trouble finding HCPCA9685)
- [ ] Read through the code and identify which pin/channel numbers you'll need to change to match your actual build
- [ ] Sketch your wiring diagram: servos → PCA9685 → Arduino, stepper → A4988 → Arduino, HC-05 → Arduino, separate battery pack for servo/stepper power

## Phase 3 — Assemble & Test-Fit
- [ ] Insert a spring into each socket, slide the tip's rail in, secure with the retention pin
- [ ] Check the slider moves smoothly and springs back on its own
- [ ] Adjust if needed — sand the rail if it's too tight, swap the spring if the stiffness feels wrong
- [ ] Note anything you changed — this becomes real content for design-notes.md
- [ ] Assemble the arm, turntable, and gripper per Wonder Tiger's original build notes

## Phase 4 — Wire & Test Electronics
- [ ] Wire the PCA9685 driver and confirm each servo channel moves correctly (upload a simple test first before the full gesture-control code)
- [ ] Wire the NEMA-17 + A4988 for base rotation, confirm it steps correctly
- [ ] *(If building the glove)* Wire and calibrate the flex sensors + MPU6050s, confirm values print correctly over serial before pairing Bluetooth
- [ ] Pair the two HC-05 modules (glove = master, arm = slave, baud rate 4800) if using gesture control
- [ ] Upload the full adapted code and test end-to-end movement

## Phase 5 — Comparison Testing (Gripper)
- [ ] Test 1: grip a soft/fragile object (grape, paper cup, foam ball) with the **rigid** tip — photo/video the result
- [ ] Test 1 repeat: same object, **spring-loaded** tip — photo/video the result
- [ ] Test 2: grip a hard/irregular object with both tips, compare how securely each holds it
- [ ] Record a short video/GIF showing the tip visibly compressing under pressure
- [ ] Log everything in a simple table: object / rigid tip result / spring tip result

## Phase 6 — Documentation Photos & Video
- [ ] Photo: all 4 printed gripper parts laid out on a plain background
- [ ] Photo: socket pocket empty, then with spring seated inside
- [ ] Photo: tip assembled into the socket with retention pin fitted
- [ ] Photo: full gripper, jaws open and closed
- [ ] Photo: whole arm + turntable assembled — this becomes your README hero image
- [ ] Video: the arm moving under gesture/manual control, and the gripper opening/closing on command

## Phase 7 — Set Up GitHub
- [ ] Create the GitHub repository
- [ ] Create folder structure: `cad/`, `stl/original/`, `stl/modified/`, `images/`, `docs/`, `code/`
- [ ] Check Wonder Tiger's original Thingiverse license terms before uploading their files
- [ ] Upload the original unmodified Wonder Tiger STLs into `stl/original/`
- [ ] Upload your 4 modified gripper STLs into `stl/modified/`
- [ ] Upload the `.scad` source file (and your SolidWorks file, once made) into `cad/`
- [ ] Upload all photos and video/GIF into `images/`
- [ ] Upload your adapted Arduino code into `code/`, keeping Eben Kouao's original repo linked/credited rather than presenting it as your own from scratch

## Phase 8 — Write the Documentation
- [ ] Finish `README.md`: swap placeholder renders for real photos, fill in your name/links, change status to "Built and tested"
- [ ] Write `docs/design-notes.md` in your own words, covering:
  - [ ] The problem with the original rigid jaws
  - [ ] Options you considered, and why you picked this one
  - [ ] How you measured the original mesh geometry
  - [ ] How you chose the cut location and socket dimensions
  - [ ] Spring selection and travel-distance reasoning
  - [ ] The connection bug you hit and how you fixed it
  - [ ] Your comparison test results (the table from Phase 5)
  - [ ] What you'd still test or improve
- [ ] Add an attribution/license note crediting **Wonder Tiger** (arm/turntable/gripper STLs), **Eben Kouao/SmartBuilds.io** (control code + tutorial), and **Roman 13** (glove STL, if used)

## Phase 9 — Polish the Repo
- [ ] Add a one-line repo description
- [ ] Add topics/tags: `robotics`, `arduino`, `mechatronics`, `3d-printing`, `mechanical-engineering`
- [ ] Pin the repo on your GitHub profile

## Phase 10 — Add to Your CV
- [ ] Add a Projects-section bullet point with the repo link
- [ ] Add it to LinkedIn (Featured section or a post), if you use it
- [ ] Re-read your design-notes.md so you can talk through the reasoning fluently at interview
- [ ] Mention the project to Hiren or in any placement conversations
