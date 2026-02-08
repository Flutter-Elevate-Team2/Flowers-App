import 'package:json_annotation/json_annotation.dart';

part 'about_model.g.dart';

@JsonSerializable()
class AboutModel {
  @JsonKey(name: "about_app")
  final List<AboutApp>? aboutApp;

  AboutModel ({
    this.aboutApp,
  });

  factory AboutModel.fromJson(Map<String, dynamic> json) {
    return _$AboutModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AboutModelToJson(this);
  }
}

@JsonSerializable()
class AboutApp {
  @JsonKey(name: "section")
  final String? section;
  @JsonKey(name: "content")
  final Content? content;
  @JsonKey(name: "style")
  final Style? style;

  AboutApp ({
    this.section,
    this.content,
    this.style,
  });

  factory AboutApp.fromJson(Map<String, dynamic> json) {
    return _$AboutAppFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AboutAppToJson(this);
  }
}

@JsonSerializable()
class Content {
  @JsonKey(name: "en")
  final String? en;
  @JsonKey(name: "ar")
  final String? ar;

  Content ({
    this.en,
    this.ar,
  });

  factory Content.fromJson(Map<String, dynamic> json) {
    return _$ContentFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ContentToJson(this);
  }
}

@JsonSerializable()
class Style {
  @JsonKey(name: "fontSize")
  final int? fontSize;
  @JsonKey(name: "fontWeight")
  final String? fontWeight;
  @JsonKey(name: "color")
  final String? color;
  @JsonKey(name: "textAlign")
  final TextAlign? textAlign;
  @JsonKey(name: "backgroundColor")
  final String? backgroundColor;

  Style ({
    this.fontSize,
    this.fontWeight,
    this.color,
    this.textAlign,
    this.backgroundColor,
  });

  factory Style.fromJson(Map<String, dynamic> json) {
    return _$StyleFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$StyleToJson(this);
  }
}

@JsonSerializable()
class TextAlign {
  @JsonKey(name: "en")
  final String? en;
  @JsonKey(name: "ar")
  final String? ar;

  TextAlign ({
    this.en,
    this.ar,
  });

  factory TextAlign.fromJson(Map<String, dynamic> json) {
    return _$TextAlignFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$TextAlignToJson(this);
  }
}


