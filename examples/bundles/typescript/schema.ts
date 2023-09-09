/**
 * Schema definitions
 */
export interface Schema {
    "common-error-response"?:   CommonErrorResponse;
    "v1-enum-order-status"?:    V1EnumOrderStatus;
    "v1-object-order"?:         V1ObjectOrder;
    "v1-object-user"?:          V1ObjectUser;
    "v1-orders-show-response"?: V1OrdersShowResponse;
    [property: string]: any;
}

/**
 * Error object response
 */
export interface CommonErrorResponse {
    /**
     * error object
     */
    error: Error;
    /**
     * The summary reason error
     */
    error_summary: string;
    [property: string]: any;
}

/**
 * error object
 */
export interface Error {
    /**
     * The code of the error object
     */
    code: string;
    /**
     * The message of the error object
     */
    message: string;
    /**
     * The request id
     */
    requestId: string;
    /**
     * The resource of the error object
     */
    resource: string;
    [property: string]: any;
}

/**
 * Enum of order
 *
 * The status of the order
 */
export enum V1EnumOrderStatus {
    Completed = "completed",
    Confirmed = "confirmed",
    Pending = "pending",
}

/**
 * Order info object
 *
 * The object of order information
 */
export interface V1ObjectOrder {
    /**
     * The id of order
     */
    id: string;
    /**
     * The price of the order
     */
    price: string;
    /**
     * The id of product
     */
    productId: string;
    /**
     * The status of the order
     */
    status?: V1EnumOrderStatus;
    /**
     * The id of user
     */
    userId: string;
    [property: string]: any;
}

/**
 * User info object
 *
 * The object of user
 */
export interface V1ObjectUser {
    /**
     * email-ex@example.com
     */
    email: string;
    /**
     * User full name
     */
    fullName: string;
    /**
     * User name
     */
    name: string;
    /**
     * User phone-numbers
     */
    phoneNumbers: string[];
    [property: string]: any;
}

/**
 * Definition of show order response.
 */
export interface V1OrdersShowResponse {
    /**
     * The object of order information
     */
    order: V1ObjectOrder;
    /**
     * The object of user
     */
    user: V1ObjectUser;
    [property: string]: any;
}
