import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

CircleAvatar getAvatar({String urlImage, double radius}) {
  ImageProvider image;
  try {
    image = NetworkImage(urlImage);
  } catch (ex) {
    print(
        "Error al obtener imagen desde url, se utilizara imagen x defecto, error: $ex");
    image = AssetImage('assets/img/logo_asoc_chile.png');
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
  return CachedNetworkImage(
    imageUrl: url,
    placeholder: (context, url) => Icon(Icons.cloud_download),
    errorWidget: (context, url, error) => Icon(Icons.error),
    width: width,
    height: height,
  );
}

Image getImageContent({@required String url, @optionalTypeArgs BoxFit fit}) {
  if (url != null &&
      url.isNotEmpty &&
      (url.startsWith("http://") || url.startsWith("https://"))) {
    if (fit != null) {
      return Image(image:CachedNetworkImageProvider(url),fit: fit,);
    }
    return Image(image:CachedNetworkImageProvider(url));

  } else if (url != null && url.isNotEmpty && url.startsWith("assets")) {
    if (fit != null) {
      return Image.asset(url,fit: fit);
    }
    return Image.asset(url);
  } else {
    return Image.asset("assets/img/asociacion.png");
  }
}
