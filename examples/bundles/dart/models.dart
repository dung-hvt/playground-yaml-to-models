// To parse this JSON data, do
//
//     final models = modelsFromJson(jsonString);

import 'dart:convert';

Models modelsFromJson(String str) => Models.fromJson(json.decode(str));

String modelsToJson(Models data) => json.encode(data.toJson());


///Schema definitions
class Models {
    CommonErrorResponse? commonErrorResponse;
    V1EnumOrderStatus? v1EnumOrderStatus;
    V1ObjectOrder? v1ObjectOrder;
    V1ObjectUser? v1ObjectUser;
    V1OrdersShowResponse? v1OrdersShowResponse;

    Models({
        this.commonErrorResponse,
        this.v1EnumOrderStatus,
        this.v1ObjectOrder,
        this.v1ObjectUser,
        this.v1OrdersShowResponse,
    });

    factory Models.fromJson(Map<String, dynamic> json) => Models(
        commonErrorResponse: json["common-error-response"] == null ? null : CommonErrorResponse.fromJson(json["common-error-response"]),
        v1EnumOrderStatus: v1EnumOrderStatusValues.map[json["v1-enum-order-status"]]!,
        v1ObjectOrder: json["v1-object-order"] == null ? null : V1ObjectOrder.fromJson(json["v1-object-order"]),
        v1ObjectUser: json["v1-object-user"] == null ? null : V1ObjectUser.fromJson(json["v1-object-user"]),
        v1OrdersShowResponse: json["v1-orders-show-response"] == null ? null : V1OrdersShowResponse.fromJson(json["v1-orders-show-response"]),
    );

    Map<String, dynamic> toJson() => {
        "common-error-response": commonErrorResponse?.toJson(),
        "v1-enum-order-status": v1EnumOrderStatusValues.reverse[v1EnumOrderStatus],
        "v1-object-order": v1ObjectOrder?.toJson(),
        "v1-object-user": v1ObjectUser?.toJson(),
        "v1-orders-show-response": v1OrdersShowResponse?.toJson(),
    };
}


///Error object response
class CommonErrorResponse {
    
    ///error object
    Error error;
    
    ///The summary reason error
    String errorSummary;

    CommonErrorResponse({
        required this.error,
        required this.errorSummary,
    });

    factory CommonErrorResponse.fromJson(Map<String, dynamic> json) => CommonErrorResponse(
        error: Error.fromJson(json["error"]),
        errorSummary: json["error_summary"],
    );

    Map<String, dynamic> toJson() => {
        "error": error.toJson(),
        "error_summary": errorSummary,
    };
}


///error object
class Error {
    
    ///The code of the error object
    String code;
    
    ///The message of the error object
    String message;
    
    ///The request id
    String requestId;
    
    ///The resource of the error object
    String resource;

    Error({
        required this.code,
        required this.message,
        required this.requestId,
        required this.resource,
    });

    factory Error.fromJson(Map<String, dynamic> json) => Error(
        code: json["code"],
        message: json["message"],
        requestId: json["requestId"],
        resource: json["resource"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "requestId": requestId,
        "resource": resource,
    };
}


///Enum of order
///
///The status of the order
enum V1EnumOrderStatus {
    COMPLETED,
    CONFIRMED,
    PENDING
}

final v1EnumOrderStatusValues = EnumValues({
    "completed": V1EnumOrderStatus.COMPLETED,
    "confirmed": V1EnumOrderStatus.CONFIRMED,
    "pending": V1EnumOrderStatus.PENDING
});


///Order info object
///
///The object of order information
class V1ObjectOrder {
    
    ///The id of order
    String id;
    
    ///The price of the order
    String price;
    
    ///The id of product
    String productId;
    
    ///The status of the order
    V1EnumOrderStatus? status;
    
    ///The id of user
    String userId;

    V1ObjectOrder({
        required this.id,
        required this.price,
        required this.productId,
        this.status,
        required this.userId,
    });

    factory V1ObjectOrder.fromJson(Map<String, dynamic> json) => V1ObjectOrder(
        id: json["id"],
        price: json["price"],
        productId: json["productId"],
        status: v1EnumOrderStatusValues.map[json["status"]]!,
        userId: json["userId"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "price": price,
        "productId": productId,
        "status": v1EnumOrderStatusValues.reverse[status],
        "userId": userId,
    };
}


///User info object
///
///The object of user
class V1ObjectUser {
    
    ///email-ex@example.com
    String email;
    
    ///User full name
    String fullName;
    
    ///User name
    String name;
    
    ///User phone-numbers
    List<String> phoneNumbers;

    V1ObjectUser({
        required this.email,
        required this.fullName,
        required this.name,
        required this.phoneNumbers,
    });

    factory V1ObjectUser.fromJson(Map<String, dynamic> json) => V1ObjectUser(
        email: json["email"],
        fullName: json["fullName"],
        name: json["name"],
        phoneNumbers: List<String>.from(json["phoneNumbers"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "fullName": fullName,
        "name": name,
        "phoneNumbers": List<dynamic>.from(phoneNumbers.map((x) => x)),
    };
}


///Definition of show order response.
class V1OrdersShowResponse {
    
    ///The object of order information
    V1ObjectOrder order;
    
    ///The object of user
    V1ObjectUser user;

    V1OrdersShowResponse({
        required this.order,
        required this.user,
    });

    factory V1OrdersShowResponse.fromJson(Map<String, dynamic> json) => V1OrdersShowResponse(
        order: V1ObjectOrder.fromJson(json["order"]),
        user: V1ObjectUser.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "order": order.toJson(),
        "user": user.toJson(),
    };
}

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
