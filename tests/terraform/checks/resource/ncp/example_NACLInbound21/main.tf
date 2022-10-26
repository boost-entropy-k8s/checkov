resource "ncloud_network_acl_rule" "pass" {
  network_acl_no    = ncloud_network_acl.nacl.id

  inbound {
    priority    = 100
    protocol    = "TCP"
    rule_action = "ALLOW"
    ip_block    = "10.3.0.0/18"
    port_range  = "21"
  }
}

resource "ncloud_network_acl_rule" "pass1" {
  network_acl_no    = ncloud_network_acl.nacl.id

  inbound {
    priority    = 110
    protocol    = "TCP"
    rule_action = "ALLOW"
    ip_block    = "0.0.0.0/0"
    port_range  = "222"
  }

  inbound {
    priority    = 100
    protocol    = "TCP"
    rule_action = "ALLOW"
    ip_block    = "10.0.0.0/32"
    port_range  = "19-22"
  }

  inbound {
    priority    = 120
    protocol    = "TCP"
    rule_action = "DROP"
    ip_block    = "0.0.0.0/0"
    port_range  = "21"
  }

    outbound {
    priority    = 199
    protocol    = "TCP"
    rule_action = "ALLOW"
    ip_block    = "0.0.0.0/0"
    port_range  = "21"
  }
}

resource "ncloud_network_acl_rule" "fail" {
  network_acl_no    = ncloud_network_acl.nacl.id

  inbound {
    priority    = 100
    protocol    = "TCP"
    rule_action = "ALLOW"
    ip_block    = "0.0.0.0/0"
    port_range  = "21"
  }
}

resource "ncloud_network_acl_rule" "fail1" {
  network_acl_no    = ncloud_network_acl.nacl.id

  inbound {
    priority    = 100
    protocol    = "TCP"
    rule_action = "ALLOW"
    ip_block    = "::/0"
    port_range  = "21"
  }
}

resource "ncloud_network_acl_rule" "fail2" {
  network_acl_no    = ncloud_network_acl.nacl.id

  inbound {
    priority    = 100
    protocol    = "TCP"
    rule_action = "ALLOW"
    ip_block    = "0.0.0.0/0"
    port_range  = "3-40"
  }
}