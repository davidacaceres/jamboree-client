import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:Pasaporte_2020/model/carrousel.dart';
import 'package:Pasaporte_2020/model/content.dart';
import 'package:flutter/services.dart' show rootBundle;

final List<Content> _listContent =[];
/*[
  new Content(
    id: "id_1",
    root:true,
    order: 1,
    title: "Propuesta Educativa Jamboree 2020",
    titleList: "Propuesta Educativa",
    image: "assets/img/asociacion.png",
    backgroundPage: [
      247,
      177,
      19
    ],
    display: [
      Display(shortTitle: "Over", content: [
        ContentElement(
            paragraphConf: ParagraphConf(backgroundColor: [
          247,
          177,
          19
        ], textColor: [
          0,
          0,
          0
        ], data: "En el año 2013 , la Asociación propuso a los jóvenes el 8° Jamboree Nacional, donde la invitación se centraba en la educación entre pares: guías, scouts, pioneras, pioneros")),
      ]),
      Display(shortTitle: "COnt", content: [
        ContentElement(
          paragraphConf: ParagraphConf(
              backgroundColor: [247, 177, 19],
              textColor: [0, 0, 0],
              data:
                  "En el año 2013 , la Asociación propuso a los jóvenes el 8° Jamboree Nacional, donde la invitación se centraba en la educación entre pares: guías, scouts, pioneras, pioneros"),
        ),
        ContentElement(
            imageConf: ImageConf(
                source: "http://imagen",
                align: "center",
                backgroundColor: [247, 177, 19])),
      ])
    ],
  ),
  new Content(
      id: "id_2",
      title: "¿Dónde será el Jamboree?",
      titleList: "¿Dónde?",
      order: 2,
      image: "assets/img/carpa.jpg",
backgroundPage: [
255,
255,
255
],
      display: [
        Display(content: [
          ContentElement(
              paragraphConf: ParagraphConf(backgroundColor: [
            255,
            255,
            255
          ], textColor: [
            255,
            0,
            255
          ], data: "<h1>&iquest;D&oacute;nde ser&aacute; el Jamboree_?<\/h1>\r\n<p style=\"text-align: justify;\"><br \/><strong>El 10&deg; Jamboree Nacional 2020<\/strong> se desarrollar&aacute; en la ic&oacute;nica Hacienda Picarqu&iacute;n, la misma que fue construida para acoger al <span style=\"text-decoration: underline;\">19&deg; Jamboree Scout Mundial<\/span>, a fines de <em>1998<\/em> y comienzos de <em>1999<\/em>. Se ha escogido este sitio por la conmemoraci&oacute;n de los 20 a&ntilde;os de ese encuentro mundial y porque cumple con las caracter&iacute;sticas e infraestructura necesarias para la adecuada realizaci&oacute;n de un campamento que se espera acoja a 10 mil personas.<\/p>\r\n<p style=\"text-align: justify;\">&nbsp;<\/p>\r\n<p style=\"text-align: justify;\"><img src=\"https:\/\/picsum.photos\/id\/22\/400\/180\" alt=\"Imagen de Prueba\" width=\"400\" height=\"180\" \/><\/p>"))
        ]),
      ]),
  new Content(
      id: "id_3",
      title: "¿Cuándo será el Jamboree?",
      titleList: "¿Cuando?",
      order: 3,
      image: "assets/img/boyscout.gif",
      display: [
        Display(
          shortTitle: "Overview",
          content: [
            ContentElement(
                paragraphConf: ParagraphConf(backgroundColor: [
              247,
              177,
              19
            ], textColor: [
              0,
              0,
              0
            ], data: "Nuestro campamento nacional tendrá lugar desde el domingo 19 y hasta el domingo 26 de enero de 2020. Se podrá ingresar al campo desde el domingo 19 de enero a las 08:00 y se debe salir el domingo 26 de enero hasta las 18:00 horas a más tardar"))
          ],
        ),
        Display(
          shortTitle: "Content",
          content: [
            ContentElement(
                paragraphConf: ParagraphConf(backgroundColor: [
              247,
              177,
              19
            ], textColor: [
              0,
              0,
              0
            ], data: "<p>&iquest;Cu&aacute;ndo ser&aacute; el Jamboree?<\/p><p><br \/>Nuestro campamento nacional tendr&aacute; lugar desde el domingo 19 y hasta el domingo 26 de enero de 2020. Se podr&aacute; ingresar al campo desde el domingo 19 de enero a las 08:00 y se debe salir el domingo 26 de enero hasta las 18:00 horas a m&aacute;s tardar.<\/p><p>Se dispone del domingo 19 para la ubicaci&oacute;n en el subcampo correspondiente y la instalaci&oacute;n de las patrullas y Unidades. El domingo 26 es el d&iacute;a asignado para el desarme y despedida.<\/p><p><br \/>Entregamos a continuaci&oacute;n la informaci&oacute;n general para que programen las horas de viaje, de llegada y de salida, de manera que tanto el acceso como la partida transcurran en orden.<\/p><p>&nbsp;<\/p><table style=\"height: 19px;\" width=\"675\"><tbody><tr><td style=\"width: 61px;\">&nbsp;<\/td><td style=\"width: 61px;\">Sa 18<\/td><td style=\"width: 61px;\">Do 19<\/td><td style=\"width: 61px;\">Lu 20<\/td><td style=\"width: 61px;\">Ma 21<\/td><td style=\"width: 61px;\">Mi 22<\/td><td style=\"width: 61px;\">Ju 23<\/td><td style=\"width: 61px;\">Vi 24<\/td><td style=\"width: 61px;\">Sa 25<\/td><td style=\"width: 62px;\">Do 26<\/td><\/tr><tr><td style=\"width: 61px;\">AM<\/td><td style=\"width: 61px;\">Llegada voluntarios en servicio<br \/><br \/><\/td><td style=\"width: 61px;\">Llegada e Instalaci&oacute;n de participantes<\/td><td style=\"width: 61px;\">Programa<\/td><td style=\"width: 61px;\">Programa<\/td><td style=\"width: 61px;\">Programa<\/td><td style=\"width: 61px;\">Programa<\/td><td style=\"width: 61px;\">Programa<\/td><td style=\"width: 61px;\">Desarme<\/td><td style=\"width: 62px;\">Despedida<\/td><\/tr><tr><td style=\"width: 61px;\">PM<\/td><td style=\"width: 61px;\">Capacitaci&oacute;n servicio - Montaje y preparaci&oacute;n general<\/td><td style=\"width: 61px;\">Llegada e Instalaci&oacute;n de participantes<\/td><td style=\"width: 61px;\">Programa<\/td><td style=\"width: 61px;\">Programa<\/td><td style=\"width: 61px;\">Programa<\/td><td style=\"width: 61px;\">Programa<\/td><td style=\"width: 61px;\">Programa<\/td><td style=\"width: 61px;\">Programa<\/td><td style=\"width: 62px;\">Despedida<\/td><\/tr><tr><td style=\"width: 61px;\">&nbsp;<\/td><td style=\"width: 61px;\">&nbsp;<\/td><td style=\"width: 61px;\">&nbsp;<\/td><td style=\"width: 61px;\">Inauguraci&oacute;n<\/td><td style=\"width: 61px;\">Velada<br \/>Subcampo<\/td><td style=\"width: 61px;\">Velada<br \/>Subcampo<\/td><td style=\"width: 61px;\">Velada<br \/>Subcampo<\/td><td style=\"width: 61px;\">Velada<br \/>Subcampo<\/td><td style=\"width: 61px;\">Clausura<\/td><td style=\"width: 62px;\">&nbsp;<\/td><\/tr><tr><td style=\"width: 61px;\">&nbsp;<\/td><td style=\"width: 61px;\">&nbsp;<\/td><td style=\"width: 61px;\">&nbsp;<\/td><td style=\"width: 61px;\">&nbsp;<\/td><td style=\"width: 61px;\">&nbsp;<\/td><td style=\"width: 61px;\">&nbsp;<\/td><td style=\"width: 61px;\">&nbsp;<\/td><td style=\"width: 61px;\">&nbsp;<\/td><td style=\"width: 61px;\">&nbsp;<\/td><td style=\"width: 62px;\">&nbsp;<\/td><\/tr><\/tbody><\/table>"))
          ],
        ),
      ]),
  new Content(
      id: "id_4",
      order: 4,
      title: "¿Quiénes pueden participar?",
      titleList: "¿Quiénes?",
      display: [
        Display(shortTitle: "Overview", content: [
          ContentElement(
              paragraphConf: ParagraphConf(backgroundColor: [
            247,
            177,
            19
          ], textColor: [
            0,
            0,
            0
          ], data: "La unidad básica de participación durante el 10° Jamboree Nacional será la patrulla. El requisito básico de participación será el que los Grupos de los asistentes estén con su Registro 2019 al día"))
        ]),
        Display(
          shortTitle: "Content",
          content: [
            ContentElement(
                paragraphConf: ParagraphConf(backgroundColor: [247,177,19], textColor: [
              0,
              0,
              0
            ], data: "<h1>&iquest;Qui&eacute;nes pueden par_ticipar?<\/h1><p><br \/> <font color=\"red\">This is some text!<\/font>La unidad b&aacute;sica de participaci&oacute;n durante el 10&deg; Jamboree Nacional ser&aacute; la patrulla. El requisito b&aacute;sico de participaci&oacute;n ser&aacute; el que los Grupos de los asistentes est&eacute;n con su Registro 2019 al d&iacute;a. <br \/> Los requisitos espec&iacute;ficos para los distintos tipos de participantes son:<\/p><ol><li><strong> Gu&iacute;as y Scouts <\/strong> nacidos entre el <strong> 20 de julio de 2004 <\/strong> y el <strong> 19 de enero de 2009 <\/strong> .<\/li><li><strong> <font color= \"red;\">Guiadoras y Dirigentes acompa&ntilde;antes<\/font> <\/strong> de las gu&iacute;as y los scouts, <strong> mayores de edad <\/strong> , que se desempe&ntilde;en como Responsables o Asistentes de Unidad, tanto en Compa&ntilde;&iacute;a como en Tropa, que hayan participado de un Curso Inicial y que idealmente hayan participado en un Curso Medio en alguna de estas Ramas.<\/li><li><strong> Pioneras y Pioneros mayores de 16 a&ntilde;os <\/strong> , que hayan postulado exitosamente al Equipo de Servicio. Esta postulaci&oacute;n deber&aacute; ser por Comunidad, <strong> con un m&iacute;nimo de 4 integrantes mayores de 16 a&ntilde;os <\/strong> , acompa&ntilde;ados por una Guiadora o Dirigente responsable de ellos.<\/li><li><strong> Caminantes que hayan postulado al Equipo de Servicio exitosamente <\/strong> . Su postulaci&oacute;n solo podr&aacute; ser individual si son mayores de 18 a&ntilde;os y han participado del Curso Inicial; de lo contrario deben venir acompa&ntilde;ados por una guiadora o dirigente.<\/li><li>Guiadoras y Dirigentes de cualquier Rama que hayan postulado con &eacute;xito al Equipo de Servicio . Deben ser <strong> mayores de 18 a&ntilde;os <\/strong> y haber participado al menos de un Curso Inicial.<\/li><\/ol>"))
          ],
        ),
      ],
      image: "assets/img/mowgli.gif"),
  new Content(
      id: "id_5",
      order: 5,
      title:
          "El Equipo Organizador del 10° Jamboree Nacional y su estructura organizacional",
      titleList: "El Equipo",
      image: "assets/img/bagheera.gif",
      display: [
        Display(shortTitle: "Descripción", content: [
          ContentElement(
              paragraphConf: ParagraphConf(backgroundColor: [
            247,
            177,
            19
          ], textColor: [
            0,
            0,
            0
          ], data: "El Jamboree contará con una organización y estructura apropiada que permita el logro de los objetivos del evento"))
        ], childs: [
          Child(id: "id_2", order: 1, title: "¿Dónde será el Jamboree?"),
          Child(id: "id_3", order: 2, title: "¿Cuándo será el Jamboree?")
        ]),
        Display(
          shortTitle: "Informacion",
          content: [
            ContentElement(
                paragraphConf: ParagraphConf(backgroundColor: [
              247,
              177,
              19
            ], textColor: [
              0,
              0,
              0
            ], data: "<h1>El Equipo Organizador del 10&deg; Jamboree Nacional y su estructura organizacional<\/h1><p><br \/>El Jamboree contar&aacute; con una organizaci&oacute;n y estructura apropiada que permita el logro de los objetivos del evento. La conformaci&oacute;n del Equipo de Campo es la siguiente:<\/p><p><br \/>Responsable de Campo: Juan Pablo Reyes<br \/>Asistente de Campo: Daniela Pardo<br \/>Responsable de Programa: Juan Pablo Menichetti<br \/>Responsable de Vida de Subcampo: Carolina Avalos<br \/>Responsable de Servicios: Juan Jos&eacute; Polanco<br \/>Representante del Comit&eacute; Ejecutivo Nacional: Patricio Criado<br \/>Un observador del Consejo Nacional<\/p><p>&nbsp;<\/p><h2>Las cuotas de participaci&oacute;n en el 10&deg; Jamboree<\/h2><p><br \/>Las cuotas fueron establecidas sobre la base de los siguientes criterios:<\/p><ol style=\"list-style-type: lower-alpha;\"><li>Ajuste seg&uacute;n las cuotas consideradas para la Aventura Nacional 2019.<\/li><li>Distancia del lugar de procedencia en relaci&oacute;n con el lugar del 10&deg; Jamboree Nacional.<\/li><li>Categorizaci&oacute;n de Registro de los Grupos.<\/li><li>Diferenciaci&oacute;n seg&uacute;n tipo de asistente: Gu&iacute;as y Scouts; Guiadoras y Dirigentes acompa&ntilde;antes a cargo de las Unidades; Guiadoras, Dirigentes, Pioneras, Pioneros y Caminante que integrar&aacute;n los equipos de voluntarios en servicio.<\/li><\/ol><p>&nbsp;<\/p><h3>&iquest;Qu&eacute; comprenden las cuotas?<\/h3><p>&nbsp;<\/p><ol><li>Arriendo del lugar y pago de su infraestructura y servicios: <strong>alojamiento, aseo, energ&iacute;a el&eacute;ctrica, instalaciones sanitarias, m&oacute;dulos o pabellones, comunicaciones, piscina, cocina, agua potable, gas,<\/strong> entre otros.<\/li><li>Gastos en servicio de apoyo al campamento: infraestructura adicional, instalaciones de salud, arriendo de cabinas sanitarias y duchas de refuerzo, aseo extra de cabinas sanitarias, instalaci&oacute;n de sombras (toldos, mallas y carpas), equipamiento de seguridad y prevenci&oacute;n de riesgos, comunicaciones internas, remuneraciones de personal t&eacute;cnico (gasf&iacute;ter, electricista, choferes, entre otros), transporte interno, materiales para mantenci&oacute;n de infraestructura.<\/li><li>Adquisici&oacute;n o arriendo de materiales y equipos de programa: m&oacute;dulos, talleres, stands y Vida de Subcampo.<\/li><li>Contribuci&oacute;n al financiamiento de la alimentaci&oacute;n para los equipos de voluntarios en servicio.<\/li><\/ol><p>&nbsp;<\/p>")),
            ContentElement(
                imageConf: ImageConf(
                    source: "assets/img/mowgli.gif",
                    align: "right",
                    backgroundColor: [255, 0, 0, 1])),
            ContentElement(
                paragraphConf: ParagraphConf(backgroundColor: [
              210,
              177,
              19
            ], textColor: [
              0,
              0,
              0
            ], data: "<h1>El Equipo Organizador del 10&deg; Jamboree Nacional y su estructura organizacional<\/h1><p><br \/>El Jamboree contar&aacute; con una organizaci&oacute;n y estructura apropiada que permita el logro de los objetivos del evento. La conformaci&oacute;n del Equipo de Campo es la siguiente:<\/p><p><br \/>Responsable de Campo: Juan Pablo Reyes<br \/>Asistente de Campo: Daniela Pardo<br \/>Responsable de Programa: Juan Pablo Menichetti<br \/>Responsable de Vida de Subcampo: Carolina Avalos<br \/>Responsable de Servicios: Juan Jos&eacute; Polanco<br \/>Representante del Comit&eacute; Ejecutivo Nacional: Patricio Criado<br \/>Un observador del Consejo Nacional<\/p><p>&nbsp;<\/p><h2>Las cuotas de participaci&oacute;n en el 10&deg; Jamboree<\/h2><p><br \/>Las cuotas fueron establecidas sobre la base de los siguientes criterios:<\/p><ol style=\"list-style-type: lower-alpha;\"><li>Ajuste seg&uacute;n las cuotas consideradas para la Aventura Nacional 2019.<\/li><li>Distancia del lugar de procedencia en relaci&oacute;n con el lugar del 10&deg; Jamboree Nacional.<\/li><li>Categorizaci&oacute;n de Registro de los Grupos.<\/li><li>Diferenciaci&oacute;n seg&uacute;n tipo de asistente: Gu&iacute;as y Scouts; Guiadoras y Dirigentes acompa&ntilde;antes a cargo de las Unidades; Guiadoras, Dirigentes, Pioneras, Pioneros y Caminante que integrar&aacute;n los equipos de voluntarios en servicio.<\/li><\/ol><p>&nbsp;<\/p><h3>&iquest;Qu&eacute; comprenden las cuotas?<\/h3><p>&nbsp;<\/p><ol><li>Arriendo del lugar y pago de su infraestructura y servicios: <strong>alojamiento, aseo, energ&iacute;a el&eacute;ctrica, instalaciones sanitarias, m&oacute;dulos o pabellones, comunicaciones, piscina, cocina, agua potable, gas,<\/strong> entre otros.<\/li><li>Gastos en servicio de apoyo al campamento: infraestructura adicional, instalaciones de salud, arriendo de cabinas sanitarias y duchas de refuerzo, aseo extra de cabinas sanitarias, instalaci&oacute;n de sombras (toldos, mallas y carpas), equipamiento de seguridad y prevenci&oacute;n de riesgos, comunicaciones internas, remuneraciones de personal t&eacute;cnico (gasf&iacute;ter, electricista, choferes, entre otros), transporte interno, materiales para mantenci&oacute;n de infraestructura.<\/li><li>Adquisici&oacute;n o arriendo de materiales y equipos de programa: m&oacute;dulos, talleres, stands y Vida de Subcampo.<\/li><li>Contribuci&oacute;n al financiamiento de la alimentaci&oacute;n para los equipos de voluntarios en servicio.<\/li><\/ol><p>&nbsp;<\/p>"))
          ],
        ),
      ]),
];

 */

