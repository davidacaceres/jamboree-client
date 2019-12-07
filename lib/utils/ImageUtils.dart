import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

CircleAvatar getAvatar({String urlImage, double radius}) {

  var image;
  try {
    if(urlImage!=null && urlImage.isNotEmpty) {
      image = getImageUrl(urlImage, 40, 40);
    }
  } catch (ex) {
    print(
        "Error al obtener imagen desde url, se utilizara imagen x defecto, error: $ex");

  }
  if(image==null )
    {
      try {
        image = AssetImage('assets/img/asociacion.png');
      }catch(ex)
  {
    print('Error al obtener imagen x defecto $ex [assets/img/asociacion.png]');
  }
    }

  return CircleAvatar(
    radius: radius,
    backgroundImage: image,
    backgroundColor: Colors.transparent,
  );
}

CircleAvatar getAvatarImg({ImageProvider imgProvider, double radius}) {
  return CircleAvatar(
    radius: radius,
    backgroundImage: imgProvider,
    backgroundColor: Colors.transparent,
  );
}

CachedNetworkImage getImage(int index) {
  return CachedNetworkImage(
    imageUrl: "https://picsum.photos/id/$index/400/180",
    placeholder: (context, url) => Icon(Icons.cloud_download),
    errorWidget: (context, url, error) => Icon(Icons.error),
  );
}

CachedNetworkImage getImageUrl(String url, double width, double height) {
  print('obteniendo imagen: $url');
  return CachedNetworkImage(
    imageUrl: url,
 //   placeholder: (context, url) => Icon(Icons.cloud_download),
    errorWidget: (context, url, error) => Image.asset("assets/img/asociacion_mini.png"),
    width: width,
    height: height,
  );
}

ImageProvider getImageProvider({@required String url}){
  ImageProvider image;
  try {
    if (url != null &&
        url.isNotEmpty &&
        (url.startsWith("http://") || url.startsWith("https://"))) {
        image = CachedNetworkImageProvider(url);
    } else if (url != null && url.isNotEmpty && url.startsWith("assets")) {
      image = AssetImage(url);
    } else {
      image = AssetImage("assets/img/asociacion.png");
    }
  } catch (ex) {
    print('error al obtener imagen $url');
    image = AssetImage("assets/img/asociacion.png");
  }
  return image;
}

Image getImageContent({@required String url, @optionalTypeArgs BoxFit fit}) {
  print('obteniendo imagen: $url');
  Image imagen;
  try {
    if (url != null &&
        url.isNotEmpty &&
        (url.startsWith("http://") || url.startsWith("https://"))) {
      if (fit != null) {
        imagen = Image(
          image: CachedNetworkImageProvider(url),
          fit: fit,
        );
      }
      imagen = Image(image: CachedNetworkImageProvider(url));
    } else if (url != null && url.isNotEmpty && url.startsWith("assets")) {
      if (fit != null) {
        imagen = Image.asset(url, fit: fit);
      }
      imagen = Image.asset(url);
    } else {
      imagen = Image.asset("assets/img/asociacion.png");
    }
  } catch (ex) {
    print('error al obtener imagen $url');
    imagen = Image.asset("assets/img/asociacion.png");
  }
  return imagen;
}

Image getIconGoogleMap(
    {@required String url, @required double width, @required double height}) {
  print('obteniendo imagen: $url');
  Image imagen;
  try {
    if (url != null &&
        url.isNotEmpty &&
        (url.startsWith("http://") || url.startsWith("https://"))) {
      imagen = Image(
          image: CachedNetworkImageProvider(url), width: width, height: height);
    } else if (url != null && url.isNotEmpty && url.startsWith("assets")) {
      imagen = Image.asset(
        url,
        width: width,
        height: height,
      );
    } else {
      imagen = Image.asset("assets/img/asociacion.png",
          width: width, height: height);
    }
  } catch (ex) {
    print('error al obtener imagen $url');
    imagen =
        Image.asset("assets/img/asociacion.png", width: width, height: height);
  }
  return imagen;
}



ImageProvider getImageCarousel({@required String url}) {
  print('obteniendo imagen: $url');
  ImageProvider imagen;
  try {
    if (url != null &&
        url.isNotEmpty &&
        (url.startsWith("http://") || url.startsWith("https://"))) {
        imagen = CachedNetworkImageProvider(url);
    } else if (url != null && url.isNotEmpty && url.startsWith("assets")) {
      imagen = ExactAssetImage(url);
    } else {
      imagen = ExactAssetImage("assets/img/asociacion.png");
    }
  } catch (ex) {
    print('error al obtener imagen $url');
    imagen = ExactAssetImage("assets/img/asociacion.png");
  }
  return imagen;
}

Image getImageItem({@required String url,@required double h,double w}) {
  print('obteniendo imagen: $url');
  Image imagen;
  try {
    if (url != null &&
        url.isNotEmpty &&
        (url.startsWith("http://") || url.startsWith("https://"))) {
      imagen = Image(
          image: CachedNetworkImageProvider(url), width: w, height: h);
    } else if (url != null && url.isNotEmpty && url.startsWith("assets")) {
      imagen = Image.asset(url,width: w,height: h,);
    } else {
      imagen = Image.asset(url,width: w,height: h,);
    }
  } catch (ex) {
    print('error al obtener imagen $url');
    return null;
  }
  return imagen;
}

