resource "genesyscloud_integration_action" "action" {
    name           = var.action_name
    category       = var.action_category
    integration_id = var.integration_id
    secure         = var.secure_data_action
    
    contract_input  = jsonencode({
        "$schema": "http://json-schema.org/draft-04/schema#",
        "additionalProperties": true,
        "description": "A object ID-based request.",
        "properties": {
            "Object_Field_Name": {
                "description": "The Salesforce Object field API name to update",
                "type": "string"
            },
            "Object_Field_Value": {
                "description": "The value to update the Object field.",
                "type": "string"
            },
            "Object_SF_ID": {
                "description": "The SF internal Object ID to update ",
                "type": "string"
            },
            "Object_SF_Type": {
                "description": "The SF Object type to update",
                "type": "string"
            }
        },
        "required": [
            "Object_Field_Name",
            "Object_Field_Value",
            "Object_SF_ID",
            "Object_SF_Type"
        ],
        "title": "Object ID Request",
        "type": "object"
    })
    contract_output = jsonencode({
        "additionalProperties": true,
        "properties": {},
        "type": "object"
    })
    
    config_request {
        request_template     = "{\"$${input.Object_Field_Name}\": \"$${input.Object_Field_Value}\"}"
        request_type         = "PATCH"
        request_url_template = "/services/data/v54.0/sobjects/$salesforce.escReserved($${input.Object_SF_Type})/$salesforce.escReserved($${input.Object_SF_ID})"
        headers = {
			UserAgent = "PureCloudIntegrations/1.0"
		}
    }

    config_response {
        success_template = "$${rawResult}"
         
               
    }
}