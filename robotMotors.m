(* ::Package:: *)

(* ::Title:: *)
(*Robot code*)


(* ::Subchapter:: *)
(*Functions*)


updateSensors[pins_List]:=Module[{temporary,sensorVector},temporary=DeviceRead["GPIO",pins];sensorVector=Table[temporary[pins[[i]]],{i,Length[pins]}]]


getTimeDifference[tNow_,tBefore_]:=Module[{},Round[QuantityMagnitude[UnitConvert[tNow-tBefore,"Seconds"]]]]


updatePosition[currentTime_,statusOld_List,speed_List]:=Module[{newPosition,\[CapitalDelta]t=getTimeDifference[currentTime,statusOld[[1]]]},
newPosition=\!\(\*
TagBox[GridBox[{
{"\[Piecewise]", GridBox[{
{
RowBox[{"Round", "[", 
RowBox[{
RowBox[{"statusOld", "[", 
RowBox[{"[", "2", "]"}], "]"}], "+", 
RowBox[{
RowBox[{"{", 
RowBox[{"0", ",", "\[CapitalDelta]t"}], "}"}], "*", "speed"}]}], "]"}], 
RowBox[{
RowBox[{"statusOld", "[", 
RowBox[{"[", "3", "]"}], "]"}], "==", "\"\<Forward\>\""}]},
{
RowBox[{"Round", "[", 
RowBox[{
RowBox[{"statusOld", "[", 
RowBox[{"[", "2", "]"}], "]"}], "-", 
RowBox[{
RowBox[{"{", 
RowBox[{"0", ",", "\[CapitalDelta]t"}], "}"}], "*", "speed"}]}], "]"}], 
RowBox[{
RowBox[{"statusOld", "[", 
RowBox[{"[", "3", "]"}], "]"}], "==", "\"\<Back\>\""}]},
{
RowBox[{"Round", "[", 
RowBox[{
RowBox[{"statusOld", "[", 
RowBox[{"[", "2", "]"}], "]"}], "-", 
RowBox[{
RowBox[{"{", 
RowBox[{"\[CapitalDelta]t", ",", "0"}], "}"}], "*", "speed"}]}], "]"}], 
RowBox[{
RowBox[{"statusOld", "[", 
RowBox[{"[", "3", "]"}], "]"}], "==", "\"\<Left\>\""}]},
{
RowBox[{"Round", "[", 
RowBox[{
RowBox[{"statusOld", "[", 
RowBox[{"[", "2", "]"}], "]"}], "+", 
RowBox[{
RowBox[{"{", 
RowBox[{"\[CapitalDelta]t", ",", "0"}], "}"}], "*", "speed"}]}], "]"}], 
RowBox[{
RowBox[{"statusOld", "[", 
RowBox[{"[", "3", "]"}], "]"}], "==", "\"\<Right\>\""}]},
{
RowBox[{"statusOld", "[", 
RowBox[{"[", "2", "]"}], "]"}], 
RowBox[{
RowBox[{"statusOld", "[", 
RowBox[{"[", "3", "]"}], "]"}], "==", "\"\<Stop\>\""}]}
},
AllowedDimensions->{2, Automatic},
Editable->True,
GridBoxAlignment->{"Columns" -> {{Left}}, "ColumnsIndexed" -> {}, "Rows" -> {{Baseline}}, "RowsIndexed" -> {}, "Items" -> {}, "ItemsIndexed" -> {}},
GridBoxItemSize->{"Columns" -> {{Automatic}}, "ColumnsIndexed" -> {}, "Rows" -> {{1.}}, "RowsIndexed" -> {}, "Items" -> {}, "ItemsIndexed" -> {}},
GridBoxSpacings->{"Columns" -> {Offset[0.27999999999999997`], {Offset[0.84]}, Offset[0.27999999999999997`]}, "ColumnsIndexed" -> {}, "Rows" -> {Offset[0.2], {Offset[0.4]}, Offset[0.2]}, "RowsIndexed" -> {}, "Items" -> {}, "ItemsIndexed" -> {}},
Selectable->True]}
},
GridBoxAlignment->{"Columns" -> {{Left}}, "ColumnsIndexed" -> {}, "Rows" -> {{Baseline}}, "RowsIndexed" -> {}, "Items" -> {}, "ItemsIndexed" -> {}},
GridBoxItemSize->{"Columns" -> {{Automatic}}, "ColumnsIndexed" -> {}, "Rows" -> {{1.}}, "RowsIndexed" -> {}, "Items" -> {}, "ItemsIndexed" -> {}},
GridBoxSpacings->{"Columns" -> {Offset[0.27999999999999997`], {Offset[0.35]}, Offset[0.27999999999999997`]}, "ColumnsIndexed" -> {}, "Rows" -> {Offset[0.2], {Offset[0.4]}, Offset[0.2]}, "RowsIndexed" -> {}, "Items" -> {}, "ItemsIndexed" -> {}}],
"Piecewise",
DeleteWithContents->True,
Editable->False,
SelectWithContents->True,
Selectable->False]\)
]


