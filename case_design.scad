// We want to have an empty box,
// inner size

box_inner_x = 145;
box_inner_y = 200;
box_inner_height = 28;
wall_thickness = 2;
standoff_size = 5;

// M7 Screw, Medium Fit Clearance Hole (https://engineersbible.com/clearance-hole-metric/)
encoder_diameter = 7.6;



difference(){
  box_with_standoffs();
  cutout_encoder();
}

module cutout_encoder() {
    translate([((box_inner_x+(2*wall_thickness)))/2, 
                 wall_thickness,
                 ((box_inner_height+wall_thickness))/2]) {
        rotate(a=[90,0,0]) {
            cylinder(wall_thickness, encoder_diameter, encoder_diameter);
        }
}
}


// The Box with standoffs
module box_with_standoffs() {
emptybox();
// We need for standoff, their center is 20mm away from the long side, 10mm away from the short
translate([wall_thickness + 10 - (standoff_size/2), wall_thickness + 20 - (standoff_size/2),0]) standoff();
translate([wall_thickness + box_inner_x - 10 - (standoff_size/2), wall_thickness + 20 - (standoff_size/2),0]) standoff();
translate([wall_thickness + 10 - (standoff_size/2), wall_thickness + box_inner_y - 20 - (standoff_size/2),0]) standoff();
translate([wall_thickness + box_inner_x - 10 - (standoff_size/2), wall_thickness + box_inner_y - 20 - (standoff_size/2),0]) standoff();
}
// standoff
module standoff() {
  cube([standoff_size, standoff_size, box_inner_height]) ;  
}


// empty box
module emptybox() {
difference() {
color([1,0,0]) basebox();
translate ([wall_thickness,wall_thickness,wall_thickness])color([0,1,0])box_cutout();
}
}

// basebox
module basebox() {
    cube([box_inner_x + wall_thickness*2, box_inner_y + wall_thickness*2, box_inner_height + wall_thickness]);
}

// basebox
module box_cutout() {
    cube([box_inner_x, box_inner_y, box_inner_height]);
}
