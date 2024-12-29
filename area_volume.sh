#!/bin/bash

# Mini script for computing geometric volumes and areas
# Launch the script for possible actions

function cylinder() {
    echo "Pass the height of the cylinder: ";
    read h;

    echo "Pass the radius of the cylinder base: ";
    read r;

    v=$(( 3,14*"$r"*"$r"*"$h" ));
    pp=$(( 3,14*"$r"*"$r"));
    ppb=$(( 3,14*2*"$r"*"$h"));
    p=$(($pp+$pp+$ppb));

    echo -e "\n CYLINDER DATA:";
    echo "Volume: "$v"";
    echo "Base Area: "$pp"";
    echo "Side Area: "$ppb"";
    echo "Total Area: "$p"";
}

function sphere() {

    echo "Pass the radius of the sphere: ";
    read r;

    v=$(( "$r"*"$r"*"$r"*(4/3)*3,14 ));
    p=$(( 4*3,14*"$r"*"$r"));

    echo -e "\n SPHERE DATA:";
    echo "Volume: "$v"";
    echo "Total Area: "$p"";
}

function cone() {
    echo "Pass the height of the cone: ";
    read h;

    echo "Pass the radius of the cones base: ";
    read r;

    l=$(echo "scale=0; sqrt($h^2 + $r^2)" | bc)
    
    v=$(( (3,14/3)*"$r"*"$r"*"$h" ));
    pp=$(( 3,14*"$r"*"$r"));
    ppb=$(( 3,14*"$r"*"$l"));
    p=$(($pp+$ppb));

    echo -e "\n CONE DATA:";
    echo "Volume: "$v"";
    echo "Base Area: "$pp"";
    echo "Side Area: "$ppb"";
    echo "Total Area: "$p"";
}

function cube() {
    echo "Pass the edge of the cube: ";
    read a;

    v=$(("$a"*"$a"*"$a" ));
    pp=$(( "$a"*"$a"));
    p=$(($pp*6));

    echo -e "\n CUBE DATA:";
    echo "Volume: "$v"";
    echo "Base Area: "$pp"";
    echo "Total Area: "$p"";
}

function mainMenu(){
    echo -e "\n WELCOME IN ARE_VOLUME PROGRAM, CHOOSE YOUR FIGURE: \n "
    select y in CYL SPH CONE CUBE Quit

    do
    case $y in
        "CYL") echo -e "YOU CHOSE: CYLINDER \n" 
        cylinder ;;
        "SPH") echo -e "YOU CHOSE: SPHERE \n" 
        sphere ;;
        "CONE") echo -e "YOU CHOSE: CONE \n" 
        cone ;;
        "CUBE") echo -e "YOU CHOSE: CUBE \n" 
        cube ;;
        "Quit") exit ;;
        *) echo "YOU DIDN'T MAKE APPROPRIATE DECISION! Exiting ...  "
        exit 1         
    esac
    break
    done

}

mainMenu