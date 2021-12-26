# SmartHome

Riesenie pozostava z 1 suboru [SmartHome.als](SmartHome.als).

## Dokumentacia

SmartHome sa sklada z niekolkych zakladnych signatur:
- Home
- Room
- Accessory
- ControlCenter
- Name

Zakladna signatura je **Home**, reprezentujuca 1 dom. Kazdy dom sa sklada z aspon 1 izby - **Room** - a v kazdej izbe mame aspon 1 smart prislusenstvo - **Accessory**. V dome mame zaroven 1 **ControlCenter**, ktory reprezentuje kontrolne centrum vsetkych prislusenstiev v danom dome. **Name** je prazdna signatura reprezentujuca unikatny identifikator pre vyssie spominane signatury.

### Home
Signatura **Home** obsahuje jeden identifikator **name**, neprazdnu mnozinu izieb **rooms** a jedno kontrolne centrum **controlCenter**.

### Room
Signatura **Room** obsahuje jeden identifikator **name** a neprazdnu mnozinu smart prislusenstiev **accessories**. Nasledne mame prazdne signatury, ktore reprezentuju konkretne izby v dome a vyuzivame ich ako enum:
- LivingRoom
- Kitchen
- HostRoom
- ToiletRoom
- BathRoom
- Hallway

### Accessory
Signatura **Accessory** obsahuje jeden identifikator **name**, jeden typ **type** a jednu akciu **action**. 

Typ reprezentujeme zakladnou signaturou **Type**, od ktorej potom odvadzame konkretne signatury typu (podobne ako pri izbach ich vyuzivame ako enum):
- LightBulbType
- CameraType
- SensorType
- MusicPlayerType
- HeaterType
- VoiceAssistantType

Akciu reprezentujeme zakladnou signaturou **Action**, od ktorej potom odvadzame konkretne signatury akcie. Vyuzivame ich podobne ako enum pri typoch. Kazda akcia ale navyse obsahuje dalsie polozky, ktore su specificke pre danu akciu. Obecne ale pozostavaju z nejakej **Value** alebo **State**. Momentalne mame akciu pre kazdy typ **Accessory**:
- LightBulb_Action
- Camera_Action
- Sensor_Action
- MusicPlayer_Action
- Heater_Action
- VoiceAssistant_Action

Na akcie navazuju 2 vyssie spominane signatury - **Value** a **State**. Pri **Value** mame jednu zakladnu signaturu a pre kazdu **Accessory**, ktora ju vyuziva, mame odvodenu konkretnu signaturu:
- LightValue
- AngleValue
- VolumeValue
- SongValue
- HeatValue

**State** funguje podobne ako **Value**, ale je viac zamerany na konkretne **Accessory** - nemame 1 obecnu signaturu **State** pre vsetky. Namiesto toho mame pre konkretnu **Accessory** jeden obecny **State** od ktoreho su potom odvodene konkretne stavy. Tabulka nizsie poskytuje vycet tychto stavov:
| General State       |      Concrete States                              |
|---------------------|:-------------------------------------------------:|
| CameraState         | CameraState_recording, CameraState_notRecording   |
| SensorState         | SensorState_monitoring, SensorState_notMonitoring |
| VoiceAssistantState | VAState_listening, VAState_notListnening          |


### ControlCenter
Signatura **ControlCenter** obsahuje jeden identifikator **name** a mnozinu vsetkych smart prislusenstiev v dome **accessories**. Kazdemu domu nalezi prave jeden **ControlCenter**.

### Fakty, Predikaty, Asserty, Checky
Druha cast riesenia sa sklada z faktov definujucich niekolko pravidiel pre dane signatury - vsetky su jednotlivo okomentovane pri ich definicii v [SmartHome.als](SmartHome.als). Nasledne mame nadefinovanych niekolko assertov a im odpovedajuce checky na kontrolu zakladnych invariantov. Definujeme zaroven aj jeden predikat **addAccessory** na pridanie smart prislusentva. Tento predikat vyuzivame k vytvoreniu jedneho komplexnejsieho modelu, ktory pozostava z domu v ktorom je prave jedna izba z kazdeho druhu a 10 smart prislusenstiev.
