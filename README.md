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

