import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:rpgreen/itemsbotttommain.dart';
import 'dart:math';
import 'main.dart';
import 'package:provider/provider.dart';
void main() {
  runApp(MaterialApp(
    home: ReciclajeIniciacion(),
  ));
}

class ReciclajeIniciacion extends StatefulWidget {
  @override
  ReciclajeIniciacionState createState() => ReciclajeIniciacionState();
}

class ReciclajeIniciacionState extends State<ReciclajeIniciacion> {

  int addedpoints = 0;
  int plastictypes = 0;
  int cartontypes= 0 ;
  int gachatype=0;
  int glasstype= 0;
  bool plastic = false;
  bool glass = false;
  bool carton = false;


  Color cartonColor = Colors.green;
  Color glassColor = Colors.green;
  Color plasticoColor = Colors.green;

  List<ReciclajeItem> reciclajeItems = [];


  String selectedValue = 'PET (1)';
  TextEditingController glassother= TextEditingController();
  TextEditingController cartonother= TextEditingController();
  TextEditingController plasticother= TextEditingController();
  List<String> dropdownItems = ['PET (1)', 'HDPE (2)', 'PVC (3)', 'LDPE (4)', 'PP (5)', 'PS (6)', 'Otros'];
  List<String> cartonitems= [ 'Rollo de cartón','Cajas de Cartón', 'Envases de carton' ,'Envases de huevos', 'Bolsas de carton', ];
  List<String> glassitems=['Botellas de cerveza','Botellas de refresco','Tuppers y envases  de vidrio','Frascos','Vasos y copas',];



  void setPlastico() {
    setState(() {
      plastic = true;
      glass = false;
      carton = false;
      plasticoColor = Colors.black;
    });
  }

  void setCarton() {
    setState(() {
      plastic = false;
      glass = false;
      carton = true;
      cartonColor = Colors.black;
    });
  }

  void setGlass() {
    setState(() {
      plastic = false;
      glass = true;
      carton = false;
      glassColor = Colors.black;
    });
  }

  void addReciclajeItem(String petType, int? points) {
    ReciclajeItem item;

    if (points == null) {
      final random = Random();
      points = random.nextInt(30) + 1;
      item = ReciclajeItem(petType, 'Bolsa', points, context);
    } else {
      item = ReciclajeItem(petType, 'Bolsa', points, context);
    }

    reciclajeItems.add(item);
    addedpoints += points;
  }



