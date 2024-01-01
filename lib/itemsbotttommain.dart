import 'dart:math';
import 'dart:async';
import 'package:rpgreen/Recyclespages.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:rpgreen/main.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:chart_sparkline/chart_sparkline.dart';
Color _getColorForQuality(String? quality) {
  switch (quality) {
    case 'Legendario':
      return Colors.orange; // Color para Legendario
    case 'Común':
      return Colors.white; // Color para Común
    case 'Raro':
      return Colors.blue;
    case 'Epico':
      return Colors.purple;
    case 'Inusual':
      return Colors.green;// Color para Inusual
  // Agrega más casos según sea necesario
    default:
      return Colors.black;
      // Color predeterminado
  }
}

FontWeight _getFontWeightForQuality(String? quality) {
  switch (quality) {
    case 'Legendario':
      return FontWeight.bold; // Negrita para Legendario
  // Agrega más casos según sea necesario
    default:
      return FontWeight.normal; // Peso de fuente predeterminado
  }
}

class InventoryController extends ChangeNotifier {
  List<BackpackObject> inventory = [];
  List<PetObject> petinv= [];

  void addToInventory(BackpackObject item) {
    inventory.add(item);
    notifyListeners(); // Notificar a los oyentes del cambio en el inventario
  }
  void sortInventoryByQuality() {
    petinv.sort((a, b) => a.quality.compareTo(b.quality));
    notifyListeners();
  }
  void addToPetinv(PetObject item){
    petinv.add(item);
notifyListeners();


}


}

class Backpack extends StatefulWidget {
  final InventoryController? inventoryController;

  Backpack({Key? key, this.inventoryController}) : super(key: key);

  @override
  BackpackState createState() => BackpackState();
}


class BackpackObject {
  final AssetImage objimage;
  final String titulo;


  BackpackObject(this.objimage,this.titulo, );

}
class PetObject{
  final AssetImage petimage;
  final String NamePet;
  final String quality;
  final double healthmultiplier;
  final double manamultiplier;
  final expmultiplier;

  PetObject(this.petimage,this.NamePet,this.expmultiplier,this.healthmultiplier,this.manamultiplier,this.quality);



}






class BackpackState extends State<Backpack> {


  void _onTabTappede(int index) {
     int _currentindex =1;

    final snackbars = SnackBar(content: Text('Solo puedes añadir una meta desde la pagina inicial'),
      duration: Duration(seconds: 3), action: SnackBarAction(label: '¡Entendido!', onPressed: (){

        null;
      }),);
    setState(() {
      _currentindex = index;
    });


    switch (index) {
      case 0:
        Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage()));
        break;
      case 1:
        null;
        break;
      case 2:
        ScaffoldMessenger.of(context).showSnackBar(snackbars);
        break;
      case 3:
        Navigator.push(context, MaterialPageRoute(builder: (_) => stats()));
        break;
      case 4:
        Navigator.push(context, MaterialPageRoute(builder: (_) => GachaPage()));;
    }
  }

  @override
  Widget build(BuildContext context) {
     int  _currentindex = 1;
    var inventoryController = Provider.of<InventoryController>(context,listen: false);
    inventoryController.sortInventoryByQuality();
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blueGrey.shade900,
        elevation: 0,

      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 16,width: MediaQuery.sizeOf(context).width*0.1,),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text(
                        'Inventario',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'San Francisco',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Usar un ListView.builder para mostrar los elementos del inventario
            SingleChildScrollView(
              child: ListView.builder(
                padding: EdgeInsets.all(20),
                shrinkWrap: true,
                itemCount: inventoryController?.inventory.length ?? 0,
                itemBuilder: (context, index) {
                  // Crear un widget personalizado para mostrar cada elemento del inventario
                  return InventoryItemWidget(
                    inventoryItem: inventoryController?.inventory[index],
                  );

                },
              ),
            ),
            SizedBox(height: MediaQuery.sizeOf(context).height*0.5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: MediaQuery.sizeOf(context).width*0.1,),
                        // Espaciado para empujar "Animales" hacia la derecha
                      Text(
                        'Animales',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'San Francisco',
                        ),
                      ),
                      SizedBox(width: MediaQuery.sizeOf(context).width* 0.3,),

                      Text(
                          'Orden A-Z',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'San Francisco',
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),

                    ],
                  ),
                )
              ],
            ),



            SingleChildScrollView(

              child: ListView.builder(
                shrinkWrap: true,
                itemCount: inventoryController?.petinv.length ?? 0,
                itemBuilder: (context, index) {

                  return InventoryPetWidget(
                    PetItem: inventoryController?.petinv[index],

                  );



                },

              ),
            ),
          ],
        ),

      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blueGrey.shade900,
        currentIndex: _currentindex,
        onTap: _onTabTappede,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Colors.black54,
            icon: Icon(Icons.home, color: Colors.white),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.black54,
            icon: Icon(Icons.backpack, color: Colors.white),
            label: 'Favoritos',
          ),
          ProfileNavigationBarItem(),
          BottomNavigationBarItem(
            backgroundColor: Colors.black54,
            icon: Icon(Icons.auto_graph, color: Colors.white),
            label: 'Estadisticas',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.black54,
            label: 'ToDoList',
            icon: Image.asset('Assets/2639918_shop_icon.png', color: Colors.white,height: 25,width: 25,),
          )
          // ... (Los otros elementos del BottomNavigationBar)
        ],
        selectedLabelStyle: TextStyle(
          color: Colors.blue,
        ),
        selectedItemColor: Colors.blue,
        showUnselectedLabels: false,
      ),

    );
  }
}

