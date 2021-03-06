temp_inside := 200;
temp_outside := 180;
tempIn := REAL_TO_INT(temp_inside / 10.0);
tempOut := REAL_TO_INT(temp_outside / 10.0);
GVL.tempIn := tempIn;
GVL.tempOut := hour1.temp;
GVL.rain := hour1.rain;

//Exception in case of snow/ice
IF hour1.ice = TRUE OR hour2.ice = TRUE THEN
	PLC_PRG.exception := TRUE;
ELSE
	PLC_PRG.exception := FALSE;
END_IF

//If ground is wet, but might freeze later.
IF exception = FALSE AND hour1.rain > 0 AND hour1.temp > 0 THEN
	IF hour2.temp < 0 OR hour3.temp < 0 THEN
		PLC_PRG.exception := TRUE;
	ELSE
		PLC_PRG.exception := FALSE;
	END_IF
END_IF


//Normal conditions
IF hour1.rain > 0 AND hour1.temp < 0 THEN
	PLC_PRG.run := TRUE;
ELSE IF hour2.rain > 0 AND hour2.temp < 0 THEN
	 PLC_PRG.run := TRUE;
	 ELSE IF hour3.rain > 0 AND (tempOut <= -10 OR hour3.temp < -8) THEN
		PLC_PRG.run := TRUE;
		ELSE
			PLC_PRG.run := FALSE;
		END_IF	
	 END_IF
END_IF

(*
IF IoConfig_Globals_Mapping.Port = TRUE THEN
	//TURN HEATER/OVEN OFF
END_IF *)

//MODE OF OPERATION
//MODE 1
IF PLC_PRG.mode1 = 1 THEN
	PLC_PRG.enable1 := 0;
	PLC_PRG.manual1 := FALSE;
	PLC_PRG.auto1 := FALSE;
ELSE IF PLC_PRG.mode1 = 2 THEN
		PLC_PRG.enable1 := TRUE;
		PLC_PRG.manual1 := TRUE;
		PLC_PRG.auto1 := FALSE;
	ELSE IF PLC_PRG.mode1 = 3 THEN
			PLC_PRG.enable1 := TRUE;
			PLC_PRG.manual1 := FALSE;
			PLC_PRG.auto1 := TRUE;
		END_IF
	END_IF
END_IF
//MODE 2
IF PLC_PRG.mode2 = 1 THEN
	PLC_PRG.enable2 := 0;
	PLC_PRG.manual2 := FALSE;
	PLC_PRG.auto2 := FALSE;
ELSE IF PLC_PRG.mode2 = 2 THEN
		PLC_PRG.enable2 := TRUE;
		PLC_PRG.manual2 := TRUE;
		PLC_PRG.auto2 := FALSE;
	ELSE IF PLC_PRG.mode2 = 3 THEN
			PLC_PRG.enable2 := TRUE;
			PLC_PRG.manual2 := FALSE;
			PLC_PRG.auto2 := TRUE;
		END_IF
	END_IF
END_IF
//MODE 3
IF PLC_PRG.mode3 = 1 THEN
	PLC_PRG.enable3 := 0;
	PLC_PRG.manual3 := FALSE;
	PLC_PRG.auto3 := FALSE;
ELSE IF PLC_PRG.mode3 = 2 THEN
		PLC_PRG.enable3 := TRUE;
		PLC_PRG.manual3 := TRUE;
		PLC_PRG.auto3 := FALSE;
	ELSE IF PLC_PRG.mode3 = 3 THEN
			PLC_PRG.enable3 := TRUE;
			PLC_PRG.manual3 := FALSE;
			PLC_PRG.auto3 := TRUE;
		END_IF
	END_IF
END_IF
//MODE 4
IF PLC_PRG.mode4 = 1 THEN
	PLC_PRG.enable4 := 0;
	PLC_PRG.manual4 := FALSE;
	PLC_PRG.auto4 := FALSE;
ELSE IF PLC_PRG.mode4 = 2 THEN
		PLC_PRG.enable4 := TRUE;
		PLC_PRG.manual4 := TRUE;
		PLC_PRG.auto4 := FALSE;
	ELSE IF PLC_PRG.mode4 = 3 THEN
			PLC_PRG.enable4 := TRUE;
			PLC_PRG.manual4 := FALSE;
			PLC_PRG.auto4 := TRUE;
		END_IF
	END_IF
END_IF

//Enabling auto
(*
IF PLC_PRG.auto1 = TRUE OR PLC_PRG.auto2 = TRUE OR PLC_PRG.auto3 = TRUE OR PLC_PRG.auto4 = TRUE THEN
	PLC_PRG.xEnableAuto := TRUE;
ELSE
	PLC_PRG.xEnableAuto := FALSE;
END_IF*)

//Power measurement
kWh1 := DWORD_TO_REAL(PLC_PRG.timeMin1)*300/(1000*60.0);
kWh2 := DWORD_TO_REAL(PLC_PRG.timeMin2)*300/(1000*60.0);
kWh3 := DWORD_TO_REAL(PLC_PRG.timeMin3)*300/(1000*60.0);
kWh4 := DWORD_TO_REAL(PLC_PRG.timeMin4)*300/(1000*60.0);
kWh_Heating := kWh1 + kWh2 + kWh3 + kWh4;
kW_Heating := 0.3*(BOOL_TO_REAL(DO1)+BOOL_TO_REAL(DO2)+BOOL_TO_REAL(DO3)+BOOL_TO_REAL(DO4));


GVL.kW_Heating := kW_Heating;
GVL.kW_Charger := kW_Charger;
GVL.kW_Total := kW_Charger + kW_Heating;
GVL.kWh_Heating := kWh_Heating;
GVL.kWh_Charger := kWh_Charger;
GVL.kWh_Total := GVL.kWh_Heating + GVL.kWh_Charger;
