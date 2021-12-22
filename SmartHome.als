// type without internal structure
sig Name {}
sig Value {}

//////////////////////////////// TYPES
//Accessory type
sig Type{
}

//lightbulb
sig LightBulbType extends Type{}
//camera
sig CameraType extends Type{}
//move sensors
sig SensorType extends Type{}

//////////////////////////////// ACTIONS
//Actions of various accessories
sig Action{
}

//lightbulb actions:
//value = intensity of light
sig LightBulb_Action extends Action{
  value : one Value,
}

//Camera actions
//horizontalAngle = horizontal angle of camera position
//verticalAngle = vertical angle of camera position
//state = current camera state
sig Camera_Action extends Action{
  horizontalAngle : one Value,
  verticalAngle : one Value,
  state : one CameraState,
}

//Move sensor actions
//horizontalAngle = horizontal angle of sensor position
//verticalAngle = vertical angle of sensor position
//state = current sensor state
sig Sensor_Action extends Action{
  horizontalAngle : one Value,
  verticalAngle : one Value,
  state : one SensorState,
}

//////////////////////////////// ENUMS
//Enum for camera states
sig CameraState{}
sig CameraState_recording extends CameraState{}
sig CameraState_notRecording extends CameraState{}

//Enum for sensor state
sig SensorState{}
sig SensorState_monitoring extends SensorState{}
sig SensorState_notMonitoring extends SensorState{}


//Accessory signature
//name = name identifier
//type = type of accessory
//action = action of Accessory
//placedIn = room this accessory is placed in
sig Accessory{
  name : one Name,
  type : one Type,
  action : one Action,
}

//Room signature
//name = name identifier
//house = house this accessory is placed in
//accessories = set of accessories in this room
sig Room{
  name : one Name,
  accesories : set Accessory,
}

//House signature
//name = name identifier
//rooms = set of rooms this house consists of
sig House{
  name : one Name,
  rooms : set Room,
}

//////////////////////////////// ROOMS
sig LivinRoom extends Room{}
sig Kitchen extends Room{}
sig HostRoom extends Room{}
sig ToiletRoom extends Room{}
sig BathRoom extends Room{}
sig Hallway extends Room{}

fact {Room = LivinRoom + Kitchen + HostRoom + ToiletRoom + BathRoom + Hallway}
fact {Action = LightBulb_Action + Camera_Action + Sensor_Action}
fact {Type = LightBulbType + CameraType + SensorType}
fact {CameraState = CameraState_recording + CameraState_notRecording}
fact {SensorState = SensorState_monitoring + SensorState_notMonitoring}

//////////////////////////////// BASIC FACTS
//IDENTIFICATION
//All rooms are part of some house
fact {all r1: Room | some h : House | r1 in h.rooms}
//All rooms are identified by its name
fact {all r1: Room, r2: Room | r1.name = r2.name => r1 = r2}
//All accessories are identified by its name
fact {all a1: Accessory, a2: Accessory| a1.name = a2.name => a1 = a2}
//All houses are identified by its name
fact {all h1: House, h2: House | h1.name = h2.name => h1 = h2}
//All names are unique
fact {all h: House | all r1: Room| all a: Accessory | 
      h.name != r1.name and h.name != a.name and r1.name != a.name}


//QUANTITY
//Every room has at least one accessory in it
fact {all a: Accessory | some r1: Room | a in r1.accesories}
//All actions are performed in some accessory
fact {all act: Action | some acc: Accessory | acc.action = act}
//All types are types of some accessory
fact {all t: Type | some acc: Accessory | acc.type = t}
//Every camera state is attached to camera action
fact {all cs: CameraState | some cas: Camera_Action | cas.state = cs}
//Every sensor state is attached to sensor action
fact {all ss: SensorState | some sa: Sensor_Action | sa.state = ss}



//REALTION BETWEEN TYPE AND ACTION
fact {all a: Accessory | a.type = CameraType <=> a.action = Camera_Action}
fact {all a: Accessory | a.type = SensorType <=> a.action = Sensor_Action}
fact {all a: Accessory | a.type = LightBulbType <=> a.action = LightBulb_Action}

//////////////////////////////// ROOM SPECIFIC FACTS

//TOILET ROOM
//we dont have cameras in toilet room
fact {all r1: ToiletRoom | all a : Accessory | 
     a in r1.accesories => a.type != CameraType}

//BATH ROOM
//we dont have cameras in bathroom
fact {all r1: BathRoom | all a : Accessory |
      a in r1.accesories => a.type != CameraType}

// //HALLWAY
// //We have move sensors only in hallway
fact {all a: Accessory | a.type = SensorType => some hl: Hallway | a in hl.accesories}



pred myinst{}


run myinst for 1 but exactly 1 House, exactly 1 Hallway, exactly 2 Accessory, exactly 4 Name


//fact { #Director > 2 }