class InventoryItemWidget extends StatelessWidget {
  final BackpackObject? inventoryItem;

  InventoryItemWidget({required this.inventoryItem});
  @override
  Widget build(BuildContext context) {
    // Personalizar este widget según tus necesidades y el contenido de BackpackObject
    return ListTile(
      minVerticalPadding: 10,
     

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      tileColor: Colors.orange.shade300,
     leading: Image(image: inventoryItem?.objimage ?? AssetImage('') ,),
      title: Text(inventoryItem?.titulo ?? '',style: TextStyle(color: Colors.white),),



    );

  }
}
class InventoryPetWidget extends StatelessWidget {
  final PetObject? PetItem;

  InventoryPetWidget({required this.PetItem});

  @override
  Widget build(BuildContext context) {
    // Personalizar este widget según tus necesidades y el contenido de BackpackObject
    return ListTile(
      leading: Image(image: PetItem?.petimage ?? AssetImage('')),
      title: Text(PetItem?.quality ?? '',style: TextStyle(fontWeight: FontWeight.bold,color: _getColorForQuality(PetItem?.quality,)
      ),),
      subtitle: Text(PetItem?.NamePet  ?? ''),

    );
  }
}



class ObjectGacha {

  final AssetImage objimage;
  final String description;
  final int lifegacha;
  final int moneygacha;
  final int manarecover;
  final int objquantity;
  bool isadquired;


  ObjectGacha(this.objimage,this.description, this.lifegacha, this.moneygacha, this.manarecover, this.objquantity, {this.isadquired = false});
  int moneyWithLevelMultiplier(int level) {
    return moneygacha * level;
  }
  int manaWithLevelMultiplier(int level) {
    return manarecover * level;
  }
  int liveWithLevelMultiplier(int level) {
    return lifegacha * level;
  }
}

class PetGacha {

  final AssetImage objimage;
  final String rarity;
  final String name;
  final double multiplierhealth;
  final double multiplierexp;
  final double multipliermoney;
  final double objquantity;
  bool isadquired;


  PetGacha(this.name,this.objimage,this.rarity, this.multiplierexp, this.multiplierhealth, this.multipliermoney, this.objquantity, {this.isadquired = false});

}

class GachaPage extends StatefulWidget {