updateWalls2[location_,statusOld_List,sensorsNow_List]:=
Module[
{x=location[[1]],y=location[[2]],newWalls,blockPerimeter},

blockPerimeter=sensorsNow*{{x,y+1},{x+1,y},{x,y-1},{x-1,y}};

blockPerimeter=DeleteCases[blockPerimeter,{0,0}];

newWalls=Join[statusOld[[5]],blockPerimeter];

If[Length[newWalls]>1,newWalls=DeleteCases[newWalls,{}],Nothing];

newWalls
]


updateMap[location_List,currentTime_,statusOld_List]:=Module[
{newMap=statusOld[[6]],mapSurface,\[CapitalDelta]t=getTimeDifference[currentTime,statusOld[[1]]]},
mapSurface=\!\(\*
TagBox[GridBox[{
{"\[Piecewise]", GridBox[{
{
RowBox[{"Table", "[", 
RowBox[{
RowBox[{"{", 
RowBox[{
RowBox[{"location", "[", 
RowBox[{"[", "1", "]"}], "]"}], ",", 
RowBox[{
RowBox[{"statusOld", "[", 
RowBox[{"[", 
RowBox[{"2", ",", "2"}], "]"}], "]"}], "+", "i"}]}], "}"}], ",", 
RowBox[{"{", 
RowBox[{"i", ",", "\[CapitalDelta]t"}], "}"}]}], "]"}], 
RowBox[{
RowBox[{"statusOld", "[", 
RowBox[{"[", "3", "]"}], "]"}], "==", "\"\<Forward\>\""}]},
{
RowBox[{"Table", "[", 
RowBox[{
RowBox[{"{", 
RowBox[{
RowBox[{"location", "[", 
RowBox[{"[", "1", "]"}], "]"}], ",", 
RowBox[{
RowBox[{"statusOld", "[", 
RowBox[{"[", 
RowBox[{"2", ",", "2"}], "]"}], "]"}], "-", "i"}]}], "}"}], ",", 
RowBox[{"{", 
RowBox[{"i", ",", "\[CapitalDelta]t"}], "}"}]}], "]"}], 
RowBox[{
RowBox[{"statusOld", "[", 
RowBox[{"[", "3", "]"}], "]"}], "==", "\"\<Back\>\""}]},
{
RowBox[{"Table", "[", 
RowBox[{
RowBox[{"{", 
RowBox[{
RowBox[{
RowBox[{"statusOld", "[", 
RowBox[{"[", 
RowBox[{"2", ",", "1"}], "]"}], "]"}], "+", "i"}], ",", 
RowBox[{"location", "[", 
RowBox[{"[", "2", "]"}], "]"}]}], "}"}], ",", 
RowBox[{"{", 
RowBox[{"i", ",", "\[CapitalDelta]t"}], "}"}]}], "]"}], 
RowBox[{
RowBox[{"statusOld", "[", 
RowBox[{"[", "3", "]"}], "]"}], "==", "\"\<Right\>\""}]},
{
RowBox[{"Table", "[", 
RowBox[{
RowBox[{"{", 
RowBox[{
RowBox[{
RowBox[{"statusOld", "[", 
RowBox[{"[", 
RowBox[{"2", ",", "1"}], "]"}], "]"}], "-", "i"}], ",", 
RowBox[{"location", "[", 
RowBox[{"[", "2", "]"}], "]"}]}], "}"}], ",", 
RowBox[{"{", 
RowBox[{"i", ",", "\[CapitalDelta]t"}], "}"}]}], "]"}], 
RowBox[{
RowBox[{"statusOld", "[", 
RowBox[{"[", "3", "]"}], "]"}], "==", "\"\<Left\>\""}]},
{
RowBox[{"{", 
RowBox[{"statusOld", "[", 
RowBox[{"[", "2", "]"}], "]"}], "}"}], 
RowBox[{
RowBox[{"statusOld", "[", 
RowBox[{"[", "3", "]"}], "]"}], "==", "\"\<Stop\>\""}]}
},
AllowedDimensions->{2, Automatic},
Editable->True,
GridBoxAlignment->{"Columns" -> {{Left}}, "ColumnsIndexed" -> {}, "Rows" -> {{Baseline}}, "RowsIndexed" -> {}, "Items" -> {}, "ItemsIndexed" -> {}},
GridBoxItemSize->{"Columns" -> {{Automatic}}, "ColumnsIndexed" -> {}, "Rows" -> {{1.}}, "RowsIndexed" -> {}, "Items" -> {}, "ItemsIndexed" -> {}},
GridBoxSpacings->{"Columns" -> {Offset[0.27999999999999997`], {Offset[0.84]}, Offset[0.27999999999999997`]}, "ColumnsIndexed" -> {}, "Rows" -> {Offset[0.2], {Offset[0.4]}, Offset[0.2]}, "RowsIndexed" -> {}, "Items" -> {}, "ItemsIndexed" -> {}},
Selectable->True]}
},
GridBoxAlignment->{"Columns" -> {{Left}}, "ColumnsIndexed" -> {}, "Rows" -> {{Baseline}}, "RowsIndexed" -> {}, "Items" -> {}, "ItemsIndexed" -> {}},
GridBoxItemSize->{"Columns" -> {{Automatic}}, "ColumnsIndexed" -> {}, "Rows" -> {{1.}}, "RowsIndexed" -> {}, "Items" -> {}, "ItemsIndexed" -> {}},
GridBoxSpacings->{"Columns" -> {Offset[0.27999999999999997`], {Offset[0.35]}, Offset[0.27999999999999997`]}, "ColumnsIndexed" -> {}, "Rows" -> {Offset[0.2], {Offset[0.4]}, Offset[0.2]}, "RowsIndexed" -> {}, "Items" -> {}, "ItemsIndexed" -> {}}],
"Piecewise",
DeleteWithContents->True,
Editable->False,
SelectWithContents->True,
Selectable->False]\);
If[statusOld[[3]]!="Stop",newMap=Join[newMap,mapSurface]];
newMap
]


