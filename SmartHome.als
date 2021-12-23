// basic types without internal structure
sig Name {}

//////////////////////////////// VALUES
sig Value{
}

//light intensity
sig LightValue extends Value{}
//angle value
sig AngleValue extends Value{}
//volume intensity
sig VolumeValue extends Value{}
//id of song
sig SongValue extends Value{}
//heat instensity
sig HeatValue extends Value{}


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
//music player
sig MusicPlayerType extends Type{}
//heater
sig HeaterType extends Type{}
//voice assistant
sig VoiceAssistantType extends Type{}
//control center
sig ControlCenterType extends Type{}

//////////////////////////////// ACTIONS
//Actions of various accessories
sig Action{
}

//lightbulb actions:
//value = intensity of light
sig LightBulb_Action extends Action{
  value : one LightValue,
}

//Camera actions
//horizontalAngle = horizontal angle of camera position
//verticalAngle = vertical angle of camera position
//state = current camera state
sig Camera_Action extends Action{
  horizontalAngle : one AngleValue,
  verticalAngle : one AngleValue,
  state : one CameraState,
}

//Move sensor actions
//horizontalAngle = horizontal angle of sensor position
//verticalAngle = vertical angle of sensor position
//state = current sensor state
sig Sensor_Action extends Action{
  horizontalAngle : one AngleValue,
  verticalAngle : one AngleValue,
  state : one SensorState,
}

//Music player actions
//volume = volume value
//song = current song in queue
sig MusicPlayer_Action extends Action{
  volume : one VolumeValue,
  song : one SongValue,
}

//Heater actions
// heat = heat value
sig Heater_Action extends Action{
  heat : one HeatValue,
}

//Voice Assistant actions
//state = current voice assistant state
sig VoiceAssistant_Action extends Action{
  state : one VoiceAssistantState,
}

//Control center actions
sig ControlCenter_Action extends Action{
}

//////////////////////////////// ENUMS
//Enum for camera states
sig CameraState{}
sig CameraState_recording extends CameraState{}
sig CameraState_notRecording extends CameraState{}

//Enum for sensor states
sig SensorState{}
sig SensorState_monitoring extends SensorState{}
sig SensorState_notMonitoring extends SensorState{}

//Enum for voice assistant states
sig VoiceAssistantState{}
sig VAState_listening extends VoiceAssistantState{}
sig VAState_notListnening extends VoiceAssistantState{}


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

//Control center
//contains all accessories in the house, represents single control unit
sig ControlCenter{
  name : one Name,
  accessories : set Accessory,
}

//Room signature
//name = name identifier
//house = house this accessory is placed in
//accessories = set of accessories in this room
sig Room{
  name : one Name,
  accessories : set Accessory,
}

//House signature
//name = name identifier
//rooms = set of rooms this house consists of
sig House{
  name : one Name,
  rooms : set Room,
  controlCenter : one ControlCenter,
}

//////////////////////////////// ROOMS
sig LivinRoom extends Room{}
sig Kitchen extends Room{}
sig HostRoom extends Room{}
sig ToiletRoom extends Room{}
sig BathRoom extends Room{}
sig Hallway extends Room{}

//////////////////////////////// SETS
fact {Room = LivinRoom + Kitchen + HostRoom + ToiletRoom + BathRoom + Hallway}
fact {Action = LightBulb_Action + Camera_Action + Sensor_Action + MusicPlayer_Action + 
      Heater_Action + VoiceAssistant_Action}
fact {Type = LightBulbType + CameraType + SensorType + MusicPlayerType + HeaterType + 
      VoiceAssistantType}
fact {Value = LightValue + AngleValue + VolumeValue + SongValue + HeatValue}
fact {CameraState = CameraState_recording + CameraState_notRecording}
fact {SensorState = SensorState_monitoring + SensorState_notMonitoring}
fact {VoiceAssistantState = VAState_listening + VAState_notListnening}

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
fact {all h: House | all r1: Room| all a: Accessory | all cc: ControlCenter |
      h.name != r1.name and h.name != a.name and r1.name != a.name and
      h.name != cc.name and a.name != cc.name and r1.name != cc.name}

//QUANTITY
//Every room has at least one accessory in it
fact {all a: Accessory | some r1: Room | a in r1.accessories}
//All accessories are stored in control center of given house
fact {all h: House, r: h.rooms, a: r.accessories, cc: h.controlCenter | a in cc.accessories}
//Every control center belongs to some house
fact {all cc: ControlCenter | some h: House | cc = h.controlCenter}
//All actions are performed in some accessory
fact {all act: Action | some acc: Accessory | acc.action = act}
//All types are types of some accessory
fact {all t: Type | some acc: Accessory | acc.type = t}
//Every camera state is attached to camera action
fact {all cs: CameraState | some cas: Camera_Action | cas.state = cs}
//Every sensor state is attached to sensor action
fact {all ss: SensorState | some sa: Sensor_Action | sa.state = ss}

// //every room has music player in it
fact {all r1: Room | some a: Accessory | a.type = MusicPlayerType && a in r1.accessories}
//every rook has a heater in it
fact {all r1: Room | some a: Accessory | a.type = HeaterType && a in r1.accessories}
//every room has a voice assistant in it
fact {all r1: Room | some a: Accessory | a.type = VoiceAssistantType && a in r1.accessories}

//REALTION BETWEEN TYPE AND ACTION
fact {all a: Accessory | a.type in CameraType <=> a.action in Camera_Action}
fact {all a: Accessory | a.type in SensorType <=> a.action in Sensor_Action}
fact {all a: Accessory | a.type in LightBulbType <=> a.action in LightBulb_Action}
fact {all a: Accessory | a.type in MusicPlayerType <=> a.action in MusicPlayer_Action}
fact {all a: Accessory | a.type in HeaterType <=> a.action in Heater_Action}
fact {all a: Accessory | a.type in VoiceAssistantType <=> a.action in VoiceAssistant_Action}

//////////////////////////////// ROOM SPECIFIC FACTS

//TOILET ROOM
//we dont have cameras in toilet room
fact {all r1: ToiletRoom | all a : Accessory | 
     a in r1.accessories => a.type != CameraType}

//BATH ROOM
//we dont have cameras in bathroom
fact {all r1: BathRoom | all a : Accessory |
      a in r1.accessories => a.type != CameraType}

// //HALLWAY
// //We have move sensors only in hallway
fact {all a: Accessory | a.type = SensorType => some hl: Hallway | a in hl.accessories}



pred myinst{}


run myinst for 1 but exactly 1 House, 
                     exactly 1 Room, 
                     exactly 4 Accessory, 
                     exactly 1 HeaterType,
                     exactly 1 MusicPlayerType,
                     exactly 1 VoiceAssistantType,
                     exactly 4 Action,
                     15 Value,
                     exactly 7 Name


//fact { #Director > 2 }