  final List<ObjectGacha> gachaList= [
    ObjectGacha(AssetImage('Assets/pequenamana.png'),'Pocion de mana pequeña',0, 0, 15, 1,),
    ObjectGacha(AssetImage('Assets/medianamana.png'),'Pocion de mana mediana', 0, 0, 25, 1),
    ObjectGacha(AssetImage('Assets/estrellamana.png'),'Estrella de Mana', 0, 0, 50, 1),
    ObjectGacha(AssetImage('Assets/vidapequena.png'),'Pocion de vida pequeña', 30, 0, 0, 1),
    ObjectGacha(AssetImage('Assets/vidamediana.png'),'Pocion de vida mediana', 50, 0, 0, 1),
    ObjectGacha(AssetImage('Assets/vidagrande.png'),'Pocion de vida  grande', 100, 0, 0, 1), //TODO: CAMBIAR VALORES DE EXPERIENCIA POR PORCENTAJES DE  LA VARIABLE NIVEL
    ObjectGacha(AssetImage('Assets/monedaoro.png'),'Monedas sueltas', 0, 50, 0, 1),
    ObjectGacha(AssetImage('Assets/bolsadinero.png'),'Bolsa de dinero', 0, 100, 0, 1),
    ObjectGacha(AssetImage('Assets/cofredinero.png'),'Botín de dinero', 0, 200, 0, 1),//description,experiencegacha, moneygacha,manarecover, objquantity, {   bool isadquired = false, })



  ];
  final List<PetGacha> petgacha=[
    PetGacha('gato',AssetImage('Animales/gato.gif'), 'Común', 1.05, 1.1, 1.2, 1),
    PetGacha('perro',AssetImage('Animales/Perro.gif'), 'Común', 1.1, 1.15, 1.23, 1),
    PetGacha('rana',AssetImage('Animales/Rana.gif'), 'Común', 1.07, 1.12, 1.21, 1),
    PetGacha('pollo',AssetImage('Animales/pollo.gif'), 'Común', 1.05, 1.18, 1.25, 1),
    PetGacha('pato',AssetImage('Animales/pato.gif'), 'Inusual', 1.1, 1.14, 1.28, 1),
    PetGacha('puercoespin',AssetImage('Animales/puercoespin.gif'), 'Inusual', 1.22, 1.24, 1.29, 1),
    PetGacha('tortuga',AssetImage('Animales/tortuga.gif'), 'Inusual', 1.25, 1.24, 1.29, 1),
    PetGacha('mofeta',AssetImage('Animales/Mofeta.gif'), 'Inusual', 1.25, 1.24, 1.29, 1),
    PetGacha('cerdo',AssetImage('Animales/cerdo.gif'), 'Raro', 1.3, 1.3, 1.3, 1),
    PetGacha('Oveja',AssetImage('Animales/Oveja.gif'), 'Raro', 1.33, 1.34, 1.35, 1),
    PetGacha('Vaca',AssetImage('Animales/Vaca.gif'), 'Raro', 1.36, 1.36, 1.37, 1),
    PetGacha('mono',AssetImage('Animales/mono.gif'), 'Raro', 1.33, 1.34, 1.35, 1),
    PetGacha('Cabra',AssetImage('Animales/Cabra.gif'), 'Epico', 1.37, 1.38, 1.34, 1),
    PetGacha('Jabali',AssetImage('Animales/jabali.gif'), 'Epico', 1.4, 1.42, 1.45, 1),
    PetGacha('Cangrejo',AssetImage('Animales/Cangrejo.gif'), 'Epico', 1.43, 1.46, 1.45, 1),
    PetGacha('Lobo',AssetImage('Animales/Lobo.gif'), 'Epico', 1.45, 1.48, 1.49, 1),
    PetGacha('Nievacolas',AssetImage('Animales/Zorronieve.gif'), 'Legendario', 1.5, 1.5, 1.5, 1),
    PetGacha('Gorilla',AssetImage('Animales/Gorilla.gif'), 'Legendario', 2, 2, 2.1, 1),
    PetGacha('Reno',AssetImage('Animales/Reno.gif'), 'Legendario', 2.4, 2.5, 2.5, 1),
  ];





  @override
  GachaPageState createState() => GachaPageState(gachaList: gachaList);
}
class GachaPageState extends State<GachaPage> {

