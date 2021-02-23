// 2021-02-08 water bath turbine circulator

beakerDiameter = 80;
stirRodDiameter = 8;
thickness = 5;
fanBlades = 6;
legs = 6;

beakerRadius = beakerDiameter / 2;
stirRodRadius = stirRodDiameter / 2;

$fn = 60;
$vpr=[55,0,$t*60];
$vpt = [0,0,-10];
$vpd = 160;

difference(){
    translate([0,0,0]){
        // Outer ring
        difference(){
            cylinder(thickness, beakerRadius, beakerRadius);
            cylinder(thickness*3, beakerRadius-thickness, beakerRadius-thickness, center = true);
        }

        // Inner ring
        difference(){
            cylinder(thickness, beakerRadius/2, beakerRadius/2);
            cylinder(thickness*3, beakerRadius/2-thickness, beakerRadius/2-thickness, center = true);
        }

        // Fan blades
        intersection(){
            for(i = [0:360/fanBlades:360]){
                rotate([0,0,i]){
                    translate([beakerRadius/2, 0, 0]){
                        rotate([45,0,0]){
                            cube([beakerRadius, thickness, beakerDiameter], center = true);
                        }
                    }
                }
            }
            difference(){
                cylinder(thickness, beakerRadius, beakerRadius);
                cylinder(thickness*3, beakerRadius/2, beakerRadius/2, center = true);
            }
        }

        // Feet
        for(i = [0:360/legs:360]){
            rotate([0,0,i]){
                translate([beakerRadius - thickness/2,0,-stirRodDiameter - thickness]){
                    cylinder(stirRodDiameter+thickness*1.5, thickness/2, thickness/2);
                }
            }
        }
    }
    translate([0,-beakerRadius,-50]){
        cube([beakerRadius, beakerDiameter, 100]);
    }
}