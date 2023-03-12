terraform {
  cloud {
    organization = "ss027n4-home"

    workspaces {
      name = "use2-temp-workstation"
    }
  }
}