  final List<ObjectGacha> gachaList;
  ObjectGacha? selectedGacha;
  int gachaponnumber= 0;
   int _currentindex = 4;
  final iconlife = CupertinoIcons.heart_fill;
  final iconmana = CupertinoIcons.star_fill;
  final icondinero = CupertinoIcons.money_dollar;

  GachaPageState({required this.gachaList});

  void spinGachapon(BuildContext context) {
    final inventoryController = Provider.of<InventoryController>(context, listen: false);
    final provplayer = Provider.of<PlayerStatsProvider>(context, listen: false);
    final random = Random();
    final index = random.nextInt(widget.gachaList.length);
    gachaponnumber++;
    print('$gachaponnumber');
    print('La longitud es: ${inventoryController?.inventory.length}');

    final ObjectGacha selectedGacha = widget.gachaList[index];
      setState(() {
        inventoryController?.addToInventory(
            BackpackObject(selectedGacha.objimage, selectedGacha.description));
      });



    List<Widget> animations = [

      Bounce(
        duration: Duration(seconds: 1),
        child: Container(
          width: 100,
          height: 100,
          color: Colors.green,
          child: Center(
            child: Column(

              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  selectedGacha.objimage.keyName,
                  scale: 0.5,
                ),
                Text('Has obtenido: ${selectedGacha.description}'),
                SizedBox(height: 4,),
                Row(
                  children: [
                    Icon(CupertinoIcons.heart_fill, color: Colors.red.shade400),
                    Text('${selectedGacha.liveWithLevelMultiplier(provplayer.level)}'),
                    SizedBox(height: 2,),
                    Icon(CupertinoIcons.money_dollar, color: Colors.green.shade900),
                    Text('${selectedGacha.moneyWithLevelMultiplier(provplayer.level)}'),
                    SizedBox(height: 2,),
                    Icon(CupertinoIcons.star_fill, color: Colors.blue),
                    Text('${selectedGacha.manaWithLevelMultiplier(provplayer.level)}'),
                  ],
                ),
                SizedBox(height: 3,),
                ElevatedButton(
                  onPressed: setgachanull,
                  child: Icon(Icons.check, color: Colors.white, size: 40),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green.shade900),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    enableFeedback: true,
                    shape: MaterialStateProperty.all(CircleBorder()),
                    side: MaterialStateProperty.all(BorderSide(
                      color: Colors.black,
                      style: BorderStyle.solid,
                      width: 2.0,
                    )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      ZoomIn(
        duration: Duration(seconds: 1),
        child: Container(
          width: 100,
          height: 100,
          color: Colors.green,
          child: Center(
            child: Image.asset('Assets/regalopixelart.png'),
          ),
        ),
      ),
      Swing(
        duration: Duration(seconds: 1),
        child: Container(
          width: 100,
          height: 100,
          color: Colors.transparent,
          child: Center(
              child: Image.asset('Assets/regalopixelart.png')),
        ),
      ),

    ];

    _showAnimationsSequentially(animations);
  }
  void spinGachanimales(BuildContext context) {
    final inventoryController = Provider.of<InventoryController>(context,listen:false);
    final provplayer = Provider.of<PlayerStatsProvider>(context,listen: false);
    final random = Random();
    final index = random.nextInt(widget.petgacha.length);
    int calculateMoneyValue(String rarity) {
      switch (rarity) {
        case 'Común':
          return 5;
        case 'Inusual':
          return 10;
        case 'Raro':
          return 15;
        case 'Epico':
          return 20;
        case 'Legendario':
          return 25;
        default:
          return 0;
      }
    }


    final PetGacha selectedGacha = widget.petgacha[index];
    bool objectAlreadyExists = inventoryController?.petinv.any((item) =>
    item is PetObject &&
        item.petimage == selectedGacha.objimage) ?? false;


    if (objectAlreadyExists) {
      // Convertir el objeto en dinero (ajusta esta lógica según tus necesidades)
      int moneyValue = calculateMoneyValue(selectedGacha.rarity);
    provplayer.addMoneys(moneyValue);
    print('El objeto ya existe, se ha convertido en dinero: $moneyValue');
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Ya obtenido, dinero obtenido: $moneyValue')));
    } else {
    setState(() {
    inventoryController?.addToPetinv(PetObject(selectedGacha.objimage, selectedGacha.name,selectedGacha.multipliermoney,
    selectedGacha.multiplierhealth,selectedGacha.multiplierexp,selectedGacha.rarity));

    });
    }


    List<Widget> animations = [
      Bounce(
        duration: Duration(seconds: 1),
        child: Container(
          width: MediaQuery.sizeOf(context).width * 05,
          height: MediaQuery.sizeOf(context).height * 05,

          color: Colors.green,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  selectedGacha.objimage.keyName,
                  scale: 0.5,
                ),
                Text('Has obtenido: ${selectedGacha.name}'),
                SizedBox(height: 4,),

                SizedBox(height: 3,),
                ElevatedButton(
                  onPressed: setgachanull,
                  child: Icon(Icons.check, color: Colors.white, size: 40),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green.shade900),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    enableFeedback: true,
                    shape: MaterialStateProperty.all(CircleBorder()),
                    side: MaterialStateProperty.all(BorderSide(
                      color: Colors.black,
                      style: BorderStyle.solid,
                      width: 2.0,
                    )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      ZoomIn(
        duration: Duration(seconds: 1),
        child: Container(
          width: 100,
          height: 100,
          color: Colors.green,
          child: Center(
            child: Image.asset('Assets/regalopixelart.png'),
          ),
        ),
      ),
      Swing(
        duration: Duration(seconds: 1),
        child: Container(
          width: 100,
          height: 100,
          color: Colors.transparent,
          child: Center(
              child: Image.asset('Assets/regalopixelart.png')),
        ),
      ),

    ];

    _showAnimationsSequentially(animations);
  }

  void _showAnimationsSequentially(List<Widget> animations) {
    int index = 0;

    void showNextAnimation() {
      if (index < animations.length) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              child: Container(
                width: 200,
                height: 402,
                padding: EdgeInsets.all(16),
                child: animations[index],

              ),
            );

          },
        );

        // Incrementa el índice para la próxima animación
        index++;

        // Verifica si el índice está dentro de los límites antes de configurar el temporizador
        if (index < animations.length) {
          // Configura el temporizador para mostrar la siguiente animación después de un tiempo
          Timer(Duration(seconds: 2), showNextAnimation);
        }
        if(index >= animations.length){
          setState(() {
            index =0;
          });
        }
      }
    }

    // Comienza mostrando la primera animación
    showNextAnimation();
  }


  void setgachanull() {
    var statsprov = Provider.of<PageStatsProvider>(context,listen: false);
    statsprov.addObjectGachapon(gachaponnumber);

    setState(() {
      selectedGacha = null;



    });
    Navigator.of(context).pop();
    Navigator.of(context).pop();
    Navigator.of(context).pop();

  }
void petviewchanger(){

    petview != petview;
}

  void _onTabTappeds(int index) {
    _currentindex =4;

    final snackbars = SnackBar(content: Text('Solo puedes añadir una meta desde la pagina inicial'),
    duration: Duration(seconds: 3), action: SnackBarAction(label: '¡Entendido!', onPressed: (){

      null;
      }),);
    setState(() {
      _currentindex = index;
    });


    switch (index) {
      case 0:
        Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage()));
        break;
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (_) => Backpack()));
        break;
      case 2:
       ScaffoldMessenger.of(context).showSnackBar(snackbars);
        break;
      case 3:
        Navigator.push(context, MaterialPageRoute(builder: (_) => stats()));
        break;
      case 4:
        null;
    }
  }


  @override
  bool petview= true;



  Widget build(BuildContext context) {
    var provplayer = Provider.of<PlayerStatsProvider>(context, listen: false);
    var statsplayer = Provider.of<PageStatsProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Gachapon'),
      ),
      body: Center(
        child: SingleChildScrollView(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          Transform.scale(scale:2,
              child:Switch(
                activeThumbImage: AssetImage('Animales/9055355_bxs_dog_icon.png'),
                activeTrackColor: Colors.lightBlueAccent,
                activeColor: Colors.blue.shade900,
                inactiveThumbImage: AssetImage('Animales/2730279_bottle_harry_magic_potion_potter_icon (2).png'),
                inactiveTrackColor: Colors.grey,
                value: petview,
                onChanged: (value) {
                  print(petview);
                  setState(() {
                    petview = value;
                  });
                },
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                // Ajusta la densidad visual
              ),
              ),



            Visibility(visible:  petview,child:
                Column(children:[
                  SizedBox(height: 16),
                  Text ('Animales',style: TextStyle(color: Colors.blue.shade900,fontWeight: FontWeight.bold,
                      fontSize: 40),),
                  SizedBox(height: MediaQuery.sizeOf(context).height*0.1,),
            ElevatedButton(
              onPressed: (){
                spinGachanimales(context);
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                backgroundColor: Color(0xFF4CAF50),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: Text('Girar Gachapon'),
            ),
          ],
                )
            ),
            Visibility(
              visible: !petview,
              child: Column(
                children: [
                  SizedBox(height: 16),
                  Text ('Objetos',style: TextStyle(color: Colors.blue.shade900,fontWeight: FontWeight.bold,
                  fontSize: 40),),
                  SizedBox(height: MediaQuery.sizeOf(context).height*0.1,),

                  ElevatedButton(
                    onPressed: () {
                      spinGachapon(context);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      backgroundColor: Color(0xFF4CAF50),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Text('Girar Gachapon'),
                  ),
                ],
              ),
            )
          ],
        ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blueGrey.shade900,
        currentIndex: _currentindex,
        onTap: _onTabTappeds,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Colors.black54,
            icon: Icon(Icons.home, color: Colors.white),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.black54,
            icon: Icon(Icons.backpack, color: Colors.white),
            label: 'Favoritos',
          ),
          ProfileNavigationBarItem(),
          BottomNavigationBarItem(
            backgroundColor: Colors.black54,
            icon: Icon(Icons.auto_graph, color: Colors.white),
            label: 'Estadisticas',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.black54,
            label: 'ToDoList',
            icon: Image.asset('Assets/2639918_shop_icon.png', color: Colors.white,height: 25,width: 25,),
          )
          // ... (Los otros elementos del BottomNavigationBar)
        ],
        selectedLabelStyle: TextStyle(
          color: Colors.blue,
        ),
        selectedItemColor: Colors.blue,
        showUnselectedLabels: false,
      ),
    );
  }
}

