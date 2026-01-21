import 'package:flowers_app/Features/profile/data/models/profile_dto.dart';
import 'package:flowers_app/Features/profile/domain/entities/user_entity.dart';

extension ProfileMapper on ProfileDto {
  UserEntity toEntity() {
    final userData = user;

    return UserEntity(
      id: userData?.id ?? '',
      firstName: userData?.firstName ?? '',
      lastName: userData?.lastName ?? '',
      email: userData?.email ?? '',
      phone: userData?.phone ?? '',
      photoUrl: userData?.photo ?? '',
      role: userData?.role ?? 'user',
      gender: userData?.gender ?? '',
    );
  }
}
