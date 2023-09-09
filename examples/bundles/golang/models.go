// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse and unparse this JSON data, add this code to your project and do:
//
//    models, err := UnmarshalModels(bytes)
//    bytes, err = models.Marshal()

package models

import "encoding/json"

func UnmarshalModels(data []byte) (Models, error) {
	var r Models
	err := json.Unmarshal(data, &r)
	return r, err
}

func (r *Models) Marshal() ([]byte, error) {
	return json.Marshal(r)
}

// Schema definitions
type Models struct {
	CommonErrorResponse  *CommonErrorResponse  `json:"common-error-response,omitempty"`
	V1EnumOrderStatus    *V1EnumOrderStatus    `json:"v1-enum-order-status,omitempty"`
	V1ObjectOrder        *V1ObjectOrder        `json:"v1-object-order,omitempty"`
	V1ObjectUser         *V1ObjectUser         `json:"v1-object-user,omitempty"`
	V1OrdersShowResponse *V1OrdersShowResponse `json:"v1-orders-show-response,omitempty"`
}

// Error object response
type CommonErrorResponse struct {
	// error object                   
	Error                      Error  `json:"error"`
	// The summary reason error       
	ErrorSummary               string `json:"error_summary"`
}

// error object
type Error struct {
	// The code of the error object           
	Code                               string `json:"code"`
	// The message of the error object        
	Message                            string `json:"message"`
	// The request id                         
	RequestID                          string `json:"requestId"`
	// The resource of the error object       
	Resource                           string `json:"resource"`
}

// Order info object
//
// The object of order information
type V1ObjectOrder struct {
	// The id of order                           
	ID                        string             `json:"id"`
	// The price of the order                    
	Price                     string             `json:"price"`
	// The id of product                         
	ProductID                 string             `json:"productId"`
	// The status of the order                   
	Status                    *V1EnumOrderStatus `json:"status,omitempty"`
	// The id of user                            
	UserID                    string             `json:"userId"`
}

// User info object
//
// The object of user
type V1ObjectUser struct {
	// email-ex@example.com         
	Email                  string   `json:"email"`
	// User full name               
	FullName               string   `json:"fullName"`
	// User name                    
	Name                   string   `json:"name"`
	// User phone-numbers           
	PhoneNumbers           []string `json:"phoneNumbers"`
}

// Definition of show order response.
type V1OrdersShowResponse struct {
	// The object of order information              
	Order                             V1ObjectOrder `json:"order"`
	// The object of user                           
	User                              V1ObjectUser  `json:"user"`
}

// Enum of order
//
// The status of the order
type V1EnumOrderStatus string

const (
	Completed V1EnumOrderStatus = "completed"
	Confirmed V1EnumOrderStatus = "confirmed"
	Pending   V1EnumOrderStatus = "pending"
)