final List<Carrousel> _listCarrousel = [
  new Carrousel(
      order: 1,  image: "https://picsum.photos/id/1/400/180"),
  new Carrousel(
      order: 2,  image: "https://picsum.photos/id/2/400/180"),
  new Carrousel(
      order: 3,  image: "https://picsum.photos/id/3/400/180"),
];

final List<String> _listHistory = [
  "jamboree",
  "donde",
  "cuando",
  "porque",
  "que",
  "para",
  "quiero",
  "hacer",
  "lo",
  "haciendo",
  "fechas"
];

List<Content> getExampleContent() {
  return _listContent;
}

List<Content> getExampleRootContent() {
  return _listContent.where((i) => i.root!=null && i.root==true).toList();;
}

List<Content> getExampleSearchContent(String search) {
  return _listContent.where((i) => i.search!=null && i.search.contains(search.toLowerCase())).toList();
}


List<Carrousel> getExampleCarrousel() {
  return _listCarrousel;
}

List<String> getExampleHistory() {
  return _listHistory;
}

Content findExampleContent(String id){
  return _listContent.singleWhere((e)=> e.id==id);
}


Future<bool> loadContentAsset() async {
  print('cargando contenido');
  String jsondata= await rootBundle.loadString('assets/json/data_jme.json');
  var jStringList = json.decode(jsondata);
 // print('lista con ${jStringList.length} items');
  for (int u =0; u < jStringList.length ; u++ ) {
  //  print('******* cargando: \n  ${jStringList[u]} \n');

   // print('iniciando decodificacion');
    //var decode = json.decode();
    //print ('******* decode: \n $decode');

    Content content=Content.fromMap(jStringList[u]);
    _listContent.add(content);

  }
  print('Finalizo la carga del contenido');
  return true;
}

Future<bool> loadContentUrl() async {
  try {
    bool connected=false;
    try {
      final result = await InternetAddress.lookup("jamboree.cl");
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected to parlamento.jamboree.cl');
        connected=!connected;
      }
    } on SocketException catch (_) {
      print('not connected to parlamento.jamboree.cl');
    }
    if(connected) {
      final response = await http.get(
          'http://parlamento.jamboree.cl/data_jme.json');
      if (response.statusCode == 200) {
        print(
            "Se encontro archivo en parlamento.jamboree.cl con informacion de actualizacion");
        print(response.body);
        var jStringList = json.decode(response.body);
        // print('lista con ${jStringList.length} items');
        for (int u =0; u < jStringList.length ; u++ ) {
          //  print('******* cargando: \n  ${jStringList[u]} \n');

          // print('iniciando decodificacion');
          //var decode = json.decode();
          //print ('******* decode: \n $decode');

          Content content=Content.fromMap(jStringList[u]);
          _listContent.add(content);

        }
        print('Finalizo la carga del contenido');
      }
    }
  } catch (e) {
    print('Error al recibir archivo con informacion de actualizacion');
  }
  return null;
}

