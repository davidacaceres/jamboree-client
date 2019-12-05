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
"list_conf":{
    "date":"2020-01-05",
    "textColor":[255,255,255],
    "fontSize":13.0,
    "fontFamily": "Arial",
    "line":
    [
        {
            "backgroundColor":[255,255,255],
            "image": "http://www.gooogle.cl",
            "title": "titulo",
            "titleColor":[255,255,255],
            "titleFontSize": 13.2,
            "titleFontFamiy": "Arial",
            "time":"",
            "timeColor":[255,255,255],
            "timeFontSize": 13.2,
            "timeFontFamily": "Arial"
        },
        {
            "image": "http://www.gooogle.cl",
            "title": "titulo",
            "time":"subtitulo"
        }    
     ]   
}