class stats extends StatefulWidget{
  @override
  statsState createState() => statsState();


}
class statsState extends State<stats> {
  void _onTabTappede(int index) {
    int _currentindex =3;

    final snackbars = SnackBar(content: Text('Solo puedes añadir una meta desde la pagina inicial'),
      duration: Duration(seconds: 3), action: SnackBarAction(label: '¡Entendido!', onPressed: (){

        null;
      }),);
    setState(() {
      _currentindex = index;
    });


    switch (index) {
      case 0:
        Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage()));
        break;
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (_) => Backpack()));;
        break;
      case 2:
        ScaffoldMessenger.of(context).showSnackBar(snackbars);
        break;
      case 3:
        null;
        break;
      case 4:
       Navigator.push(context,MaterialPageRoute(builder: (_) => GachaPage()));
    }
  }
  @override
  Widget build(BuildContext context) {
    var statsprov = Provider.of<PageStatsProvider>(context, listen: true);
    var graficcontroller = Provider.of<GraficController>(context, listen: true);
    var _currentindex =3;

    // Extracting the x values from Graficitem objects
    List<double> xValues = graficcontroller.itemgraficoplastico.map((item) => item.x).toList();
    List<double> xValuespapel = graficcontroller.itemgraficopapel.map((item) => item.x).toList();
    List<double> xValuesglass = graficcontroller.itemgraficocristal.map((item) => item.x).toList();

    // Extracting the y values from Graficitem objects
    List<double> yValues = graficcontroller.itemgraficoplastico.map((item) => item.y).toList();


    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeInDown(
              duration: Duration(seconds: 4),
              child: Center(
                child: Text('Has reciclado un total de ${statsprov.plasticoreciclado} objetos de plastico'),
              ),
            ),
            SizedBox(height: 3,),
            Center(
              child: FadeInDown(
                duration: Duration(seconds: 4),
                child: Center(
                  child: Text('Has reciclado un total de ${statsprov.papelreciclado} objetos de carton'),
                ),
              ),
            ),
            SizedBox(height: 3,),
            Center(
              child: FadeInDown(
                duration: Duration(seconds: 4),
                child: Center(
                  child: Text('Has reciclado un total de ${statsprov.cristalreciclado} objetos de cristal',),
                ),
              ),
            ),
            SizedBox(height: 3,),
            Center(
              child: FadeInDown(
                duration: Duration(seconds: 4),
                child: Center(
                  child: Text('Has girado  un total de ${statsprov.objetosgachapon} veces en el gachapon '),
                ),
              ),
            ),
            Center(
              child: FadeInDown(
                duration: Duration(seconds: 4),
                child: Center(
                  child: Text('Has reciclado un total de ${statsprov.completedmetas} objetos de carton'),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    'Gráficas',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontFamily: 'San Francisco',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4,),
                  Text(
                    'Plástico',
                    style: TextStyle(
                      color: Colors.green.shade900,
                      fontSize: 30,
                      fontFamily: 'San Francisco',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4,),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Sparkline(
                      pointsMode: PointsMode.all,
                      pointColor: Colors.amber,
                      pointSize: 8,

                        data: xValues,
                      lineColor: Colors.green.shade900,
                      lineWidth: 3,

                      ),
                    ),
                  SizedBox(height: 4,),
              Text(
                'Cartón',
                style: TextStyle(
                  color: Colors.green.shade900,
                  fontSize: 30,
                  fontFamily: 'San Francisco',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4,),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Sparkline(
                  pointsMode: PointsMode.all,
                  pointColor: Colors.amber,
                  pointSize: 8,

                  data: xValuespapel,
                  lineColor: Colors.green.shade900,
                  lineWidth: 3,

                ),
              ),
                  SizedBox(height: 8,),
                  Text(
                    'Cristal',
                    style: TextStyle(
                      color: Colors.green.shade900,
                      fontSize: 30,
                      fontFamily: 'San Francisco',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4,),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Sparkline(
                      pointsMode: PointsMode.all,
                      pointColor: Colors.amber,
                      pointSize: 8,

                      data: xValuesglass,
                      lineColor: Colors.green.shade900,
                      lineWidth: 3,

                    ),
                  ),


                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blueGrey.shade900,
        currentIndex: _currentindex,
        onTap: _onTabTappede,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Colors.black54,
            icon: Icon(Icons.home, color: Colors.white),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.black54,
            icon: Icon(Icons.backpack, color: Colors.white),
            label: 'Favoritos',
          ),
          ProfileNavigationBarItem(),
          BottomNavigationBarItem(
            backgroundColor: Colors.black54,
            icon: Icon(Icons.auto_graph, color: Colors.white),
            label: 'Estadisticas',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.black54,
            label: 'ToDoList',
            icon: Image.asset('Assets/2639918_shop_icon.png', color: Colors.white,height: 25,width: 25,),
          )
          // ... (Los otros elementos del BottomNavigationBar)
        ],
        selectedLabelStyle: TextStyle(
          color: Colors.blue,
        ),
        selectedItemColor: Colors.blue,
        showUnselectedLabels: false,
      ),
    );
  }
}


class Graficitem{
  final double x;
  final double y;
  Graficitem(this.x,this.y);





}
class GraficController extends ChangeNotifier {
  List<Graficitem> itemgraficoplastico = [];
  List<Graficitem> itemgraficopapel = [];
  List<Graficitem> itemgraficocristal = [];


  void addTografic(Graficitem item) {
    itemgraficoplastico.add(item);
    notifyListeners(); // Notificar a los oyentes del cambio en el inventario
  }
  void addTograficcristal(Graficitem item) {
    itemgraficocristal.add(item);
    notifyListeners(); // Notificar a los oyentes del cambio en el inventario
  }
  void addTograficpapel(Graficitem item) {
    itemgraficopapel.add(item);
    notifyListeners(); // Notificar a los oyentes del cambio en el inventario
  }
}

