
resource "azurerm_resource_group" "mdot-resource-group" 
{
  name     = "${var.resource_group}"
  location = "${var.region_a}"
}



resource "azurerm_traffic_manager_profile" "mdot_tf_profile" 
{
  name                   = "mdot-trafficmanager"
  resource_group_name    = "${azurerm_resource_group.mdot-resource-group.name}"
  traffic_routing_method = "Weighted"

  dns_config 
  {
    relative_name = "${azurerm_resource_group.mdot-resource-group.name}"
    ttl           = 30
  }

  monitor_config 
  {
    protocol = "http"
    port     = 80
    path     = "/"
  }
}

resource "azurerm_virtual_network" "vnet_region_a"
{
	name = "${var.region_a}-vnet"
	resource_group_name = "${azurerm_resource_group.mdot-resource-group.name}"
	address_space = ["${var.address_space_region_a}"]
	location = "${var.region_a}"
}

resource "azurerm_subnet" "subnet_region_a" 
{
	  name                 = "${var.region_a}-subnet"
	  resource_group_name  = "${azurerm_resource_group.mdot-resource-group.name}"
	  virtual_network_name = "${azurerm_virtual_network.vnet_region_a.name}"
	  address_prefix       = "${var.address_space_region_a}"
}


resource "azurerm_application_gateway" "appgateway_region_a"
{
	name = "mdot-testing-${var.region_a}"
	resource_group_name = "${azurerm_resource_group.mdot-resource-group.name}"
	location = "${var.region_a}"
	
	sku 
	{
		name = "${var.appgateway_sku_name}"
		tier = "${var.appgateway_sku_tier}"
		capacity = "${var.appgateway_instance_count}"
	}
	
	gateway_ip_configuration 
	{
		name         = "dot-testing-${var.region_a}-configuration"
		subnet_id    = "${azurerm_virtual_network.vnet_region_a.id}/subnets/${azurerm_subnet.subnet_region_a.name}"
	}
	
	frontend_port 
	{
      name         = "${azurerm_virtual_network.vnet_region_a.name}-feport"
      port         = 80
	}
	
	frontend_ip_configuration {
      name         = "${azurerm_virtual_network.vnet_region_a.name}-feip"  
      subnet_id  = "${azurerm_subnet.subnet_region_a.id}"
  }
	
}
