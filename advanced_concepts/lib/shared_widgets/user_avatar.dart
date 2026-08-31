import 'package:advanced_concepts/features/user_list/domain/entities/user.dart';
import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({required this.user, this.radius = 20, super.key});

  final User user;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final image = _imageProvider(user.imageUrl);
    final size = radius * 2;

    if (image == null) {
      return CircleAvatar(
        radius: radius,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        child: Text(
          user.nickname.characters.first,
          style: radius > 32
              ? Theme.of(context).textTheme.headlineMedium
              : Theme.of(context).textTheme.titleMedium,
        ),
      );
    }

    return ClipOval(
      child: SizedBox(
        width: size,
        height: size,
        child: Image(image: image, fit: BoxFit.cover),
      ),
    );
  }
}

ImageProvider? _imageProvider(String imageUrl) {
  if (imageUrl.isEmpty) return null;
  if (imageUrl.startsWith('http://') || imageUrl.startsWith('https://')) {
    return NetworkImage(imageUrl);
  }
  return AssetImage(imageUrl);
}
