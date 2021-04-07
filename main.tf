terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

# define provider
provider "google" {
  credentials = file(var.credentials_file)
  project = var.project 
  region  = var.region
  zone    = var.zone 
}

# create a vpc network
resource "google_compute_network" "vpc_network" {
  name = "vpc-network-1"
  auto_create_subnetworks = false
}

# create subnet-us-east4-100
resource "google_compute_subnetwork" "staging" {
    name = "subnet-us-east4-100"
    ip_cidr_range = "192.168.5.0/24"
    region = "us-east4"
    network = google_compute_network.vpc_network.name
}

# create subnet-us-east4-200
resource "google_compute_subnetwork" "production" {
    name = "subnet-us-east4-200"
    ip_cidr_range = "192.168.6.0/24"
    region = "us-east4"
    network = google_compute_network.vpc_network.name
}

# create a firewall - allow tcp:80
resource "google_compute_firewall" "http" {
  name    = "vpc-network-1-allow-http"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
  target_tags = ["web"]
}

# create a firewall - allow tcp:443
resource "google_compute_firewall" "https" {
  name    = "vpc-network-1-allow-https"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }
  target_tags = ["web"]
}
# create a firewall - allow tcp:ssh
resource "google_compute_firewall" "ssh" {
  name    = "vpc-network-1-allow-ssh"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  target_tags = ["web", "backend"]
}