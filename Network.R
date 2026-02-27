library(shiny)
library(tidyverse)
library(bslib)
library(visNetwork)

data_bom_prod_edges_data <- read_csv("bom_prod_edges_data.csv")
data_bom_prod_nodes_data <- read_csv("bom_prod_nodes_data.csv")
unique_group <- unique(data_bom_prod_nodes_data$group)
unique_nodes <- unique(data_bom_prod_nodes_data$node_type)
data_demand_confirmation <- read_csv("demand_confirmation.csv")
unique_products<- unique(data_demand_confirmation$product_id)
data_prod_dist_edges_data <- read_csv("prod_dist_edges_data.csv")
data_prod_dist_nodes_data <- read_csv("prod_dist_nodes_data.csv")
data_supply_confirmation <- read_csv("supply_confirmation.csv")


ui <- page_sidebar(
  title = " Supply Chain Network Planner",
  theme = bs_theme(bootswatch = "minty"),
  
  #sidebar
  sidebar = sidebar(
    "Planning Parameters",
    
    selectInput(
      inputId = "product",
      label = "Select Product:",
      choices = unique_products
    )
  ),
  
  #main content
  navset_tab(
    nav_panel(
      title = "How My product is produced and distributed?",
      
      layout_column_wrap(
        card(
          card_header("Bill of Materials and Production Resources"),
          card_body(
            selectInput(
              inputId = "group",
              label = NULL,
              choices = unique_group
            ),
            visNetworkOutput(outputId = "plot_1")
          ),
          height = "1000px"
        ),
        card(
          card_header("Production and Distribution Network"),
          card_body(
            selectInput(
              inputId = "nodes",
              label = NULL,
              choices = unique_nodes
            )
          ),
          visNetworkOutput(outputId = "plot_2"),
          height = "1000px" 
        )
        
      )),
    nav_panel(
      title = "How")
  )
  
)

server <- function(input, output, session) {
  data_nodes = reactive(
    data_bom_prod_nodes_data%>%
      filter(product_id == input$product)
  )
  data_edges = reactive(
    data_bom_prod_edges_data%>%
      filter(product_id == input$product)
  )
  output$plot_1 = renderVisNetwork(
    visNetwork(nodes = data_nodes(), edges = data_edges())%>% visHierarchicalLayout()
  )
  data_prod_nodes = reactive(
    data_prod_dist_nodes_data%>%
      filter(product_id == input$product)
  )
  data_prod_edges = reactive(
    data_prod_dist_edges_data%>%
      filter(product_id == input$product)
  )
  output$plot_2 = renderVisNetwork(
    visNetwork(nodes = data_prod_nodes(), edges = data_prod_edges())%>% visHierarchicalLayout()
  )
  
}

shinyApp(ui, server)