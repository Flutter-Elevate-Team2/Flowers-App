import 'package:flowers_app/Features/order/data/models/checkout/credit/shared_models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'branding_settings_dto.g.dart';

@JsonSerializable()
class BrandingSettings {
  @JsonKey(name: "background_color")
  final String? backgroundColor;
  @JsonKey(name: "border_style")
  final String? borderStyle;
  @JsonKey(name: "button_color")
  final String? buttonColor;
  @JsonKey(name: "display_name")
  final String? displayName;
  @JsonKey(name: "font_family")
  final String? fontFamily;
  @JsonKey(name: "icon")
  final Icon? icon;
  @JsonKey(name: "logo")
  final Logo? logo;

  BrandingSettings ({
    this.backgroundColor,
    this.borderStyle,
    this.buttonColor,
    this.displayName,
    this.fontFamily,
    this.icon,
    this.logo,
  });

  factory BrandingSettings.fromJson(Map<String, dynamic> json) {
    return _$BrandingSettingsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$BrandingSettingsToJson(this);
  }
}