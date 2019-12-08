# Pasaporte Jamboree 2020 Chile.

Pasaporte Jamboree 2020 Chile

## Introducción.

Este proyecto permite publicar información para el Jamboree 2020 en Chile, reemplazara al documento que se entregaba en versiones anteriores


## Herramientas
Creacion de Tema para flutter
https://rxlabz.github.io/panache  


## Json para definir contenido del tipo lista
```
"list_conf":{
    "backgroundColor":[255,255,255],
    "textColor":[255,255,255],
    "fontSize":13.0,  
    "fontFamily": "Arial",
    "items":
    [
    {
        "backgroundColor":[255,255,255],
        "image": "http://www.gooogle.cl",
        "title": "titulo",
        "titleColor":[255,255,255],
        "titleFontSize": 13.0,
        "titleFontFamiy": "Arial",
        "subtitle":"subtitulo",
        "subtitleColor":[255,255,255],
        "subtitleFontSize": 13.0,
        "subtitleFontFamiy": "Arial"
    },
    {
        "image": "http://www.gooogle.cl",
        "title": "titulo",
        "subtitle":"subtitulo"
    }    
 ]
    
}
```

## Json para definir contenido del tipo linea de tiempo
```
"time_line_conf": {
    "textColor": [255,0,255],
    "fontSize": 13.0,
    "fontFamily": "Arial",
    "linePosition": "left",
    "lineColor": [251,0,0],
    "lines": [
        {
            "position": "left",
            "backgroundColor": [0,255,255],
            "image": "https://picsum.photos/id/23/100/100",
            "title": "Inicio Jornada",
            "titleColor": [0,0,0],
            "titleFontSize": 13.0,
            "titleFontFamily": "Arial",
            "time": "08:30",
            "timeColor": [0,100,0],
            "timeFontSize": 10.0,
            "timeFontFamily": "Montserrat"
        },
        {
            "position": "right",
            "image": "https://picsum.photos/id/237/100/100",
            "title": "Almuerzo con cada patrulla para recuperar energias",
            "time": "13:30"
        },
        {
            "position": "left",
            "title": "Almuerzo con todos los integrantes del jamboree",
            "time": "13:30"
        },
        {
            "position": "left",
            "title": "Jugar en la piscina",
            "time": "13:30"
        }
    ]
}
```
## Json para definir contenido del tipo imagen
```
{
    "image_conf":
        {
            "source":"http://parlamento.jamboree.cl/pp.jpg",
            "align":"center",
            "background_color":[255,255,255],
            "ownViewer": true   #true, evento ontap despliega ventana para hacer zoom a la imagen
        } 
}

```
## Json para definir contenido del tipo imagen


Las imagenes deben estar contenidas en el proyecto, google map, no soporta imagenes desde una url, solamente directo del directorio assets.

```
[{
  "id":"1",
  "nombre":"Almacén",
  "latitud":-32.912553,
  "longitud":-71.494323,
  "imagen": "assets/img/locations/shopping-128.png"
},
  {
    "id":"2",
    "nombre":"Hospital",
    "latitud":-32.913463,
    "longitud":-71.496061,
    "imagen": "assets/img/locations/medical.png"
  },
  {
    "id":"3",
    "nombre":"Centro Operación",
    "latitud":-32.922462,
    "longitud":-71.506968,
    "imagen": "assets/img/locations/scout.png"
  },
  {
    "id":"4",
    "nombre":"Policía",
    "latitud":-32.920012,
    "longitud":-71.509200,
    "imagen": "assets/img/locations/police.png"
  }
]
```