  void showplasticaviso() {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Tipos de plástico'),
          content: Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.7,
              maxWidth: MediaQuery.of(context).size.width * 0.7,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 3),
                  _buildPlasticRow('PET 1',' (Tereftalato de Polietileno): Botellas de agua o de bebidas,en textiles con tipo PET,'),
                  SizedBox(height:50),
                  _buildPlasticRow('HDPE 2',' (Polietileno de alta densidad): Botellas de leche, lejía, limpiadores y la mayoría de las botellas de champú, muchos envases domésticos y de productos químicos industriales como detergentes y cloro'),
                  SizedBox(height:50),_buildPlasticRow('PVC 3','(Policloruro de vinilo): Tubería de distribución de agua potable, Persianas, Suelos, Puertas, Ventanas,Láminas para impermeabilización, Revestimientos para diversos usos en paredes,Canalización eléctrica y de otros tipo'),
                  SizedBox(height:50), _buildPlasticRow('LDPE 4',' (Polietileno de baja densidad): Contenedores para zumo, Película transparente,Diversos tipos de bolsas,Bandejas,Anillos, para agrupar seis latas de refresco,Tuberías,Prótesis,Botellas utilizadas para lavado,Tapas para helado,Procesos de moldeo por extrusión,Laminados'),
                  SizedBox(height:50),_buildPlasticRow('PP 5',' (Polipropileno):Juguetes para niños,Vasos de plástico,Materiales de construcción,Piezas de automóvil,Recipientes para alimentos, medicinas o productos químicos,Ropa y electrodomésticos,Sacacorchos,Alfombras'),
                  SizedBox(height:50),_buildPlasticRow('PS 6',' (Poliestireno): Tipos:Botes de yogur, cubiertos de plástico, embalaje de protección para los productos electrónicos y juguetes, material aislante, contenedores, tapas, copas, botellas, envases lácteos, bandejas de carne, cartones de huevos, casetes, CD, embalaje, industrial, juguetes, cubiertos, desechables, duchas.'),
                  SizedBox(height:50), _buildPlasticRow('Otros','(Plásticos  mezcla) Mezclas de plásticos u plásticos los cuales no estén o no sepas qué tipo de plástico es (si en el objeto predomina un tipo de plástico se pondrá ese tipo de plástico y no otros)'),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                print('arriba España');
                Navigator.of(dialogContext).pop(); // Dismiss alert dialog
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildPlasticRow(String Richtext,String text) {
    return Row(
      children: [
       Expanded(child:Text(Richtext,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,),),
       ),
        SizedBox(width: 0,),
        Expanded(child: Text(text)),
        SizedBox(height: 160,)
      ],
    );
  }

  void glassotro(){
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0), // Ajusta el radio aquí
              child: AlertDialog(
                backgroundColor: Colors.blueGrey.shade900,
                title: Text('Escribe tu objeto'),
                content: TextField(
                  controller: glassother,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    filled: true,
                    fillColor: Colors.grey,
                    suffixText: 'Objeto',
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text('Ok'),
                    onPressed: () {
                      addReciclajeItem(glassother.text, null   );
                      glasstype ++;
                      print('$glasstype');
                      Navigator.pop(context);

                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

  }
  void cartonotro(){
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0), // Ajusta el radio aquí
              child: AlertDialog(
                backgroundColor: Colors.blueGrey.shade900,
                title: Text('Escribe tu objeto'),
                content: TextField(
                  controller: cartonother,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    filled: true,
                    fillColor: Colors.grey,
                    suffixText: 'Objeto',
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text('Ok'),
                    onPressed: () {
                      addReciclajeItem(cartonother.text, null   );
                      Navigator.pop(context);
                      cartontypes++;// Dismiss alert dialog
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

  }
  void plasticotro(){
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0), // Ajusta el radio aquí
              child: AlertDialog(
                backgroundColor: Colors.blueGrey.shade900,
                title: Text('Escribe tu objeto'),
                content: TextField(
                  controller: plasticother,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    filled: true,
                    fillColor: Colors.grey,
                    suffixText: 'Objeto',
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text('Ok'),
                    onPressed: () {
                      addReciclajeItem(plasticother.text, null   );
                      Navigator.pop(context);
                      plastictypes++;// Dismiss alert dialog
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

  }
  void addpointprovider() {
    var anadirpuntos = Provider.of<PlayerStatsProvider>(context, listen: false);
    var stprovideradd= Provider.of<PageStatsProvider>(context,listen: false);
    var grafic= Provider.of<GraficController>(context,listen: false);
    double plasticDouble = plastictypes.toDouble();
    double glassDouble = glasstype.toDouble();
    double cartonDouble = cartontypes.toDouble();
    grafic.addTografic(Graficitem(plasticDouble, 1));
    grafic.addTograficcristal(Graficitem(glassDouble as double, 1));
    grafic.addTograficpapel(Graficitem(cartonDouble as double, 1));
    stprovideradd.addCristalReciclado(glasstype);
    stprovideradd.addPapelReciclado(cartontypes);
    stprovideradd.addPlasticoReciclado(plastictypes);
    anadirpuntos.updateExperience(anadirpuntos.experience + addedpoints);
    print('${plasticDouble} y $cartonDouble de carton y $glassDouble de cristal');

    Navigator.pop(context);
    // Agrega cualquier lógica adicional que necesites aquí después de la actualización.
  }

  @override

  Widget build(BuildContext context) {
    var stprovider= Provider.of<PageStatsProvider>(context,listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.green.shade900,
        automaticallyImplyLeading: false,
        actions: [
          SizedBox(width: 4,),
          Padding(padding: EdgeInsets.only(top: 5,right: 10),
          child:IconButton(
            onPressed: () {
              addpointprovider();


              // Agrega la lógica que se ejecutará cuando se presione el botón
            },
            icon: Icon(
              Icons.check,
              color: Colors.white,
              size: 30,
            ),
          )

          ),




        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: 100),
              Text(
                'Fecha: ${DateFormat('dd/MM/y').format(DateTime.now())}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'San Francisco',
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: setCarton,
                    icon: Image.asset(
                      'Assets/6022632_beverage_bottle_coffee_drink_drinks_icon.png',
                      color: cartonColor,
                      height: 50,
                      width: 50,
                    ),
                  ),
                  SizedBox(width: 4),
                  IconButton(
                    onPressed: setGlass,
                    icon: Image.asset('Assets/9057048_glass_icon.png', color: glassColor),
                  ),
                  SizedBox(width: 4),
                  IconButton(onPressed: setPlastico, icon: Icon(Icons.shopping_bag, color: plasticoColor)),
                ],
              ),
              SizedBox(height: 4),

              Visibility(
                visible: plastic,
                child: Column(
                  children: [
                    Text(
                      'Plástico',
                      style: TextStyle(color: Colors.green, fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 2,),

                    TextButton(
                      onPressed: showplasticaviso,
                      child: Text(
                        'No se que plástico es',
                        style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Tipos de plástico',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'San Francisco',
                        fontWeight: FontWeight.normal,
                        fontSize: 20,
                      ),
                    ),

                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      alignment: WrapAlignment.center,
                      children: [
                        for (int i = 0; i < dropdownItems.length; i++)
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(115, 100),
                              maximumSize: Size(115, 100),
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(color: Colors.black),
                              ),
                            ),
                            onPressed: () {
                              int increment = (i + 1) * 10; // Aumenta en incrementos de 10
                              addReciclajeItem(dropdownItems[i], increment);
                              plastictypes++;

                            },
                            child: Column(
                              children: [
                                Icon(Icons.recycling, color: Colors.white),
                                Text(dropdownItems[i]),
                              ],
                            ),
                          ),
                        ElevatedButton(child: Column(
                          children: [
                            Icon(CupertinoIcons.ellipsis,color: Colors.black,),
                            Text('Otro'),
                          ],

                        ),onPressed:
                        plasticotro
                        ),
                      ],

                    ),
                  ],
                ),
              ),
              SizedBox(height: 0),
              Visibility(
                visible: glass,
                child: Column(
                   children: [
                    Text(
                      'Cristal',
                      style: TextStyle(color: Colors.green, fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                     Wrap(
                       spacing: 8,
                       runSpacing: 8,
                       alignment: WrapAlignment.center,
                       children: [
                         for (int i = 0; i < glassitems.length; i++)
                           ElevatedButton(
                             style: ElevatedButton.styleFrom(
                               minimumSize: Size(115, 100),
                               backgroundColor: Colors.green,
                               foregroundColor: Colors.black,
                               shape: RoundedRectangleBorder(
                                 borderRadius: BorderRadius.circular(10),
                                 side: BorderSide(color: Colors.black),
                               ),
                             ),
                             onPressed: () {
                               int increment = (i + 1) * 10; // Aumenta en incrementos de 10
                               addReciclajeItem(glassitems[i], increment);
                               glasstype++;
                               print('$glasstype');
                             },
                             child: Column(
                               children: [
                                 Icon(Icons.recycling, color: Colors.white),
                                 Text(glassitems[i]),
                               ],
                             ),
                           ),
                         ElevatedButton(child: Column(
                           children: [
                             Icon(CupertinoIcons.ellipsis,color: Colors.black,),
                             Text('Otro'),
                           ],

                         ),onPressed:
                             glassotro
                         ),
                       ],
                     ),

                  ],
                ),
              ),
              SizedBox(height: 0),
              Visibility(
                visible: carton,
                child: Column(
                  children:[

                 Text( 'Carton',
                  style: TextStyle(color: Colors.green, fontSize: 40, fontWeight: FontWeight.bold),
                ),
                    SizedBox(height: 8,),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      alignment: WrapAlignment.center,
                      children: [
                        for (int i = 0; i < cartonitems.length; i++)
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(115, 100),
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(color: Colors.black),
                              ),
                            ),
                            onPressed: () {
                              int increment = (i + 1) * 10; // Aumenta en incrementos de 10
                              addReciclajeItem(cartonitems[i], increment);
                              cartontypes++ ;
                            },
                            child: Column(
                              children: [
                                Icon(Icons.recycling, color: Colors.white),
                                Text(cartonitems[i]),
                              ],
                            ),
                          ),
                        ElevatedButton(child: Column(
                          children: [
                            Icon(CupertinoIcons.ellipsis,color: Colors.black,),
                            Text('Otro'),
                          ],

                        ),onPressed:
                        cartonotro
                        ),
                      ],
                    ),


                ],
              ),
              ),

              Expanded(
                child: Container(
                  child:ListView.builder(
                  shrinkWrap: true,
                  itemCount: reciclajeItems.length,
                  itemBuilder: (context, index) {
                    final item = reciclajeItems[index];
                    return ListTile(
                      tileColor: Colors.grey,
                      title: Text('Tipo: ${item.petType}, Puntos: ${item.points}'),
                    );
                    
                  },
                ),
                ),
              ),


            ],
          ),
          Positioned(
            top: 50,
            right: 20,
            child: Text(
              '+$addedpoints',
              style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 40),
            ),
          ),
         
        ],
      ),
    );
  }
}