updateDirection2[dirs_List,buttons_List,current_String]:=
Module[{i,obstacles,placeholder,placeholder2,nextdir,placeholder3},
obstacles=Table[1-buttons[[i]],{i,Length[buttons]}];
placeholder3=DeleteCases[dirs,"Stop"];
placeholder2=DeleteCases[placeholder3*obstacles,0];
If[
MemberQ[placeholder3*obstacles,current],
nextdir=current,
nextdir=RandomChoice[placeholder2]
]]


moveRobot[where_String]:=Module[{output},
output=\!\(\*
TagBox[GridBox[{
{"\[Piecewise]", GridBox[{
{
RowBox[{"IntegerDigits", "[", 
RowBox[{"1", ",", "2", ",", "4"}], "]"}], 
RowBox[{"where", "==", "\"\<Back\>\""}]},
{
RowBox[{"IntegerDigits", "[", 
RowBox[{"1", ",", "2", ",", "4"}], "]"}], 
RowBox[{"where", "==", "\"\<Forward\>\""}]},
{
RowBox[{"IntegerDigits", "[", 
RowBox[{"4", ",", "2", ",", "4"}], "]"}], 
RowBox[{"where", "==", "\"\<Left\>\""}]},
{
RowBox[{"IntegerDigits", "[", 
RowBox[{"8", ",", "2", ",", "4"}], "]"}], 
RowBox[{"where", "==", "\"\<Right\>\""}]},
{
RowBox[{"IntegerDigits", "[", 
RowBox[{"0", ",", "2", ",", "4"}], "]"}], 
RowBox[{"where", "==", "\"\<Stop\>\""}]}
},
AllowedDimensions->{2, Automatic},
Editable->True,
GridBoxAlignment->{"Columns" -> {{Left}}, "ColumnsIndexed" -> {}, "Rows" -> {{Baseline}}, "RowsIndexed" -> {}, "Items" -> {}, "ItemsIndexed" -> {}},
GridBoxItemSize->{"Columns" -> {{Automatic}}, "ColumnsIndexed" -> {}, "Rows" -> {{1.}}, "RowsIndexed" -> {}, "Items" -> {}, "ItemsIndexed" -> {}},
GridBoxSpacings->{"Columns" -> {Offset[0.27999999999999997`], {Offset[0.84]}, Offset[0.27999999999999997`]}, "ColumnsIndexed" -> {}, "Rows" -> {Offset[0.2], {Offset[0.4]}, Offset[0.2]}, "RowsIndexed" -> {}, "Items" -> {}, "ItemsIndexed" -> {}},
Selectable->True]}
},
GridBoxAlignment->{"Columns" -> {{Left}}, "ColumnsIndexed" -> {}, "Rows" -> {{Baseline}}, "RowsIndexed" -> {}, "Items" -> {}, "ItemsIndexed" -> {}},
GridBoxItemSize->{"Columns" -> {{Automatic}}, "ColumnsIndexed" -> {}, "Rows" -> {{1.}}, "RowsIndexed" -> {}, "Items" -> {}, "ItemsIndexed" -> {}},
GridBoxSpacings->{"Columns" -> {Offset[0.27999999999999997`], {Offset[0.35]}, Offset[0.27999999999999997`]}, "ColumnsIndexed" -> {}, "Rows" -> {Offset[0.2], {Offset[0.4]}, Offset[0.2]}, "RowsIndexed" -> {}, "Items" -> {}, "ItemsIndexed" -> {}}],
"Piecewise",
DeleteWithContents->True,
Editable->False,
SelectWithContents->True,
Selectable->False]\);
DeviceWrite["GPIO",{13->output[[1]],19->output[[2]],21->output[[3]],26->output[[4]]}]
Print[output]
]


