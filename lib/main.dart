import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rpgreen/Recyclespages.dart';
import 'package:rpgreen/itemsbotttommain.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'dart:math';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();


  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProfileData>(create: (_) => UserProfileData()),
        ChangeNotifierProvider<PlayerStatsProvider>(create: (_) => PlayerStatsProvider()),
        ChangeNotifierProvider<PageStatsProvider>(create: (_) => PageStatsProvider()),
        ChangeNotifierProvider<GraficController>(create: (_) => GraficController()),
        ChangeNotifierProvider<InventoryController>(create: (_) => InventoryController())

      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RPGREEN',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('Assets/logo nº3.png', width: 150, height: 150, scale: 4.0),
              SizedBox(height: 2),
              Align(
                alignment: Alignment.center, // Centra horizontalmente el texto
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Recicla, sube de nivel, cuida el planeta',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'San Francisco',
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        decoration: TextDecoration.none
                    ),
                  ),
                ),

              ),

              SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => ListadeIniciacion()));
                },
                child: Text('¡Comenzar!'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => ElegirClase()));
                },
                child: Text('¡Comenzar!'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => ReciclajeIniciacion()));
                },
                child: Text('¡Comenzar!'),
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('Assets/pexels-cottonbro-studio-3737675.jpg'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class ListadeIniciacion extends StatefulWidget {
  @override
  ListadeIniciacionState createState() => ListadeIniciacionState();
}

class ListadeIniciacionState extends State<ListadeIniciacion> {
  final PageController tutorialcontroller = PageController();
  final TextEditingController usernamecontroller = TextEditingController();


  @override
  Widget build(BuildContext context) {

    return PageView(
      scrollDirection: Axis.vertical,
      controller: tutorialcontroller,
      children: <Widget>[
        Center(
          child: Container(
            color: Colors.grey.shade900,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('Assets/armor-2672323_1280.png', width: 150, height: 150,),
                SizedBox(height: 8),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    '¡Comienza tu aventura ahora y haz del mundo un lugar mejor!',
                    style: TextStyle(
                      fontSize: 25,
                      fontFamily: 'San Francisco',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
                SizedBox(height: 300,),
                Icon(Icons.keyboard_double_arrow_down_sharp,color: Colors.white,),
              ],
            ),
          ),
        ),
        Center(
          child: Container(
            color: Colors.grey.shade900,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('Assets/temple-2672329_1280.png', color: Colors.white, width: 150, height: 150,),
                SizedBox(height: 8),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Consigue puntos y desbloquea nuevas mascotas, habilidades y personajes'
                        ' y cuida del planeta a la vez',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'San Francisco',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
                SizedBox(height: 300,),
                Icon(Icons.keyboard_double_arrow_down_sharp,color: Colors.white,),
              ],
            ),
          ),
        ),
        Center(
          child: Scaffold(
            backgroundColor: Colors.grey.shade900,
            body: Center(
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Escribe tu nombre de usuario',style: TextStyle(color: Colors.white,fontSize: 25,
                        fontFamily: 'San Francisco', fontWeight: FontWeight.bold,decoration: TextDecoration.none),),
                    SizedBox(height: 4,),
                    Image(image: AssetImage('Assets/usernameenter.gif',),
                      width: 300,height: 300,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                      child: TextFormField(
                        controller: usernamecontroller,
                        decoration: InputDecoration(
                          labelText: 'Username',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          border: OutlineInputBorder(),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => ElegirClase()));
                      },
                      child: Text('Continuar'),
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}


class UserProfileData with ChangeNotifier {
  String _username = '';
  AssetImage? _profimage;

  String get username => _username;
  AssetImage? get profimage => _profimage;

  UserProfileData() {
    _loadUsername();
    _loadImage();
  }

  Future<void> _loadUsername() async {
    final prefs = await SharedPreferences.getInstance();
    final savedUsername = prefs.getString('username') ?? '';
    _username = savedUsername;
    notifyListeners();
  }

  Future<void> setUsername(String newUsername) async {
    final prefs = await SharedPreferences.getInstance();
    _username = newUsername;
    await prefs.setString('username', newUsername);
    notifyListeners();
  }

  Future<void> _loadImage() async {
    final prefs = await SharedPreferences.getInstance();
    final savedImagePath = prefs.getString('profimage') ?? '';
    if (savedImagePath.isNotEmpty) {
      _profimage = AssetImage(savedImagePath);
      notifyListeners();
    }
  }

  Future<void> setImage(AssetImage? newImage) async {
    final prefs = await SharedPreferences.getInstance();
    if (newImage != null) {
      _profimage = newImage;
      await prefs.setString('profimage', newImage.assetName);
      notifyListeners();
    }
  }
}



class HomePage extends StatefulWidget {

  List<MetaListItem> metasList;



  HomePage({



    List<MetaListItem>? metasList,

  }) : metasList = metasList ?? [];

  @override
  HomePageState createState() => HomePageState(
  );
}


class DailyTask {
  final String description;
  final int experiencePoints;
  final int moneypoints;
  bool completed;

  DailyTask(this.description, this.experiencePoints,this.moneypoints, {this.completed = false});
}

class DailyTasksGenerator {
  final List<DailyTask> tasks = [
    DailyTask('Recicla un objeto tipo PET1', 20,5),
    DailyTask('Tira los restos del dia al reciclaje', 30, 10),
    DailyTask('Hacer un reciclaje', 10, 25),
    DailyTask('Reciclar los desechos en el contenedor organico', 15, 10),
    // Agrega más tareas con su descripción y puntos de experiencia
  ];

  List<DailyTask> generateRandomTasks(int numberOfTasks ) {
    if (numberOfTasks <= 0 || numberOfTasks > tasks.length) {
      throw ArgumentError('Número de tareas no válido');
    }

    final random = Random();
    final selectedTasks = <DailyTask>[];

    while (selectedTasks.length < numberOfTasks) {
      final randomTask = tasks[random.nextInt(tasks.length)];
      if (!selectedTasks.contains(randomTask)) {
        selectedTasks.add(randomTask);
      }
    }

    return selectedTasks;
  }
}

class HomePageState extends State<HomePage> {
  int _currentindex = 0;
  final DailyTasksGenerator dailyTasksGenerator = DailyTasksGenerator();
  List<DailyTask> randomTasks = [];
  late DateTime? lastday;


  late DateTime lastTaskGeneration; // Fecha de la última generación de tareas



  final PageController tutorialcontroller = PageController();
  bool metarec = false;
  final TextEditingController usernamecontroller = TextEditingController();

  void _onTabTapped(int index) {
    setState(() {
      _currentindex = index;
    });


    switch (index) {
      case 0:
        null;
        break;
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (_) => Backpack()));
        break;
      case 2:
        showDialog<void>(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext dialogContext) {
            return AlertDialog(
              backgroundColor: Colors.white,
              title: Text('Elige una opción', style: TextStyle(color: Colors.black)),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Column(
                    children: [
                      Text('Añadir meta', style: TextStyle(color: Colors.black)),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Meta()),
                          ).then((nuevaMeta) {
                            if (nuevaMeta != null) {
                              // La página Meta retornó una nueva meta, agrégala a la lista
                              setState(() {
                                widget.metasList.add(nuevaMeta);
                              });
                            }
                          });
                        },
                        child: Icon(CupertinoIcons.flag_fill, color: Colors.white),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text('Añadir Reciclaje', style: TextStyle(color: Colors.black)),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => ReciclajeIniciacion()));
                        },
                        child: Icon(Icons.arrow_back, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Cancelar'),
                  onPressed: () {
                    Navigator.of(dialogContext).pop(); // Dismiss alert dialog
                  },
                ),
              ],
            );
          },
        );
        break;
      case 3:
        Navigator.push(context, MaterialPageRoute(builder: (_) => stats()));
        break;
      case 4:
        Navigator.push(context, MaterialPageRoute(builder: (_) => GachaPage()));
        break;
    }
  }

  HomePageState() {
    lastday = DateTime.now();

    // Resto de la inicialización
  }


  @override
  void initState() {
    super.initState();
    _loadLastDay().then((_) {
      _generateDailyTasksIfNeeded();
    });
  }

  Future<void> _loadLastDay() async {
    final prefs = await SharedPreferences.getInstance();
    final savedDate = prefs.getInt('lastDay');

    // Si savedDate es nulo o si la diferencia entre la fecha guardada y la actual es mayor que un día, establece lastday como ahora
    if (savedDate == null || DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(savedDate)).inDays > 1) {
      lastday = DateTime.now();
      saveLastDay();
    } else {
      lastday = DateTime.fromMillisecondsSinceEpoch(savedDate);
    }
  }

  void saveLastDay() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('lastDay', lastday!.millisecondsSinceEpoch);
  }

  void _generateDailyTasksIfNeeded() {
    final now = DateTime.now();

    // Establece la hora de referencia a las 12 PM (mediodía)
    final referenceTime = DateTime(now.year, now.month, now.day, 0, 1, 0);

    print('lastday: $lastday');
    print('today: $now');

    if (lastday == null || lastday!.isBefore(referenceTime)) {
      lastday = now;
      saveLastDay();
      setState(() {
        randomTasks = dailyTasksGenerator.generateRandomTasks(3);
      });
      print('Se han generado tareas diarias');
    } else {
      // No es necesario regenerar tareas si ya se generaron hoy
      print('No se generaron tareas diarias hoy');
    }
  }




  @override
  Widget build(BuildContext context) {
    final playerStats = Provider.of<PlayerStatsProvider>(context);
    final statprov = Provider.of<PageStatsProvider>(context,listen:false);
    final userimg = Provider.of<UserProfileData>(context,listen:false);

// Puedes acceder a los valores individualmente:
    int currentLevel = playerStats.level;
    int currentManas = playerStats.manas;
    int currentMoneys = playerStats.moneys;
    int currentExperience = playerStats.experience;

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Column(
        children: [
          Container(
            width: double.maxFinite,
            height: 170,
            color: Colors.black,
            child: Stack(
              children: [
                // Foto de perfil en la esquina superior izquierda
                Positioned(
                  left: 8,
                  top: 50,
                  child: Column(
                    children: [
                      CircleAvatar(
                        //TODO: Añadir el provider de la imagen
                        radius: 40,
                        backgroundImage: userimg._profimage, // Reemplaza 'tu_ruta_de_imagen' por la URL o ruta de tu imagen de perfil
                      ),
                      SizedBox(height: 8), // Separación entre el avatar y el texto
                      Text(
                        'Nivel:${currentLevel}', // Aquí debes usar el nombre real del usuario o recuperarlo de donde lo tengas almacenado
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                // Barra de mana en la esquina superior derecha
                Positioned(
                  top: 50,
                  right: 10,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Mana: ${currentManas}',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            width: 150, // Establece el ancho deseado
                            child: LinearProgressIndicator(
                              value: playerStats.manas / 100,
                              backgroundColor: Colors.grey,
                            ),
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          Text(
                            'XP: ${currentExperience} / ${playerStats.maxexperience}',
                            style: TextStyle(

                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            width: 150, // Establece el ancho deseado
                            child: LinearProgressIndicator(
                              value: currentExperience / playerStats.calculateMaxExperience(),
                              backgroundColor: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      // Contador de dinero
                      Row(
                        children: [
                          Icon(Icons.attach_money, color: Colors.red),
                          Text(
                            'Dinero: ${currentMoneys}',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // Alineación del texto a la izquierda
                  children: [
                    Text(
                      '   Misiones Diarias',
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
          Expanded(
            child: Container(
              color: Colors.blueGrey.shade900,
              child: ListView.builder(
                itemCount: randomTasks.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      randomTasks[index].description,
                      style: TextStyle(
                        decoration: randomTasks[index].completed ? TextDecoration.lineThrough : null,
                        color: randomTasks[index].completed ? Colors.green : Colors.white,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min, // Ajusta según tus necesidades
                      children: [
                        Icon(Icons.monetization_on, color: Colors.green,size: 20,),
                        SizedBox(width: 1,),
                        Text('+${randomTasks[index].moneypoints} \$',style: TextStyle(
                          decoration: randomTasks[index].completed ? TextDecoration.lineThrough : null,
                          color: randomTasks[index].completed ? Colors.green : Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        )),
                        SizedBox(width: 10), // Espacio entre los elementos
                        Text('+ ${randomTasks[index].experiencePoints} XP', style: TextStyle(
                          decoration: randomTasks[index].completed ? TextDecoration.lineThrough : null,
                          color: randomTasks[index].completed ? Colors.green : Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        )),
                      ],
                    ),
                    onTap: () {
                      if (!randomTasks[index].completed) { // Verifica si la tarea no está ya completada
                        setState(() {
                          randomTasks[index].completed = true;
                        });
                        if (randomTasks[index].completed) {
                          playerStats.addExperience(randomTasks[index].experiencePoints);
                          playerStats.addMoneys(randomTasks[index].moneypoints);


                        }
                      }
                    },
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 2,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // Alineación del texto a la izquierda
                  children: [
                    Text(
                      '  Metas',
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
          Expanded(
            child: Container(
              child:  ListView.builder(
                itemCount: widget.metasList.length,
                itemBuilder: (context, index) {
                  MetaListItem meta = widget.metasList[index];
                  return ListTile(

                    shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      gapPadding: 4.0,


                    ),
                    titleTextStyle: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 25),
                    subtitleTextStyle: TextStyle(fontWeight: FontWeight.normal,color: Colors.white,fontSize: 15),
                    tileColor: Colors.grey.shade800,
                    title:Column(
                      verticalDirection: VerticalDirection.down,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [Text(meta.titulometa),],
                    ) ,
                    subtitle:
                    Column(children:[
                      Text(meta.descmeta),
                      Divider(),
                      Text('Plástico: ${meta.plasticlistcount}'),
                      Divider(),
                      Text('Cristal: ${meta.glasslistcount}'),
                      Divider(),
                      Text('Carton: ${meta.cartonlistcount}'),
                      SizedBox(height: 8,),
                    ]),
                    onLongPress: () {
                      widget.metasList.remove(meta);
                      meta.titulometa = 'Completado';
                      meta.descmeta = 'Refresca la pagina';
                      statprov.addmetatostat(1);
                    },


                    // Muestra otros detalles de la meta como cartón, cristal y plástico
                  );
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black54,
        currentIndex: _currentindex,
        onTap: _onTabTapped,
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
class ElegirClase extends StatefulWidget {
  @override
  ElegirClaseState createState() => ElegirClaseState();
}

class ElegirClaseState extends State<ElegirClase> {
  final TextEditingController usernamecontroller = TextEditingController();


  bool showmagoinfo = false;
  bool showpaladininfo = false;
  bool showarcherinfo = false;
  bool showbarbarianinfo = false;

  void _ocultarInfoMago() {
    setState(() {
      showmagoinfo = false; // Ocultar el contenedor de información del Mago
    });
  }

  void _ocultarInfopaladin() {
    setState(() {
      showpaladininfo = false; // Ocultar el contenedor de información del Paladin
    });
  }

  void _ocultarInfobarbarian() {
    setState(() {
      showbarbarianinfo = false; // Ocultar el contenedor de información del Bárbaro
    });
  }

  void _ocultarInfoarcher() {
    setState(() {
      showarcherinfo = false; // Ocultar el contenedor de información del Arquero
    });
  }

  @override
  Widget build(BuildContext context) {
    final playerStats = Provider.of<PlayerStatsProvider>(context, listen: false);
    final userimage= Provider.of<UserProfileData>(context,listen:false);
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 100),
          Text(
            'Elige una clase',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
              decoration: TextDecoration.none,
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              setState(() {
                showmagoinfo = true; // Mostrar el contenedor de información del Mago
              });
            },
            child: Text('Mago'),
          ),
          Stack(
            children: [
              Visibility(
                visible: showmagoinfo,
                child: Card(
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              _ocultarInfoMago();
                            },
                            icon: Icon(Icons.arrow_back_ios),
                          ),
                          Text(
                            'Mago',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ],
                      ),
                      Image.asset(
                        'Assets/Pixel_Art_draw_a_sorcerer_pixel_art_avatar_0.jpg',
                        width: 350,
                        height: 350,
                      ),
                      Text(
                        'Tiene un cuerpo bastante ligero y débil, pero esta debilidad se contrarresta con su experiencia y conocimientos '
                            'en la magia y su cantidad de mana',
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center, // Centra los elementos verticalmente
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 24,
                                child: Icon(CupertinoIcons.heart, color: Colors.red),
                              ),
                              Text('HP: 50'),
                            ],
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Container(
                                width: 24,
                                child: Icon(CupertinoIcons.money_dollar),
                              ),
                              Text('DINERO: 100'),
                            ],
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Container(
                                width: 24,
                                child: Icon(CupertinoIcons.bolt),
                              ),
                              Text('MANA: 150'),
                            ],
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Container(
                                width: 24,
                                child: Icon(Icons.arrow_upward_sharp),
                              ),
                              Text('EXP: 0'),
                            ],
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Container(
                                width: 24,
                                child: Icon(CupertinoIcons.tree),
                              ),
                              Text('NIVEL: 1'),
                            ],
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {

                            playerStats.updateExperience(0);
                            playerStats.updateLevel(1);
                            playerStats.updateManas(150);
                            playerStats.updateMoneys(100);
                            playerStats.updateVidas(50);
                            userimage.setImage(AssetImage('Assets/Pixel_Art_draw_a_sorcerer_pixel_art_avatar_0.jpg'));
                          });

                          // Navegar a la página de inicio (HomePage) con parámetros específicos para el Mago
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (_) => HomePage(),),
                                  (route) => false
                          );
                        },
                        child: Text('Seleccionar Mago'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                showpaladininfo = true; // Mostrar el contenedor de información del Paladin
              });
            },
            child: Text('Paladín'),
          ),
          Stack(
            children: [
              Visibility(
                visible: showpaladininfo,
                child: Card(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              _ocultarInfopaladin();
                            },
                            icon: Icon(Icons.arrow_back_ios),
                          ),
                          Text(
                            'Paladín',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ],
                      ),
                      Image.asset('Assets/Pixel_Art_draw_a_paladin_pixel_art_avatar_1.jpg', width: 200, height: 200),
                      Text(
                        'Debido a su tamaño y su musculatura tiene más vida y algo mas de dinero siendo de clase '
                            'media',
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 24,
                                child: Icon(CupertinoIcons.heart, color: Colors.red),
                              ),
                              Text('HP: 150'),
                            ],
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Container(
                                width: 24,
                                child: Icon(CupertinoIcons.money_dollar),
                              ),
                              Text('DINERO: 130'),
                            ],
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Container(
                                width: 24,
                                child: Icon(CupertinoIcons.bolt),
                              ),
                              Text('MANA: 100'),
                            ],
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Container(
                                width: 24,
                                child: Icon(Icons.arrow_upward_sharp),
                              ),
                              Text('EXP: 0'),
                            ],
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Container(
                                width: 24,
                                child: Icon(CupertinoIcons.tree),
                              ),
                              Text('NIVEL: 1'),
                            ],
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          playerStats.updateExperience(0);
                          playerStats.updateLevel(1);
                          playerStats.updateManas(100);
                          playerStats.updateMoneys(130);
                          userimage.setImage(AssetImage('Assets/Pixel_Art_draw_a_paladin_pixel_art_avatar_1.jpg'));

                          print('${playerStats.moneys}');
                          // Navegar a la página de inicio (HomePage) con parámetros específicos para el Paladín
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (_) => HomePage(),
                            ),
                                (route) => false,
                          );
                        },
                        child: Text('Seleccionar Paladín'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                showbarbarianinfo = true; // Mostrar el contenedor de información del Bárbaro
              });
            },
            child: Text('Bárbaro'),
          ),
          Stack(
            children: [
              Visibility(
                visible: showbarbarianinfo,
                child: Card(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              _ocultarInfobarbarian();
                            },
                            icon: Icon(Icons.arrow_back_ios),
                          ),
                          Text(
                            'Bárbaro',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ],
                      ),
                      Image.asset('Assets/Pixel_Art_Draw_me_a_ilustration_who_was_a_image_icon_no_the_ch_1.jpg', width: 200, height: 200),
                      Text(
                        'Debido a su gran habilidad para la lucha y el saqueo, el Bárbaro tiene algo de dinero y experiencia en combate',
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 24,
                                child: Icon(CupertinoIcons.heart, color: Colors.red),
                              ),
                              Text('HP: 100'),
                            ],
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Container(
                                width: 24,
                                child: Icon(CupertinoIcons.money_dollar),
                              ),
                              Text('DINERO: 140'),
                            ],
                          ),
                          SizedBox( height: 4,),
                          Row(
                            children: [
                              Container(
                                width: 24,
                                child: Icon(CupertinoIcons.bolt),
                              ),
                              Text('MANA: 90'),
                            ],
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Container(
                                width: 24,
                                child: Icon(Icons.arrow_upward_sharp),
                              ),
                              Text('EXP: 0'),
                            ],
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Container(
                                width: 24,
                                child: Icon(CupertinoIcons.tree),
                              ),
                              Text('NIVEL: 3'),
                            ],
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            playerStats.updateExperience(0);
                            playerStats.updateLevel(3);
                            playerStats.updateManas(100);
                            playerStats.updateMoneys(130);
                            playerStats.updateVidas(150);
                            userimage.setImage(AssetImage('Assets/Pixel_Art_Draw_me_a_ilustration_who_was_a_image_icon_no_the_ch_1.jpg'));

                          });

                          // Navegar a la página de inicio (HomePage) con parámetros específicos para el Paladín
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (_) => HomePage()),
                                (route) => false,
                          );
                        },
                        child: Text('Seleccionar Paladín'),
                      ),

                    ],
                  ),
                ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                showarcherinfo = true; // Mostrar el contenedor de información del Arquero
              });
            },
            child: Text('Arquero'),
          ),
          Stack(
            children: [
              Visibility(
                visible: showarcherinfo,
                child: Card(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              _ocultarInfoarcher();
                            },
                            icon: Icon(Icons.arrow_back_ios),
                          ),
                          Text(
                            'Arquero',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ],
                      ),
                      Image.asset('Assets/Pixel_Art_use_the_second_image_what_you_are_generated_to_gener_2.jpg', width: 200, height: 200),
                      Text(
                        'Aunque tenga un cuerpo bastante ligero y no robusto, tiene una cantidad elevada de mana mayor al promedio y '
                            'algo de dinero debido también a algo de experiencia',
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 24,
                                child: Icon(CupertinoIcons.heart, color: Colors.red),
                              ),
                              Text('HP: 90'),
                            ],
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Container(
                                width: 24,
                                child: Icon(CupertinoIcons.money_dollar),
                              ),
                              Text('DINERO: 130'),
                            ],
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Container(
                                width: 24,
                                child: Icon(CupertinoIcons.bolt),
                              ),
                              Text('MANA: 120'),
                            ],
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Container(
                                width: 24,
                                child: Icon(Icons.arrow_upward_sharp),
                              ),
                              Text('EXP: 0'),
                            ],
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Container(
                                width: 24,
                                child: Icon(CupertinoIcons.tree),
                              ),
                              Text('NIVEL: 1'),
                            ],
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            playerStats.updateExperience(0);
                            playerStats.updateLevel(1);
                            playerStats.updateManas(120);
                            playerStats.updateMoneys(130);
                            playerStats.updateVidas(90);
                            userimage.setImage(AssetImage('Assets/Pixel_Art_use_the_second_image_what_you_are_generated_to_gener_2.jpg'));

                          });
                          // Navegar a la página de inicio (HomePage) con parámetros específicos para el Arquero
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (_) => HomePage(),
                            ),
                                (route) => false,
                          );
                        },
                        child: Text('Seleccionar Arquero'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
class ProfileNavigationBarItem extends BottomNavigationBarItem {
  ProfileNavigationBarItem()
      : super(
    icon: Container(

      width: 50, // Ajusta el tamaño según tus necesidades
      height: 50, // Ajusta el tamaño según tus necesidades
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.red,
            Colors.yellowAccent,
          ],
        ),
      ),
      child: Center(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    ),
    label: 'Perfil',
  );
}