class ReciclajeItem {
  final String petType;
  final String itemType;
  final int points;
  final BuildContext context;

  ReciclajeItem(this.petType, this.itemType, this.points, this.context);
}
class MetaListItem{
   String titulometa;
   String descmeta;
  final int glasslistcount;
  final int cartonlistcount;
  final int plasticlistcount;

MetaListItem(  this.titulometa, this.descmeta, this.cartonlistcount, this.glasslistcount,this.plasticlistcount);
}



class Meta extends StatefulWidget {

  @override
  MetaState createState() => MetaState();
}

class MetaState extends State<Meta> {
  // ignore: unused_field
  int _glasscounter=0;
  int cartoncounter= 0;
  int plasticounter= 0;
  TextEditingController metascontroller = TextEditingController();
  TextEditingController metadescontroller= TextEditingController();
  bool esobjeto= false;
  void agregarMeta() {
    if(metascontroller.text.isNotEmpty) {
      setState(() {
        String nuevaMeta = metascontroller.text;
        String descripcionMeta = metadescontroller.text;
        int cartonCount = cartoncounter;
        int glassCount = _glasscounter;
        int plasticCount = plasticounter;

        MetaListItem nuevaMetaItem = MetaListItem(
          nuevaMeta,
          descripcionMeta,
          cartonCount,
          glassCount,
          plasticCount,
        );

        // Utiliza Navigator.pop para pasar la nueva meta de regreso a la página anterior
        Navigator.pop(context, nuevaMetaItem);
        metascontroller.clear();

      });
    }
    else if(metascontroller.text.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Necesita un titulo obligatoriamente')));
      return null;
    }
  }

