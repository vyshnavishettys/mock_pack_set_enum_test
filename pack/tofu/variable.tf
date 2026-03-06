#  Copyright (c) Juniper Networks, Inc., 2025-2025.
#  All rights reserved.
#  SPDX-License-Identifier: MIT

variable "blueprint_id" {
  type = string
}

variable "name" {
  type = string
  description = <<-EOF
    {
      "description": "Name of the configlet and property set",
      "display_name": "Name"
    }
  EOF
}

variable "configlet_scope" {
  type = string
  description = <<-EOF
    {
      "description": "Scope condition for the configlet",
      "display_name": "Configlet Scope"
    }
  EOF
}

variable "radius_servers" {
  type = list(string)
  default = []
  description = <<-EOF
    {
      "description": "List of RADIUS server IP addresses",
      "display_name": "RADIUS Servers"
    }
  EOF
}

variable "management_nets" {
  type = list(string)
  default = []
  description = <<-EOF
    {
      "description": "List of management network IP addresses",
      "display_name": "Management Networks"
    }
  EOF
}

variable "apstra_ip" {
  type = string
  description = <<-EOF
    {
      "description": "Apstra server IP address",
      "display_name": "Apstra Server IP"
    }
  EOF
}

variable "pack_name" {
  type = string
  description = <<-EOF
    {
      "description": "Name of the content pack",
      "display_name": "Pack Name"
    }
  EOF
}

variable "pack_description" {
  type = string
  description = <<-EOF
    {
      "description": "Description of the content pack",
      "display_name": "Pack Description"
    }
  EOF
}

variable "allowed_protocols" {
  type = set(string)
  description = <<-EOF
    {
      "description": "Set of allowed network protocols",
      "display_name": "Allowed Protocols",
      "validators": [
        {
          "type": "set_item_string_validators",
          "args": {
            "validators": [
              {
                "type": "string_enum",
                "args": {
                  "values": ["tcp", "udp", "icmp", "sctp"]
                },
                "error": "Protocol must be one of: tcp, udp, icmp, sctp"
              }
            ]
          },
          "error": "Invalid protocol in set"
        }
      ]
    }
  EOF
}

variable "device_roles" {
  type = set(string)
  description = <<-EOF
    {
      "description": "Set of device roles in the network",
      "display_name": "Device Roles",
      "validators": [
        {
          "type": "set_item_string_validators",
          "args": {
            "validators": [
              {
                "type": "string_enum",
                "args": {
                  "values": ["spine", "leaf", "border", "server", "access"]
                },
                "error": "Device role must be one of: spine, leaf, border, server, access"
              }
            ]
          },
          "error": "Invalid device role"
        }
      ]
    }
  EOF
}

variable "log_level" {
  type = string
  description = <<-EOF
    {
      "description": "Logging level for the application",
      "display_name": "Log Level",
      "validators": [
        {
          "type": "string_enum",
          "args": {
            "values": ["debug", "info", "warning", "error", "critical"]
          },
          "error": "Log level must be one of: debug, info, warning, error, critical"
        }
      ]
    }
  EOF
}

variable "environment" {
  type = string
  description = <<-EOF
    {
      "description": "Deployment environment",
      "display_name": "Environment",
      "validators": [
        {
          "type": "string_enum",
          "args": {
            "values": ["development", "staging", "production"]
          },
          "error": "Environment must be one of: development, staging, production"
        }
      ]
    }
  EOF
}

variable "supported_features" {
  type = list(string)
  description = <<-EOF
    {
      "description": "List of supported features",
      "display_name": "Supported Features",
      "validators": [
        {
          "type": "set_item_string_validators",
          "args": {
            "validators": [
              {
                "type": "string_enum",
                "args": {
                  "values": ["bgp", "ospf", "evpn", "vxlan", "mpls"]
                },
                "error": "Feature must be one of: bgp, ospf, evpn, vxlan, mpls"
              }
            ]
          },
          "error": "Invalid feature in list"
        }
      ]
    }
  EOF
}

variable "ntp_servers" {
  type = map(string)
  default = {}
  description = <<-EOF
    {
      "description": "Map of NTP servers keyed by server IP address with SHA256 authentication strings as values",
      "display_name": "NTP Servers",
      "validators": [
        {
          "type": "map_key_validators",
          "args": {
            "validators": [
              {
                "type": "string_regex",
                "args": {
                  "pattern": "^((22[0-3]|2[0-1][0-9]|1[0-9]{2}|[1-9]?[0-9])(\\.)){3}(22[0-3]|2[0-1][0-9]|1[0-9]{2}|[1-9]?[0-9])$"
                },
                "error": "Each map key must be a valid IPv4 unicast address"
              }
            ]
          },
          "error": "Invalid map key"
        },
        {
          "type": "map_value_string_validators",
          "args": {
            "validators": [
              {
                "type": "string_regex",
                "args": {
                  "pattern": "^[A-Fa-f0-9]{64}$"
                },
                "error": "SHA256 value must contain exactly 64 hexadecimal characters"
              }
            ]
          },
          "error": "Invalid map value"
        }
      ]
    }
  EOF
}
 