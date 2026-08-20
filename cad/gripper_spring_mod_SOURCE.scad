// ============================================================
// Spring-loaded compliant tip retrofit for the mantis gripper
// (LimpSquid, Thingiverse thing:1748596)
// Cuts the outer ~20mm off each jaw's tip and replaces it with
// a spring-backed sliding pad, so the claw can close on an
// object without stalling the servo or crushing it.
// ============================================================

$fn = 32;

// ---- per-jaw tip geometry (measured from the STL) ----
// tip apex point (x,y,z) and local sweep direction (dx,dz) in the X-Z plane
origin_120 = [60.02, 0, 0];
dir_120    = [-23.21, 20];
origin_72  = [49.07, 0, 0];
dir_72     = [-23.21, 20]; // same taper angle, confirmed from mesh data

thickness  = 17.5; // full part thickness (Y axis)

// ---- retrofit parameters ----
cut_L      = 20;   // how much of the tip we remove & replace, along local axis (mm)
channel_L  = 16;   // depth of the socket pocket cut into the remaining rigid jaw (mm)
channel_W  = 10;   // width of the socket, local X' (mm) -- leaves rails each side
wall_y     = 3;     // material left on each Y face (thickness direction)
spring_od  = 6.0;
spring_pocket_d = spring_od + 0.6;
travel     = 5;    // how far the pad can retract, mm

module local(origin, dir) {
    ang = atan2(dir[0], dir[1]); // rotation about Y to align local Z' with (dx,dz)
    translate(origin) rotate([0, -ang, 0]) children();
}

// full-width box used to slice the tip off
module slice_tool(zlo, zhi, xhalf=45) {
    translate([-xhalf, -10, zlo]) cube([xhalf*2, thickness+20, zhi-zlo]);
}

// socket pocket cut into the remaining rigid stub (narrower, leaves rails+walls)
module socket_tool(z0, depth) {
    translate([-channel_W/2, wall_y, z0]) cube([channel_W, thickness-2*wall_y, depth]);
}

// spring pocket, bored from the cut face inward
module spring_tool(z0, depth) {
    translate([0, thickness/2, z0]) rotate([-90,0,0]) cylinder(d=spring_pocket_d, h=depth);
}

// retention pin hole through the side (X direction), positioned mid-socket
module pin_tool(z0) {
    translate([0, thickness/2, z0]) rotate([0,90,0]) cylinder(d=1.8, h=channel_W+4, center=true);
}

// ---- build the modified rigid base (tip cut off + socket added) ----
module jaw_base(stl, origin, dir) {
    difference() {
        import(stl);
        local(origin, dir) slice_tool(0, cut_L);          // remove outer tip
        local(origin, dir) socket_tool(cut_L - channel_L, channel_L + 1); // socket pocket
        local(origin, dir) spring_tool(cut_L - channel_L - 8, 8.5);       // spring pocket
        local(origin, dir) pin_tool(cut_L - 4);            // retention pin hole
    }
}

// ---- build the new compliant tip piece ----
// = original tip geometry (isolated, kept in GLOBAL coords) + rail tab + spring boss
// (both added in the LOCAL blade frame, transformed into global via local())
module jaw_tip(stl, origin, dir) {
    difference() {
        union() {
            // original tip shape, isolated -- import stays global, only the tool moves
            intersection() {
                import(stl);
                local(origin, dir) slice_tool(-6, cut_L); // keep a little overlap margin at the very point
            }
            // rail tab that slides into the socket, hulled to a solid anchor point
            // well inside the original tooth geometry -- guarantees a strong,
            // manifold connection even if the local-frame approximation drifts
            // slightly from the STL's actual curved surface.
            local(origin, dir)
                hull() {
                    translate([-channel_W/2+0.4, wall_y+0.4, cut_L - channel_L])
                        cube([channel_W-0.8, thickness-2*wall_y-0.8, channel_L - 2]);
                    translate([0, thickness/2, cut_L - 6])
                        sphere(d=channel_W-1);
                }
            // spring-seat boss on the back of the tab
            local(origin, dir)
                translate([0, thickness/2, cut_L - channel_L - 6])
                    cylinder(d=spring_od-1, h=6);
        }
        // retention slot (elongated so the tip can travel)
        local(origin, dir)
            translate([0, thickness/2, cut_L - 4])
                rotate([0,90,0])
                hull(){
                    cylinder(d=1.8, h=channel_W+6, center=true);
                    translate([travel,0,0])
                        cylinder(d=1.8, h=channel_W+6, center=true);
                }
    }
}

part = "exploded"; // base_120 | tip_120 | base_72 | tip_72 | preview

if (part == "base_120") jaw_base("Gripper_120T.STL", origin_120, dir_120);
else if (part == "tip_120") jaw_tip("Gripper_120T.STL", origin_120, dir_120);
else if (part == "base_72") jaw_base("Gripper_72T.STL", origin_72, dir_72);
else if (part == "tip_72") jaw_tip("Gripper_72T.STL", origin_72, dir_72);
else if (part == "preview") {
    color("SteelBlue") jaw_base("Gripper_120T.STL", origin_120, dir_120);
    color("Orange") jaw_tip("Gripper_120T.STL", origin_120, dir_120);
}

module exploded_preview() {
    color("SteelBlue") jaw_base("Gripper_120T.STL", origin_120, dir_120);
    color("Orange")
        translate([25, 0, -20])
            jaw_tip("Gripper_120T.STL", origin_120, dir_120);
}
if (part == "exploded") exploded_preview();
