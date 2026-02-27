#  Supply Chain Network Planner

An interactive R Shiny app that visualizes how a product is 
produced and distributed — from raw materials to end customer.

## Business Problem
Supply chain teams lack visibility into how products flow through 
their network. This app makes the entire Bill of Materials and 
distribution structure instantly explorable.

## What This App Does
- Visualizes **Bill of Materials** as an interactive network diagram
- Maps **Production & Distribution network** by product
- Filter by product to explore different supply chains
- Built with hierarchical layout for clear upstream/downstream view

##  Technical Stack
R, Shiny, bslib, visNetwork, tidyverse

## 🗂️ Files
| File | Description |
|------|-------------|
| `Network.R` | Main Shiny app code |
| `bom_prod_edges_data.csv` | BOM network edges |
| `bom_prod_nodes_data.csv` | BOM network nodes |
| `prod_dist_edges_data.csv` | Distribution network edges |
| `prod_dist_nodes_data.csv` | Distribution network nodes |