class PlayerStatsProvider with ChangeNotifier {
  int level;
  int manas;
  int moneys;
  int experience;
  int maxexperience;
  int vidas;

  PlayerStatsProvider({
    this.maxexperience =100,
    this.vidas = 0,
    this.level = 0,
    this.manas = 0,
    this.moneys = 0,
    this.experience = 0,
  });

  // Métodos para actualizar los valores
  void updateLevel(int newLevel) {
    level = newLevel;
    notifyListeners(); // Notificar a los oyentes (widgets) del cambio
  }
  int calculateMaxExperience() {
    return (100 + (level - 1) * 50) * 10;
  }



  void levelup(){
    level ++;
    vidas += 10;
    moneys += moneys~/4;
    experience = 0;
    maxexperience = calculateMaxExperience();


  }



  void updateManas(int newManas) {
    manas = newManas;
    notifyListeners();
  }

  void updateMoneys(int newMoneys) {
    moneys = newMoneys;
    notifyListeners();
  }

  void updateExperience(int newExperience) {
    experience = newExperience;
    notifyListeners();
  }
  void updateVidas(int newvidas) {
    vidas = newvidas;
    notifyListeners();
  }
  void addExperience(int experiencePoints) {
    experience += experiencePoints;
    if(experience >= maxexperience){
      levelup();
    }
    notifyListeners(); // Notificar a los oyentes del cambio
  }
  void addMoneys(int value) {
    moneys += value;
    notifyListeners();
  }


}