(* ::Subchapter:: *)
(*Initialization*)


(* ::Section:: *)
(*Data from the control bin*)


controlBin=Databin["dSFSYX3k"];
Print[Last[Values[controlBin]]] (* Ensure that we can connect to the control bin *)


(* ::Section:: *)
(*GPIO pin assignment*)


pins={4,17,27,22}; (*Input pins*)
motors={5,6,13,19}; (*Output pins*)


(* ::Section:: *)
(*Initial position data*)


position={0,0};
velocity={1,1}; (* Adjust this to reflect the change in scale, currently the robot is used as unit of measurement *)
map={{0,0}};
walls={{}};
directions={"Forward","Right","Back","Left"};
sensors=updateSensors[pins];
pause=0.2;
nextDirection=RandomChoice[directions];
If[Last[Values[controlBin]][[2]]=="Control",nextDirection="Stop"];
(*bin=Databin[Last[Values[controlBin]][[1]]];*)
bin=Databin["e0WiAdJe"];
DatabinAdd[bin,{TimeObject[Now],position,nextDirection,sensors,walls,map}]

moveRobot[nextDirection]


(* ::Subsection:: *)
(*Print = Best debug technique!*)


Print[sensors,nextDirection,position];


(* ::Section:: *)
(*Scan mode*)


(* Scan mode *)
(* Add an if to check if there were any collisions? This would reduce the amount of updloads to the databin. *)

If[Last[Values[controlBin]][[2]]=="Scan" && Last[Values[controlBin]][[4]]=="Execute",
While[Last[Values[controlBin]][[2]]=="Scan" && Last[Values[controlBin]][[4]]=="Execute",

sensors=updateSensors[pins];

timestampNew=TimeObject[Now];

previousStatus=Last[Values[bin]];

positionNew=updatePosition[timestampNew,previousStatus,velocity];

wallsNew=updateWalls2[positionNew,previousStatus,sensors];

mapNew=updateMap[positionNew,timestampNew,previousStatus];

nextDirection=updateDirection2[directions,sensors,previousStatus[[3]]];

(* Due to upload restrictions for the Wolfram Data Drop, the If statements ensures that data is only updloaded when a change in direction or sensor readings occur *)
If[Total[sensors]!=0||nexDirection!=Last[Values[controlBin]][[3]],DatabinAdd[bin,{timestampNew,positionNew,nextDirection,sensors,wallsNew,mapNew}]]; 

Print[sensors,nextDirection,positionNew] (* Mad debug skills *)
moveRobot[nextDirection]
Pause[pause]
]
]


(* ::Section:: *)
(*Control mode*)


(* Control mode *)
(* Should I remove the update status part? *)

If[Last[Values[controlBin]][[2]]=="Control"&&Last[Values[controlBin]][[4]]=="Execute",
While[Last[Values[controlBin]][[2]]=="Control"&&Last[Values[controlBin]][[4]]=="Execute",

sensors=updateSensors[pins];

timestampNew=TimeObject[Now];

previousStatus=Last[Values[bin]];

positionNew=updatePosition[timestampNew,previousStatus,velocity];

wallsNew=updateWalls2[positionNew,previousStatus,sensors];

mapNew=updateMap[positionNew,timestampNew,previousStatus];

nextDirection=Last[Values[controlBin]][[3]];

If[Total[sensors]!=0||nexDirection!=Last[Values[controlBin]][[3]],DatabinAdd[bin,{timestampNew,positionNew,nextDirection,sensors,wallsNew,mapNew}]];
Print[sensors,nextDirection,positionNew]
moveRobot[nextDirection]
Pause[pause]
]
]


(* ::Section:: *)
(*Shutdown code*)


DatabinAdd[bin,{timestampNew,positionNew,nextDirection,sensors,wallsNew,mapNew}]
moveRobot["Stop"]
