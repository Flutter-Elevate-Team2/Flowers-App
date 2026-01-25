import 'package:flowers_app/Features/order/data/models/checkout/credit/metadata_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'shared_models.g.dart';


@JsonSerializable()
class AdaptivePricing {
  @JsonKey(name: "enabled")
  final bool? enabled;

  AdaptivePricing ({
    this.enabled,
  });

  factory AdaptivePricing.fromJson(Map<String, dynamic> json) {
    return _$AdaptivePricingFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AdaptivePricingToJson(this);
  }
}

@JsonSerializable()
class AutomaticTax {
  @JsonKey(name: "enabled")
  final bool? enabled;
  @JsonKey(name: "liability")
  final dynamic liability;
  @JsonKey(name: "provider")
  final dynamic provider;
  @JsonKey(name: "status")
  final dynamic status;

  AutomaticTax ({
    this.enabled,
    this.liability,
    this.provider,
    this.status,
  });

  factory AutomaticTax.fromJson(Map<String, dynamic> json) {
    return _$AutomaticTaxFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AutomaticTaxToJson(this);
  }
}

@JsonSerializable()
class CollectedInformation {
  @JsonKey(name: "business_name")
  final dynamic businessName;
  @JsonKey(name: "individual_name")
  final dynamic individualName;
  @JsonKey(name: "shipping_details")
  final dynamic shippingDetails;

  CollectedInformation ({
    this.businessName,
    this.individualName,
    this.shippingDetails,
  });

  factory CollectedInformation.fromJson(Map<String, dynamic> json) {
    return _$CollectedInformationFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CollectedInformationToJson(this);
  }
}

@JsonSerializable()
class CustomText {
  @JsonKey(name: "after_submit")
  final dynamic afterSubmit;
  @JsonKey(name: "shipping_address")
  final dynamic shippingAddress;
  @JsonKey(name: "submit")
  final dynamic submit;
  @JsonKey(name: "terms_of_service_acceptance")
  final dynamic termsOfServiceAcceptance;

  CustomText ({
    this.afterSubmit,
    this.shippingAddress,
    this.submit,
    this.termsOfServiceAcceptance,
  });

  factory CustomText.fromJson(Map<String, dynamic> json) {
    return _$CustomTextFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CustomTextToJson(this);
  }
}

@JsonSerializable()
class InvoiceCreation {
  @JsonKey(name: "enabled")
  final bool? enabled;
  @JsonKey(name: "invoice_data")
  final InvoiceData? invoiceData;

  InvoiceCreation ({
    this.enabled,
    this.invoiceData,
  });

  factory InvoiceCreation.fromJson(Map<String, dynamic> json) {
    return _$InvoiceCreationFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$InvoiceCreationToJson(this);
  }
}

@JsonSerializable()
class InvoiceData {
  @JsonKey(name: "account_tax_ids")
  final dynamic accountTaxIds;
  @JsonKey(name: "custom_fields")
  final dynamic customFields;
  @JsonKey(name: "description")
  final dynamic description;
  @JsonKey(name: "footer")
  final dynamic footer;
  @JsonKey(name: "issuer")
  final dynamic issuer;
  @JsonKey(name: "metadata")
  final Metadata? metadata;
  @JsonKey(name: "rendering_options")
  final dynamic renderingOptions;

  InvoiceData ({
    this.accountTaxIds,
    this.customFields,
    this.description,
    this.footer,
    this.issuer,
    this.metadata,
    this.renderingOptions,
  });

  factory InvoiceData.fromJson(Map<String, dynamic> json) {
    return _$InvoiceDataFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$InvoiceDataToJson(this);
  }
}

@JsonSerializable()
class Icon {
  @JsonKey(name: "file")
  final String? file;
  @JsonKey(name: "type")
  final String? type;

  Icon ({
    this.file,
    this.type,
  });

  factory Icon.fromJson(Map<String, dynamic> json) {
    return _$IconFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$IconToJson(this);
  }
}

@JsonSerializable()
class Logo {
  @JsonKey(name: "file")
  final String? file;
  @JsonKey(name: "type")
  final String? type;

  Logo ({
    this.file,
    this.type,
  });

  factory Logo.fromJson(Map<String, dynamic> json) {
    return _$LogoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$LogoToJson(this);
  }
}

@JsonSerializable()
class PaymentMethodOptions {
  @JsonKey(name: "card")
  final Card? card;

  PaymentMethodOptions ({
    this.card,
  });

  factory PaymentMethodOptions.fromJson(Map<String, dynamic> json) {
    return _$PaymentMethodOptionsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$PaymentMethodOptionsToJson(this);
  }
}

@JsonSerializable()
class Card {
  @JsonKey(name: "request_three_d_secure")
  final String? requestThreeDSecure;

  Card ({
    this.requestThreeDSecure,
  });

  factory Card.fromJson(Map<String, dynamic> json) {
    return _$CardFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CardToJson(this);
  }
}

@JsonSerializable()
class PaymentMethodConfigurationDetails {
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "parent")
  final dynamic parent;

  PaymentMethodConfigurationDetails({
    this.id,
    this.parent,
  });

  factory PaymentMethodConfigurationDetails.fromJson(
      Map<String, dynamic> json) {
    return _$PaymentMethodConfigurationDetailsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$PaymentMethodConfigurationDetailsToJson(this);
  }
}


  @JsonSerializable()
  class PhoneNumberCollection {
  @JsonKey(name: "enabled")
  final bool? enabled;

  PhoneNumberCollection ({
  this.enabled,
  });

  factory PhoneNumberCollection.fromJson(Map<String, dynamic> json) {
  return _$PhoneNumberCollectionFromJson(json);
  }

  Map<String, dynamic> toJson() {
  return _$PhoneNumberCollectionToJson(this);
  }
  }



