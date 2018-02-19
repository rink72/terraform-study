variable "resource_group"
{
	description = "Resource group to deploy components in to."
	default = "mdot-demo"
}

variable "region_a"
{
	description = "First region to deploy components in to."
	default = "canadaeast"
}

variable "address_space_region_a"
{
	default = "10.0.0.0/24"
}

variable "region_b"
{
	description = "Second region to deploy components in to."
	default = "canadacentral"
}


variable traffic_manager_name
{
	description = "The name of traffic manager."
	default = "samb72mdotdemo"
}

variable appservice_sku
{
	description = "The SKU size of the mdot service to deploy"
	default = "SHARED"
}

variable appservice_count
{
	description = "The number of app service servers to deploy"
	default = "1"
}

variable appgateway_sku_name
{
	description = "The SKU size of the application gateway service to deploy"
	default = "Standard_Small"
}

variable appgateway_sku_tier
{
	description = "The SKU size of the application gateway service to deploy"
	default = "Standard"
}

variable appgateway_instance_count
{
	description = "The number of app gateways instances to deploy"
	default = "1"
}


