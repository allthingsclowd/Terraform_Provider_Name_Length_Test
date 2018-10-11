package main

import (
        "github.com/hashicorp/terraform/helper/schema"
)

func Provider() *schema.Provider {
	return &schema.Provider{
			ResourcesMap: map[string]*schema.Resource{
					"example-with-a-really-long-name_server": resourceServer(),
			},
	}
}