  void _incrementCounterglass() {
    setState(() {
      _glasscounter++;
    });
  }

  void _decrementCounterglass() {
    setState(() {
      _glasscounter--;
    });
    if (_glasscounter < 0) {
      _glasscounter++;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("El contador de cristal no puede ser negativo."),
      ));
    }
  }


  void _incrementCountercarton() {
    setState(() {
      cartoncounter++;
    });

  }

  void _decrementCounterCarton() {
    setState(() {
      cartoncounter--;
      if (cartoncounter < 0) {
        cartoncounter++;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("El contador de carton no puede ser negativo."),
        ));
      }
    });
  }
  void _incrementCounterplastic() {
    setState(() {
      plasticounter++;
    });
  }

  void _decrementCounterplastic() {
    setState(() {
      plasticounter--;
      if (plasticounter < 0) {
        plasticounter++;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("El contador de plastico no puede ser negativo."),
        ));
      }
    });
  }void restartall(){

    setState(() {
      _glasscounter =0;
      cartoncounter= 0;
      plasticounter=0;
    });

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Nueva Meta'),
        backgroundColor: Colors.green.shade900,
        foregroundColor: Colors.white,
        actions: [
          TextButton(onPressed: agregarMeta,
              child: Text('Agregar Meta',style: TextStyle(color: Colors.blue,fontSize: 15),))
        ],

      ),
     body: Column(
       crossAxisAlignment: CrossAxisAlignment.center,
       mainAxisAlignment: MainAxisAlignment.start,
       children: [
         Container(
           margin: EdgeInsets.only(left: 3,right: 3,top: 3),
         child:TextField(

           controller: metascontroller,
           autocorrect: true,
           showCursor: true,
           cursorColor: Colors.green.shade900,

           decoration: InputDecoration(

             filled: true,
             fillColor: Colors.white,
            border: OutlineInputBorder(),
             focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.green.shade900,style: BorderStyle.solid)),
             labelText: 'Nueva meta'
           ),
         ),
         ),
         SizedBox(height: 8,),
         Container(
           margin: EdgeInsets.only(left: 3,right: 3,top: 3),
         child:TextField(


           controller: metadescontroller,
           autocorrect: true,
           showCursor: true,
           cursorColor: Colors.green.shade900,


           decoration: InputDecoration(

               filled: true,
               fillColor: Colors.white,
               labelText: 'Descripción meta',
               border: OutlineInputBorder(),
               focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.green.shade900,style: BorderStyle.solid))


           ),
         ),
         ),
         SizedBox(height: 4,),
         Text('Es una meta con objeto'),
         Checkbox(


           value: esobjeto,
           onChanged: (newValue) {
             setState(() {
               esobjeto = !esobjeto;
             });
           },
         ),
         Visibility(
           visible: esobjeto,
           child: Column(
             children: [
               SizedBox(height: 16),
               Row(
                 mainAxisAlignment: MainAxisAlignment.end, // Alineación a la derecha
                 children: [
                   SizedBox(height: 16),
                   Align(
                     alignment: Alignment.centerRight, // Alineación a la derecha
                     child: TextButton(
                       child: Text(
                         'Restart all',
                         style: TextStyle(
                           color: Colors.green,
                           fontWeight: FontWeight.bold,
                         ),
                       ),
                       onPressed: restartall,
                     ),
                   ),
                 ],
               ),

               // Aumentamos el espacio vertical para mayor claridad
               Container(

                 margin: EdgeInsets.only(right: 2,left: 2),
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(20),
                   color: Colors.grey,
                   border: Border.all(
                     color: Colors.black
                   )
                 ),
                 clipBehavior: Clip.none,
                 child: LayoutBuilder(
                   builder: (context, constraints) {
                     return Row(

                       children: [
                         Padding(padding: EdgeInsets.only(bottom: 2,left: 6,top: 2),
                         child:Image.asset('Assets/10532688_lastic_bottle_icon.png', color: Colors.green.shade900,width: 70,height: 70,
                          ),
                         ),
                           // Aumentamos el espacio horizontal para mayor claridad
                         Flexible(
                           child: Text('Cantidad de plástico'),
                         ),
                         SizedBox(width: 4,),

                         ElevatedButton(
                           onPressed: _decrementCounterplastic,
                           child: Center(
                             child: Icon(
                               CupertinoIcons.minus,
                               color: Colors.white,
                             ),
                           ),
                           style: ButtonStyle(
                             backgroundColor: MaterialStateProperty.all(Colors.green.shade900),
                             foregroundColor: MaterialStateProperty.all(Colors.white),
                           ),
                         ),
                         SizedBox(width: 4,),
                         ElevatedButton(
                           onPressed: _incrementCounterplastic,
                           child: Center(
                             child: Icon(
                               Icons.add,
                               color: Colors.white,
                             ),
                           ),
                           style: ButtonStyle(
                             backgroundColor: MaterialStateProperty.all(Colors.green.shade900),
                             foregroundColor: MaterialStateProperty.all(Colors.white),
                           ),
                         ),
                         SizedBox(width: 4,),
                         Text('$plasticounter',style: TextStyle(
                           fontSize: 20,
                           fontWeight: FontWeight.bold,
                           color: Colors.black


                         ),)


                       ],
                     );
                   },
                 ),
               ),
           SizedBox(height: 12,),
           Container(

             margin: EdgeInsets.only(right: 2,left: 2),
             decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(20),
                 color: Colors.grey,
                 border: Border.all(
                     color: Colors.black
                 )
             ),
             clipBehavior: Clip.none,
             child: LayoutBuilder(
               builder: (context, constraints) {
                 return Row(

                   children: [
                     Padding(padding: EdgeInsets.only(left: 16,bottom: 2),
                     child:Image.asset('Assets/2205214_block_box_cube_shipping_icon.png', color: Colors.green.shade900,width: 70,height: 70,
                     ),
                     ),
                     // Aumentamos el espacio horizontal para mayor claridad
                     Flexible(
                       child: Text('Cantidad de Carton'
                           ),
                     ),
                     SizedBox(width: 4,),

                     ElevatedButton(
                       onPressed: _decrementCounterCarton,
                       child: Center(
                         child: Icon(
                           CupertinoIcons.minus,
                           color: Colors.white,
                         ),
                       ),
                       style: ButtonStyle(
                         backgroundColor: MaterialStateProperty.all(Colors.green.shade900),
                         foregroundColor: MaterialStateProperty.all(Colors.white),
                       ),
                     ),
                     SizedBox(width: 4,),
                     ElevatedButton(
                       onPressed: _incrementCountercarton,
                       child: Center(
                         child: Icon(
                           Icons.add,
                           color: Colors.white,
                         ),
                       ),
                       style: ButtonStyle(
                         backgroundColor: MaterialStateProperty.all(Colors.green.shade900),
                         foregroundColor: MaterialStateProperty.all(Colors.white),
                       ),
                     ),
                     SizedBox(width: 4,),
                     Text('$cartoncounter',style: TextStyle(
                         fontSize: 20,
                         fontWeight: FontWeight.bold,
                         color: Colors.black


                     ),)


                   ],
                 );
               },
             ),
           ),
               SizedBox(height: 12,),
               Container(

                 margin: EdgeInsets.only(right: 2,left: 2),
                 decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(20),
                     color: Colors.grey,
                     border: Border.all(
                         color: Colors.black
                     )
                 ),
                 clipBehavior: Clip.none,
                 child: LayoutBuilder(
                   builder: (context, constraints) {
                     return Row(

                       children: [
                         Padding(
                           padding: const EdgeInsets.only(left: 8.0), // Ajusta el valor del margen a tus necesidades
                           child: Image.asset(
                             'Assets/4299194_glass_medium_drink_water_icon.png',
                             color: Colors.green.shade900,
                             width: 70,
                             height: 70,
                           ),
                         ),
                         // Aumentamos el espacio horizontal para mayor claridad
                         Flexible(
                           child: Text('Cantidad de Cristal'
                           ),
                         ),
                         SizedBox(width: 4,),

                         ElevatedButton(
                           onPressed: _decrementCounterglass,
                           child: Center(
                             child: Icon(
                               CupertinoIcons.minus,
                               color: Colors.white,
                             ),
                           ),
                           style: ButtonStyle(
                             backgroundColor: MaterialStateProperty.all(Colors.green.shade900),
                             foregroundColor: MaterialStateProperty.all(Colors.white),
                           ),
                         ),
                         SizedBox(width: 4,),
                         ElevatedButton(
                           onPressed: _incrementCounterglass,
                           child: Center(
                             child: Icon(
                               Icons.add,
                               color: Colors.white,
                             ),
                           ),
                           style: ButtonStyle(
                             backgroundColor: MaterialStateProperty.all(Colors.green.shade900),
                             foregroundColor: MaterialStateProperty.all(Colors.white),
                           ),
                         ),
                         SizedBox(width: 4,),
                         Text('${_glasscounter}',style: TextStyle(
                             fontSize: 20,
                             fontWeight: FontWeight.bold,

                             color: Colors.black


                         ),)


                       ],
                     );
                   },
                 ),
               ),

             ],
           ),
         ),

       ],




     ),
    );
  }
}