class PageStatsProvider with ChangeNotifier {
  int? plasticoreciclado;
  int? completedmetas;
  int? papelreciclado;
  int? cristalreciclado;
  int? objetosgachapon;

  PageStatsProvider({
    this.papelreciclado = 0,
    this.plasticoreciclado = 0,
    this.cristalreciclado = 0,
    this.objetosgachapon = 0,
    this.completedmetas = 0,
  });

  void addPlasticoReciclado(int reciclajeplastico) {
    plasticoreciclado = (plasticoreciclado ?? 0) + reciclajeplastico;
    notifyListeners();
  }
  void addmetatostat(int metacompleteds) {
    completedmetas = (completedmetas ?? 0) + metacompleteds;
    notifyListeners();
  }

  void updatePapelReciclado(int newPapelReciclado) {
    papelreciclado = newPapelReciclado;
    notifyListeners();
  }

  void updateCristalReciclado(int newCristalReciclado) {
    cristalreciclado = newCristalReciclado;
    notifyListeners();
  }

  void updateObjetosGachapon(int newObjetosGachapon) {
    objetosgachapon = newObjetosGachapon;
    notifyListeners();
  }

  void addPapelReciclado(int papelReciclado) {
    papelreciclado = (papelreciclado ?? 0) + papelReciclado;
    notifyListeners();
  }

  void addCristalReciclado(int cristalReciclado) {
    cristalreciclado = (cristalreciclado ?? 0) + cristalReciclado;
    notifyListeners();
  }

  void addObjectGachapon(int objetosGachapon) {
    objetosgachapon = (objetosgachapon ?? 0) + objetosGachapon;
    notifyListeners();
  }
}

